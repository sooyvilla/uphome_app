// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection.dart';
import '../../../../domain/entities/agency.dart';

final detailsProvider =
    StateNotifierProvider<DetailsProvider, DetailsState>((ref) {
  return DetailsProvider(ref);
});

class DetailsProvider extends StateNotifier<DetailsState> {
  DetailsProvider(this.ref) : super(DetailsState());

  final Ref ref;

  Future<Agency?> getAgencyById(int id) async {
    try {
      final res = await ref.read(agencyRepositoryProvider).getAgencyById(id);
      state = state.copyWith(agency: res);
      return res;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class DetailsState {
  Agency? agency;
  DetailsState({
    this.agency,
  });

  DetailsState copyWith({
    Agency? agency,
  }) {
    return DetailsState(
      agency: agency ?? this.agency,
    );
  }
}
