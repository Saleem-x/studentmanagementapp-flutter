import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/bloc/Search/searchscreen_bloc.dart';
import 'package:student_management/bloc/editscreen/editscreen_bloc.dart';
import 'package:student_management/bloc/home/homescreen_bloc.dart';
import 'package:student_management/bloc/inputpage/input_page_bloc.dart';
import 'package:student_management/db/models/db_models.dart';
import 'package:student_management/screens/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  await Hive.openBox<StudentModel>('student.db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InputPageBloc>(
          create: (context) => InputPageBloc(),
        ),
        BlocProvider<HomeScreenBloc>(
          create: (context) => HomeScreenBloc(),
        ),
        BlocProvider<EditscreenBloc>(
          create: (context) => EditscreenBloc(),
        ),
        BlocProvider<SearchscreenBloc>(
          create: (context) => SearchscreenBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.cyan),
        home: const HomeScreen(),
      ),
    );
  }
}
