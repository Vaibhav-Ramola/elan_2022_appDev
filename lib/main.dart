import 'package:elan_app/providers/user.dart';
import 'package:elan_app/screens/auth_screen.dart';
import 'package:elan_app/screens/home_screen.dart';
import 'package:elan_app/screens/user_message_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserMessages()),
      ],
      child: MaterialApp(
        title: 'AnimosChat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthScreen(),
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
          UserMessageScreen.routeName: (_) => const UserMessageScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
