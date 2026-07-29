import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciepe_app/cubit/recipe_home_cubit.dart';
import 'package:reciepe_app/screens/recipe_home_screen.dart';
import 'package:reciepe_app/services/api_service.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 226, 227, 227),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 148, 76, 17),
          surface: const Color.fromARGB(255, 226, 227, 227),
        ),
        fontFamily: 'Roboto',
      ),
      // home: const SeafoodScreen(),
      home: BlocProvider(
        create: (context) => RecipeHomeCubit(ApiService(),RecipeHomeInitial()),
        child: HomeScreen(),
      ),
    );
  }
}
