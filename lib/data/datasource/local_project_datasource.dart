import 'package:sqflite/sqflite.dart';
import 'package:uphome_app/domain/mappers/project_mapper.dart';

import '../../../domain/entities/project.dart';
import '../../domain/datasource/project_datasource.dart';

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
  Future<List<Project>> getProjects() async {
    final db = database;
    final List<Map<String, dynamic>> projects = await db.query(nameTable);
    await Future.delayed(const Duration(seconds: 2));

    return projects.map((project) {
      return ProjectMapper.fromMap(project);
    }).toList();
  }

  @override
  Future<Project> getProjectById(int id) async {
    final db = database;
    final List<Map<String, dynamic>> projects = await db.query(
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
    final db = database;
    await db.insert(nameTable, ProjectMapper.toMap(project));
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
