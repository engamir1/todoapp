import 'package:bmi/my_observer.dart';
import 'package:bmi/news/cubit/news_cubit.dart';
import 'package:bmi/news/network/dio_helpr.dart';
import 'package:bmi/todo/main_view.dart';
import 'package:bmi/todo/task_cubit/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/adapters.dart';

import 'todo/models/task_model.dart';

void main() async {
  // observe cubit states when changed
  Bloc.observer = MyBlocObserver();
  // make dio object at start of app
  DioHelper.init();
  // register task object for Hive
  Hive.registerAdapter(TaskModelAdapter());
  // init Hive for flutter
  await Hive.initFlutter();
  // await open new box named "todos" to stroe data
  await Hive.openBox<TaskModel>("todos");
  // run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // multibloc for using more than one bloccubit in project
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit(),
        ),
        BlocProvider(
          create: (context) => NewsCubit(),
        ),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    NewsCubit cubit = BlocProvider.of<NewsCubit>(context);

    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bmi App',
          // light theme
          theme: ThemeData(
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // floatingActionButtonTheme: FloatingActionButtonThemeData(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(40),
            //   ),
            //   backgroundColor: Colors.deepOrange,
            // ),
            primarySwatch: Colors.deepOrange,
            // iconButtonTheme: IconButtonThemeData(
            //   style: ButtonStyle(
            //     backgroundColor:
            //         // change background color
            //         MaterialStateProperty.all<Color>(Colors.deepOrange),
            //   ),
            // ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
            useMaterial3: true,
          ),
          // dark theme
          darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              useMaterial3: true,
              scaffoldBackgroundColor: HexColor("333739"),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
              appBarTheme: AppBarTheme(
                iconTheme: const IconThemeData(size: 30, color: Colors.white),
                titleTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 25),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor("333739"),
                  statusBarBrightness: Brightness.dark,
                ),
                backgroundColor: HexColor("333739"),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor("333739"),
                unselectedItemColor: Colors.grey,
              )),

          //toggle between themes
          themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
          //change directionm of app from left to right use Directionality
          home: Directionality(
              textDirection:
                  cubit.isLeft ? TextDirection.ltr : TextDirection.rtl,
              child: const TodoMainPage()),
        );
      },
    );
  }
}
