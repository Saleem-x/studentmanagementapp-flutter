import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/db/models/db_models.dart';
import 'package:student_management/screens/detailedview.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<StudentModel> studentList =
      Hive.box<StudentModel>('student.db').values.toList();
  late List<StudentModel> studentsearch = List<StudentModel>.from(studentList);

  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),  
          child: Column(
            children: [
              TextFormField(
                controller: searchcontroller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      clear();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                onChanged: (value) => search(value),
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      StudentModel stu = studentsearch[index];
                      File? image;
                      if (stu.imgpath != 'no-img') {
                        image = File(stu.imgpath!);
                      }
                      if (studentList.isEmpty) {
                        return const Text('NO Students Matching');
                      } else {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Detailedview(
                                      name: stu.name,
                                      age: stu.age,
                                      std: stu.std,
                                      phone: stu.phone,
                                      id: stu.id!,
                                      imagepath: stu.imgpath,
                                    );
                                  },
                                ),
                              );
                            },
                            title: Text(stu.name),
                            leading: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(20),
                                  child: (image != null)
                                      ? Image.file(
                                          image,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset('assets/images/person.jpg'),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemCount: studentsearch.length),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> search(String value) async {
    setState(() {
      studentsearch = studentList
          .where((element) => element.name.contains(value.trim()))
          .toList();
    });
  }

  void clear() {
    searchcontroller.clear();
  }
}
