import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityTracker extends StatelessWidget {
  final Widget whenConnected;
  final Widget whenDisconnected;
  ConnectivityTracker({
    super.key,
    required this.whenConnected,
    required this.whenDisconnected,
  });

  final Connectivity _connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: _connectivity.onConnectivityChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            (snapshot.data![0].name == 'mobile' ||
                snapshot.data![0].name == 'wifi')) {
          return whenConnected;
        }
        return whenDisconnected;
      },
    );
  }
}
