import 'package:flutter/material.dart';

class ShareWidget extends StatefulWidget {
  const ShareWidget({Key? key}) : super(key: key);

  @override
  State<ShareWidget> createState() => _ShareWidgetState();
}

class _ShareWidgetState extends State<ShareWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("ShareWidget!"),
      ),
    );
  }
}