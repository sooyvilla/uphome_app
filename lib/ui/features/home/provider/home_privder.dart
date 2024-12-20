// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:uphome_app/domain/entities/project.dart';

import '../../../../core/di/injection.dart';

final homeProvider = StateNotifierProvider<HomeProvider, HomeState>((ref) {
  return HomeProvider(ref);
});

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider(this.ref) : super(HomeState());
  final Ref ref;

  void getProjects() async {
    state = state.copyWith(status: HomeStatus.loading);
    try {
      final projects = await ref.read(projectRepositoryProvider).getProjects();
      state = state.copyWith(status: HomeStatus.success, projects: projects);
    } catch (e) {
      state = state.copyWith(status: HomeStatus.error);
    }
  }
}

class HomeState {
  final HomeStatus status;
  final List<Project> projects;

  HomeState({
    this.status = HomeStatus.loading,
    this.projects = const [],
  });

  HomeState copyWith({
    HomeStatus? status,
    List<Project>? projects,
  }) {
    return HomeState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
    );
  }
}

enum HomeStatus {
  loading,
  success,
  error,
}
