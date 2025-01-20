import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/project.dart';
import '../../domain/datasource/project_datasource.dart';
import '../../domain/mappers/project_mapper.dart';

class LocalProjectDataSource implements ProjectDatasource {
  static final LocalProjectDataSource _instance =
      LocalProjectDataSource._internal();

  LocalProjectDataSource._internal();

  factory LocalProjectDataSource(Database database) {
    _instance._database = database;
    return _instance;
  }

  Database? _database;

  Database get database => _database!;

  static const nameTable = 'projects';

  @override
  Future<List<Project>> getProjects([String? query]) async {
    final db = database;

    if (query != null) {
      const searchableFields = ['name', 'location', 'price'];

      final whereClauses =
          searchableFields.map((field) => '$field LIKE ?').toList();
      final whereString = whereClauses.join(' OR ');
      final whereArgs = List.filled(searchableFields.length, '%$query%');

      final projects = await db.query(
        nameTable,
        where: whereString,
        whereArgs: whereArgs,
      );

      return projects.map((project) => ProjectMapper.fromMap(project)).toList();
    }

    final projects = await db.query(nameTable);

    return projects.map((project) {
      return ProjectMapper.fromMap(project);
    }).toList();
  }

  @override
  Future<Project> getProjectById(int id) async {
    final db = database;
    final projects = await db.query(
      nameTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (projects.isEmpty || projects.length > 1) {
      throw Exception('Search error or item not found');
    }

    final project = projects
        .map((project) {
          return ProjectMapper.fromMap(project);
        })
        .toList()
        .first;

    return project;
  }

  @override
  Future<void> createProject(Project project) async {
    try {
      final db = database;
      await db.insert(nameTable, ProjectMapper.toMap(project));
    } catch (e) {
      log(e.toString(), name: 'Save project');
    }
  }

  @override
  Future<void> deleteProject(int id) async {
    final db = database;
    await db.delete(
      nameTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> updateProject(Project project) async {
    final db = database;
    await db.update(
      nameTable,
      ProjectMapper.toMap(project),
      where: 'id = ?',
      whereArgs: [project.id],
    );
  }
}
