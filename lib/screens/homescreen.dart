import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/bloc/home/homescreen_bloc.dart';
import 'package:student_management/bloc/home/homescreen_state.dart';
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
                builder: (context) => SearchPage(),
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
            //! bloc builder Building Widget according to the state
            child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
              builder: (context, state) {
                log(studentlistnotifier.length.toString());
                return state.studentlist.isEmpty
                    ? const Center(
                        child: Text(
                          'No Students Available\nCreate Students',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: ((context, index) {
                          StudentModel stu = state.studentlist[index];
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
                                        : Image.asset(
                                            'assets/images/person.jpg'),
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
                                              InputBottomsheet(
                                            student: stu,
                                            index: index,
                                          ),
                                        ));
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        deletewarning(stu, context, index);
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
                        itemCount: state.studentlist.length);
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return InputPage();
            },
          ));
        },
      ),
    );
  }

  Future<void> deletewarning(
      StudentModel student, BuildContext context, int index) async {
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
                deletestudent(context, index);
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
