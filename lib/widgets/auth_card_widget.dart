import 'package:elan_app/providers/user.dart';
import 'package:elan_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String userName = "";

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Username",
                      labelText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    cursorHeight: 20.0,
                    validator: (value) {
                      if (value == null) {
                        return "Invalid Input";
                      } else if (value.length < 10) {
                        return "Enter a username of atleast 10 characters";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) {
                      setState(() {
                        userName = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                var valid = _formKey.currentState?.validate();
                if (valid == true) {
                  setState(
                    () {
                      _formKey.currentState?.save();
                      Provider.of<UserMessages>(context, listen: false)
                          .addUser(userName);
                      Navigator.of(context).pushReplacementNamed(
                        HomeScreen.routeName,
                        arguments: userName,
                      );
                    },
                  );
                }
              },
              child: const Text(
                "Let's go !!!",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
