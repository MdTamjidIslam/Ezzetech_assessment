
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/home_screen.dart';
import 'views/todo_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: HomeScreen.routeName,
      routes:{
       HomeScreen.routeName:(_)=>HomeScreen(),
        TodoDetailsScreen.routeName :(_)=>TodoDetailsScreen(),
      },
    );
  }
}
