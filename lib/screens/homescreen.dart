import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_management/db/functions/db_functions.dart';
import 'package:student_management/db/models/db_models.dart';
import 'package:student_management/pages/bottomsheet.dart';
import 'package:student_management/pages/inputpage.dart';
import 'package:student_management/pages/search.dart';
import 'package:student_management/screens/detailedview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getalldata();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Student List',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ));
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Expanded(
                child: ValueListenableBuilder(
              valueListenable: studentlistnotifier,
              builder: (context, student, child) {
                if (student.isEmpty) {
                  return const Center(child: Text('no students available'));
                } else {
                  return ListView.separated(
                      itemBuilder: ((context, index) {
                        StudentModel stu = student[index];
                        File? image;
                        if (stu.imgpath != 'no-img') {
                          image = File(stu.imgpath!);
                        }
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Detailedview(
                                    name: stu.name,
                                    age: stu.age,
                                    std: stu.std,
                                    phone: stu.phone,
                                    id: stu.id!,
                                    imagepath: stu.imgpath,
                                  ),
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
                            trailing: SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            InputBottomsheet(student: stu),
                                      ));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deletewarning(stu, context);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: student.length);
                }
              },
            ))
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const InputPage(),
            ),
          );
        },
      ),
    );
  }

  Future<void> deletewarning(StudentModel student, BuildContext context) async {
    showDialog(
        context: (context),
        builder: (context1) {
          return AlertDialog(
            title: const Text('Delete'),
            content: const Text('do you want to remove this student'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('NO'),
              ),
              TextButton(
                onPressed: () {
                  deletestudent(student);
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
            ],
          );
        },);
  }
}
