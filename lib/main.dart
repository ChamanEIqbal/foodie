import 'package:flutter/material.dart';
import 'package:foodie/providers/cart_provider.dart';
import 'package:foodie/providers/menu_provider.dart';
import 'package:foodie/views/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Foodie App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Splashscreen(),
      ),
    );
  }
}