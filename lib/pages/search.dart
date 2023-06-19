import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/bloc/Search/searchscreen_bloc.dart';
import 'package:student_management/db/models/db_models.dart';
import 'package:student_management/screens/detailedview.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  List<StudentModel> studentList =
      Hive.box<StudentModel>('student.db').values.toList();
  late List<StudentModel> studentsearch = List<StudentModel>.from(studentList);

  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //! reading state with empty argument for initial state
    BlocProvider.of<SearchscreenBloc>(context)
        .add(OnSearch(studentlist: studentList, value: ''));
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
                      searchcontroller.clear();
                      //! reading State when text form cleared
                      BlocProvider.of<SearchscreenBloc>(context)
                          .add(OnSearch(studentlist: studentList, value: ''));
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                onChanged: (value) {
                  search(value);
                  //! reading state when user input
                  BlocProvider.of<SearchscreenBloc>(context)
                      .add(OnSearch(studentlist: studentList, value: value));
                },
              ),
              Expanded(
                //! building searched data
                child: BlocBuilder<SearchscreenBloc, SearchscreenState>(
                  builder: (context, state) {
                    return state.studentlist.isEmpty
                        //? empty message
                        ? const Center(
                            child: Text('NO Students Matching'),
                          )
                        :
                        //? listing data
                        ListView.separated(
                            itemBuilder: (context, index) {
                              StudentModel stu = state.studentlist[index];
                              File? image;
                              if (stu.imgpath != 'no-img') {
                                image = File(stu.imgpath!);
                              }
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
                                            : Image.asset(
                                                'assets/images/person.jpg'),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemCount: state.studentlist.length,
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//? searchinig function
  Future<void> search(String value) async {
    studentsearch = studentList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase().trim()))
        .toList();
  }
}
