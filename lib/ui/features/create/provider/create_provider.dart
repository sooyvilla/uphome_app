// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection.dart';
import '../../../../domain/entities/project.dart';
import '../../../../domain/mappers/project_mapper.dart';

final createProvider =
    StateNotifierProvider.autoDispose<CreateNotifier, CreateState>((ref) {
  return CreateNotifier(ref);
});

class CreateNotifier extends StateNotifier<CreateState> {
  CreateNotifier(
    this.ref,
  ) : super(CreateState());

  final Ref ref;

  void updateField(String key, dynamic value) {
    if (_isEmpty(value)) {
      state = state.copyWith(
          fields: Map<String, dynamic>.from(state.fields)..remove(key));
      return;
    }

    state = state.copyWith(
        fields: Map<String, dynamic>.from(state.fields)..[key] = value);
  }

  bool _isEmpty(dynamic value) {
    if (value == null) return true;

    return switch (value) {
      String() => value.isEmpty,
      int() => value == 0,
      double() => value == 0.0,
      List() => value.isEmpty,
      Map() => value.isEmpty,
      _ => false
    };
  }

  Future<void> createProject() async {
    state = state.copyWith(isLoading: true);

    Map<String, dynamic> fields = state.fields;

    final allProjects = await ref.read(projectRepositoryProvider).getProjects();
    final id = allProjects.length + 1;

    fields['id'] = id;
    fields['agency_id'] = 10; // todo: modificar por el id de la agencia

    try {
      final project = ProjectMapper.fromMap(fields);
      await ref.read(projectRepositoryProvider).createProject(project);
      state = state.copyWith(newProject: project);
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  bool validateFields() {
    final fields = state.fields;

    final listKeys = [
      'name',
      'location',
      'price',
      'image_url',
    ];

    for (final key in listKeys) {
      if (!fields.containsKey(key) || fields[key] == null) {
        return false;
      }
    }

    return true;
  }
}

class CreateState {
  final Map<String, dynamic> fields;
  final bool isLoading;
  final Project? newProject;
  CreateState({
    this.fields = const {},
    this.isLoading = false,
    this.newProject,
  });

  CreateState copyWith({
    Map<String, dynamic>? fields,
    bool? isLoading,
    Project? newProject,
  }) {
    return CreateState(
      fields: fields ?? this.fields,
      isLoading: isLoading ?? this.isLoading,
      newProject: newProject ?? this.newProject,
    );
  }
}
