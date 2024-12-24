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

  void getProjects([String? query]) async {
    state = state.copyWith(status: HomeStatus.loading);
    if (query?.isEmpty ?? true) {
      query = null;
    }

    try {
      final projects =
          await ref.read(projectRepositoryProvider).getProjects(query);
      state = state.copyWith(status: HomeStatus.success, projects: projects);
    } catch (e) {
      state = state.copyWith(status: HomeStatus.error);
    }
  }

  setQuery(String query) {
    if (query == state.query) return;
    state = state.copyWith(query: query);
  }
}


class HomeState {
  final HomeStatus status;
  final List<Project> projects;
  final String query;

  HomeState({
    this.status = HomeStatus.loading,
    this.projects = const [],
    this.query = '',
  });

  HomeState copyWith({
    HomeStatus? status,
    List<Project>? projects,
    String? query,
  }) {
    return HomeState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      query: query ?? this.query,
    );
  }
}

enum HomeStatus {
  loading,
  success,
  error,
}
