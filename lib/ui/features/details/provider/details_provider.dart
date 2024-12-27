import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection.dart';
import '../../../../domain/entities/agency.dart';

final detailsProvider =
    StateNotifierProvider.autoDispose<DetailsProvider, DetailsState>((ref) {
  return DetailsProvider(ref);
});

class DetailsProvider extends StateNotifier<DetailsState> {
  DetailsProvider(this.ref) : super(DetailsState());

  final Ref ref;

  FlutterBlue flutterBlue = FlutterBlue.instance;

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

  void getBluetoothDevices() {

    flutterBlue.isScanning.listen((isScanning) {
      if (isScanning) return;
    });

    flutterBlue.startScan(timeout: const Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) {
      if (results.isEmpty) return;
      final devices = results.map((result) => result.device).toList();
      state = state.copyWith(bluetoothDevices: devices);
    }).onDone(() {
      flutterBlue.stopScan();
    });
  }
}

class DetailsState {
  Agency? agency;
  List<BluetoothDevice>? bluetoothDevices;

  DetailsState({
    this.agency,
    this.bluetoothDevices,
  });

  DetailsState copyWith({
    Agency? agency,
    List<BluetoothDevice>? bluetoothDevices,
  }) {
    return DetailsState(
      agency: agency ?? this.agency,
      bluetoothDevices: bluetoothDevices ?? this.bluetoothDevices,
    );
  }
}
