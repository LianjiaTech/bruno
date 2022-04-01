

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class LoadingExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'Loading案例',
      ),
      body: BrnPageLoading(),
    );
  }
}
