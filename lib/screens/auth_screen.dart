import 'package:elan_app/widgets/auth_card_widget.dart';
import 'package:elan_app/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // ignore: unnecessary_const
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                LogoWidget(),
                SizedBox(
                  height: 40,
                ),
                AuthCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
