import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
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

  static const nameTable = 'projects';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'database.db');
    return await openDatabase(path);
  }

  @override
  Future<List<Project>> getProjects() async {
    final db = await database;
    final List<Map<String, dynamic>> projects = await db.query(nameTable);


    return projects.map((project) {
      return ProjectMapper.fromMap(project);
    }).toList();

  }

  @override
  Future<Project> getProjectById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      nameTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    return Project(
      id: maps[0]['id'],
      agencyId: maps[0]['agency_id'],
      name: maps[0]['name'],
      location: maps[0]['location'],
      price: maps[0]['price'],
      imageUrl: maps[0]['image_url'],
    );
  }

  @override
  Future<void> createProject(Project project) async {
    final db = await database;
    await db.insert(
      nameTable,
      {
        'agency_id': project.agencyId,
        'name': project.name,
        'location': project.location,
        'price': project.price,
        'image_url': project.imageUrl,
      },
    );
  }

  @override
  Future<void> deleteProject(int id) async {
    final db = await database;
    await db.delete(
      nameTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> updateProject(Project project) async {
    final db = await database;
    await db.update(
      nameTable,
      {
        'agency_id': project.agencyId,
        'name': project.name,
        'location': project.location,
        'price': project.price,
        'image_url': project.imageUrl,
      },
      where: 'id = ?',
      whereArgs: [project.id],
    );
  }
}
