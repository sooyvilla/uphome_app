import 'package:sqflite/sqflite.dart';

import '../../domain/datasource/agency_datasource.dart';
import '../../domain/entities/agency.dart';
import '../../domain/mappers/agency_mapper.dart';

class LocalAgencyDatasource implements AgencyDatasource {
  static final LocalAgencyDatasource _instance =
      LocalAgencyDatasource._internal();

  LocalAgencyDatasource._internal();

  factory LocalAgencyDatasource(Database database) {
    _instance._database = database;
    return _instance;
  }

  Database? _database;

  Database get database => _database!;

  static const nameTable = 'agencies';

  @override
  Future<List<Agency>> getAgencies() async {
    final db = database;
    final List<Map<String, dynamic>> agencies = await db.query(nameTable);

    return agencies.map((agency) {
      return AgencyMapper.fromMap(agency);
    }).toList();
  }

  @override
  Future<Agency> getAgencyById(int id) async {
    final db = database;
    final List<Map<String, dynamic>> agencies = await db.query(
      nameTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (agencies.isEmpty) {
      throw Exception('Item not found');
    }

    return AgencyMapper.fromMap(agencies.first);
  }
}
