import 'package:json/json.dart';

@JsonCodable()
class User {
  final String name;

  final int? age;
}
