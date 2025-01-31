import '../entities/project.dart';

abstract class ProjectRepository {
  Future<List<Project>> getProjects([String? query]);
  Future<Project> getProjectById(int id);
  Future<void> createProject(Project project);
  Future<void> updateProject(Project project);
  Future<void> deleteProject(int id);
}
