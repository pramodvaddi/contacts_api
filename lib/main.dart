import 'package:flutter/material.dart';
import 'package:task_one/pages/index.dart';
import 'package:task_one/theme/colors.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: primary),
    home: const IndexPage(),
  ));
}
