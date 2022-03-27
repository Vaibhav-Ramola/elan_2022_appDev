import 'package:elan_app/models/user.dart';
import 'package:elan_app/providers/user.dart';
import 'package:elan_app/screens/user_message_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NewExploreScreen extends StatefulWidget {
  const NewExploreScreen({Key? key}) : super(key: key);

  @override
  State<NewExploreScreen> createState() => _NewExploreScreenState();
}

class _NewExploreScreenState extends State<NewExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Provider.of<UserMessages>(context, listen: false)
            .fetchAndSetUsersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return Center(
              child: Lottie.asset(
                  "assets/animations/explore_screen_animation.json"),
            );
          } else {
            List<User> users = Provider.of<UserMessages>(context)
                .users
                .where((element) => element.isOnline == true)
                .toList();
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (_, index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                    child: users[index].isOnline
                        ? ListTile(
                            title: Text(
                              users[index].userName,
                              style: const TextStyle(fontSize: 24),
                            ),
                            subtitle: Text(
                              users[index].userId,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.block_rounded),
                              onPressed: () {
                                setState(() {
                                  Provider.of<UserMessages>(context,
                                          listen: false)
                                      .deleteUserMessages(users[index].userId);
                                  users[index].isOnline = false;
                                });
                              },
                              color: Colors.red,
                            ),
                            onTap: users[index].isOnline
                                ? () {
                                    Navigator.of(context).pushNamed(
                                      UserMessageScreen.routeName,
                                      arguments: {
                                        "userId": users[index].userId,
                                        "name": users[index].userName,
                                      },
                                    );
                                  }
                                : null,
                          )
                        : null,
                  ),
                  const Divider(),
                ],
              ),
              itemCount: users.length,
            );
          }
        },
      ),
    );
  }
}
