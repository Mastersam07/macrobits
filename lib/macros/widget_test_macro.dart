import 'dart:async';
import 'package:macros/macros.dart';

macro class WidgetTestMacro implements ClassDeclarationsMacro {
  const WidgetTestMacro();

  @override
  FutureOr<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {
    final className = clazz.identifier.name;

    // Ensure the necessary imports for widget testing are included
    builder.declareInLibrary(DeclarationCode.fromParts([
      'import \'package:flutter/material.dart\';\n',
      'import \'package:flutter_test/flutter_test.dart\';\n\n',
    ]));

    // Generate a utility method for pumping the widget
    builder.declareInType(DeclarationCode.fromParts([
      'Future<void> pumpWidgetTest(WidgetTester tester) async {\n',
      '  await tester.pumpWidget(MaterialApp(\n',
      '    home: $className(),\n',
      '  ));\n',
      '}\n\n',
    ]));

    // Generate a utility method for finding the widget by type
    builder.declareInType(DeclarationCode.fromParts([
      'void verifyWidgetRendered(WidgetTester tester) {\n',
      '  expect(find.byType($className), findsOneWidget);\n',
      '}\n',
    ]));
  }
}
