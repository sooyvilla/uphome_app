import '../../domain/datasource/project_datasource.dart';
import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectDatasource dataSource;

  ProjectRepositoryImpl(this.dataSource);

  @override
  Future<List<Project>> getProjects([String? query]) {
    return dataSource.getProjects(query);
  }

  @override
  Future<Project> getProjectById(int id) {
    return dataSource.getProjectById(id);
  }

  @override
  Future<void> createProject(Project project) {
    return dataSource.createProject(project);
  }

  @override
  Future<void> deleteProject(int id) {
    return dataSource.deleteProject(id);
  }

  @override
  Future<void> updateProject(Project project) {
    return dataSource.updateProject(project);
  }
}
