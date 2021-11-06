import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityCheck extends StatelessWidget {
  final Widget? child;

  const ConnectivityCheck({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == ConnectivityResult.none) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No InternetConnection')),
            );
          }
          return child!;
        },
      ),
    );
  }
}
