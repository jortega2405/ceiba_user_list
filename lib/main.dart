import 'package:ceiba_user_list/utils/theme_app.dart';
import 'package:ceiba_user_list/views/screens/screens.dart';
import 'package:flutter/material.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prueba de Ingreso',
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      );
  }
}
