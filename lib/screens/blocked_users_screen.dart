import 'package:elan_app/models/user.dart';
import 'package:elan_app/providers/user.dart';
import 'package:elan_app/screens/user_message_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen({Key? key}) : super(key: key);

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  @override
  Widget build(BuildContext context) {
    List<User> users = Provider.of<UserMessages>(context)
        .users
        .where((element) => element.isOnline == false)
        .toList();
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    users[index].userName,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(users[index].userId),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.undo,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          users[index].isOnline = !users[index].isOnline;
                          Provider.of<UserMessages>(context, listen: false)
                              .unBlockUser(users[index].userId);
                        },
                      );
                    },
                  ),
                ),
                const Divider(),
              ],
            ),
          );
        },
        itemCount: users.length,
      ),
    );
  }
}
