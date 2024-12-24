import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uphome_app/data/datasource/local_agency_datasource.dart';
import 'package:uphome_app/data/repositories/agency_repository_impl.dart';
import 'package:uphome_app/domain/datasource/agency_datasource.dart';
import 'package:uphome_app/domain/repositories/agency_respository.dart';

import '../../data/datasource/local_project_datasource.dart';
import '../../data/repositories/project_repository_impl.dart';
import '../../domain/datasource/project_datasource.dart';
import '../../domain/repositories/project_repository.dart';
import '../config/environment_config.dart';
import '../enums/environment.dart';

final databaseProvider = FutureProvider<Database>((ref) async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, 'database.db');

  bool hasDatabase = await databaseExists(path);

  if (!hasDatabase) {
    ByteData data = await rootBundle.load('assets/db/database.db');
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
  }

  return await openDatabase(path);
});

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(),
  );
});

final projectDataSourceProvider = Provider<ProjectDatasource>((ref) {
  final dbAsyncValue = ref.watch(databaseProvider);

  return dbAsyncValue.maybeWhen(
    data: (db) {
      switch (EnvironmentConfig.current) {
        case Environment.mock:
        case Environment.production:
        case Environment.local:
          return LocalProjectDataSource(db);
      }
    },
    orElse: () => throw Exception("Failed to load database"),
  );
});
final agencyDataSourceProvider = Provider<AgencyDatasource>((ref) {
  final dbAsyncValue = ref.watch(databaseProvider);

  return dbAsyncValue.maybeWhen(
    data: (db) {
      switch (EnvironmentConfig.current) {
        case Environment.mock:
        case Environment.production:
        case Environment.local:
          return LocalAgencyDatasource(db);
      }
    },
    orElse: () => throw Exception("Failed to load database"),
  );
});

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  final dataSource = ref.watch(projectDataSourceProvider);
  return ProjectRepositoryImpl(dataSource);
});

final agencyRepositoryProvider = Provider<AgencyRespository>((ref) {
  final dataSource = ref.watch(agencyDataSourceProvider);
  return AgencyRepositoryImpl(dataSource);
});
