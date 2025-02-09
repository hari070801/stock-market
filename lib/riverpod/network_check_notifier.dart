import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { initial, connected, disconnected }

class NetworkCheckNotifier extends StateNotifier<NetworkStatus> {
  StreamSubscription<ConnectivityResult>? _subscription;

  NetworkCheckNotifier() : super(NetworkStatus.initial) {
    _checkConnectivity();
    _listenToConnectivityChanges();
  }

  Future<void> _checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    _updateState(result);
  }

  void _listenToConnectivityChanges() {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      _updateState(result);
    });
  }

  void _updateState(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      state = NetworkStatus.connected;
    } else {
      state = NetworkStatus.disconnected;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final networkCheckProvider = StateNotifierProvider<NetworkCheckNotifier, NetworkStatus>(
  (ref) => NetworkCheckNotifier(),
);
