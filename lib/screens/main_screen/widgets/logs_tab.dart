import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LogsTabs extends StatefulWidget {
  const LogsTabs({Key? key}) : super(key: key);

  @override
  _LogsTabsState createState() => _LogsTabsState();
}

class _LogsTabsState extends State<LogsTabs> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LoaderOverlay(
          overlayColor: const Color.fromRGBO(0, 0, 0, 0.5),
          overlayWidget: const CircularProgressIndicator(
            backgroundColor: Colors.black87,
          ),
          useDefaultLoading: _isLoading,
          child: Container(
            margin: const EdgeInsets.all(12.0),
            width: double.maxFinite,
            color: Colors.amber,
            height: 80.0,
          ),
        ),
      ),
    );
  }
}
