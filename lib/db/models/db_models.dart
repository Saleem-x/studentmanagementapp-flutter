import 'package:hive_flutter/adapters.dart';
part 'db_models.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String age;
  @HiveField(2)
  String std;
  @HiveField(3)
  String phone;
  @HiveField(4)
  String? imgpath;
  @HiveField(5)
  String? id;

  StudentModel({
    required this.name,
    required this.age,
    required this.std,
    required this.phone,
    this.imgpath,
    this.id,
  });
}
