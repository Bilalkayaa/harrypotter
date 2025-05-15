import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrypotter/ui/bloc/harry_potter_bloc.dart';
import 'package:harrypotter/ui/main_screen.dart';
import 'data/repository/harry_potter_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harry Potter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFD700),
          secondary: Color(0xFF740001),
          tertiary: Color(0xFF1A472A),
          surface: Color(0xFF2A2D3E),
        ),
        cardTheme: CardTheme(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Color(0xFFFFD700),
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          indicatorSize: TabBarIndicatorSize.label,
          indicator: BoxDecoration(),
          dividerColor: Colors.transparent,
        ),
      ),
      home: BlocProvider(
        create:
            (context) => HarryPotterBloc(repository: HarryPotterRepository()),
        child: const MainScreen(),
      ),
    );
  }
}
