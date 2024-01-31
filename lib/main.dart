import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/home_page.dart';
import 'BloC/pet_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PetBloc(),
      child: MaterialApp(
        title: 'Pawfect Match',

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber,
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        themeMode: ThemeMode.system, // Use system theme settings (light/dark)
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
