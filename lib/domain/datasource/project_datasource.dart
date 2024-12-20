import '../entities/project.dart';

abstract class ProjectDatasource {
  Future<List<Project>> getProjects();
  Future<Project> getProjectById(int id);
  Future<void> createProject(Project project);
  Future<void> updateProject(Project project);
  Future<void> deleteProject(int id);
}
