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
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
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
          const Divider(),
          Row(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Don't have an account ?"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  onPressed: () {
                    //  Add SignUp logic here
                  },
                  child: const Text("SignUp"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
