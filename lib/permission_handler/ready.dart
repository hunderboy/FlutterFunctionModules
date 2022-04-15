import 'package:flutter/material.dart';

class Ready extends StatelessWidget {
  const Ready({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text('Ready'),
        ),
      ),
    );
  }
}
