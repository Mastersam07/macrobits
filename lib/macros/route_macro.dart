// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:macros/macros.dart';

macro class RouteMacro implements ClassDeclarationsMacro {
  static final List<String> _registeredRoutes = [];
  const RouteMacro();

  @override
  FutureOr<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {
    final className = clazz.identifier.name;
    final routeName = '/${className.toLowerCase()}';

    // Store this route for later batch initialization
    _registeredRoutes.add('$className.registerRoute()');

    // Resolve identifiers for the types we need from flutter/material.dart
    final buildContext = await builder.resolveIdentifier(
      Uri.parse('package:flutter/material.dart'), 'BuildContext');
    final navigator = await builder.resolveIdentifier(
      Uri.parse('package:flutter/material.dart'), 'Navigator');

    // Generate a static method for the route
    builder.declareInType(DeclarationCode.fromParts([
      'static String get route => \'$routeName\';',
    ]));

    // Generate a method for navigating to this route
    builder.declareInType(DeclarationCode.fromParts([
      'static void navigate(', buildContext, ' context, {Object? arguments}) {',
      '\n  ', navigator, '.pushNamed(context, route, arguments: arguments);',
      '\n}',
    ]));
  }
}
