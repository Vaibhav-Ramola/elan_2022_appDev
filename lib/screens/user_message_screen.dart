import 'package:elan_app/providers/user.dart';
import 'package:elan_app/widgets/messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserMessageScreen extends StatefulWidget {
  const UserMessageScreen({Key? key}) : super(key: key);
  static const String routeName = "UserMessageScreen";

  @override
  State<UserMessageScreen> createState() => _UserMessageScreenState();
}

class _UserMessageScreenState extends State<UserMessageScreen> {
  String msg = "";
  final appbar = AppBar();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String hisId = arguments["userId"];
    String name = arguments["name"];
    return Scaffold(
      appBar: AppBar(
        title: Text(name), // Change this to name
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Messages(hisId),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(
              8.0,
              0.0,
              8.0,
              8.0,
            ),
            child: SizedBox(
              child: Form(
                key: _formKey,
                child: TextFormField(
                  cursorHeight: 25,
                  validator: (value) {
                    if (value == null) {
                      return "Invalid msg";
                    } else if (value.isEmpty) {
                      return "Can't send empty message";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      msg = value!;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                      bottom: 10,
                      left: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "message",
                    labelText: "Message",
                    suffix: IconButton(
                      onPressed: () {
                        final isValid = _formKey.currentState?.validate();
                        if (isValid == true) {
                          _formKey.currentState?.save();

                          // call the send function here !!!
                          Provider.of<UserMessages>(context, listen: false)
                              .sendMsg(
                            Provider.of<UserMessages>(context, listen: false)
                                .myUserId,
                            hisId,
                            msg,
                          );
                          initState();
                        }
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.blue,
                        size: 35,
                      ),
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
