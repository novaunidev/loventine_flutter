import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class NetworkInfo extends ChangeNotifier {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  Timer? _throttleTimer;

  void Function()? onConnectivityChangedCallback;

  ConnectivityResult get connectionStatus => _connectionStatus;

  NetworkInfo({this.onConnectivityChangedCallback}) {
    _init();
  }

  Future<void> _init() async {
    _connectionStatus = await _connectivity.checkConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _throttleTimer?.cancel();
    _throttleTimer = Timer(const Duration(seconds: 1), () {
      if (result != _connectionStatus) {
        _connectionStatus = result;
        notifyListeners();
        onConnectivityChangedCallback?.call();
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    _throttleTimer?.cancel();
    super.dispose();
  }
}
