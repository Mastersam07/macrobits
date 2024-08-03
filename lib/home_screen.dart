import 'package:flutter/material.dart';
import 'macros/route_macro.dart';
import 'macros/widget_test_macro.dart';

@WidgetTestMacro()
@RouteMacro()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Text('Welcome to the Home Screen'),
      ),
    );
  }
}
