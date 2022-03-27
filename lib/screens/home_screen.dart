import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elan_app/providers/user.dart';
import 'package:elan_app/screens/blocked_users_screen.dart';
import 'package:elan_app/screens/new_explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  String userId = "";

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    Future.delayed(Duration.zero).then(
      (value) {
        userId = ModalRoute.of(context)?.settings.arguments as String;
      },
    );
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
      Provider.of<UserMessages>(context, listen: false).deleteUser(userId);
    }
  }

  int _pageIndex = 0;

  final GlobalKey<CurvedNavigationBarState> _globalKey = GlobalKey();
  final _pages = [
    // const MessagesScreen(),
    const NewExploreScreen(),
    const BlockedUsersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          "AnimosChat",
          style: TextStyle(fontSize: 30),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<UserMessages>(context, listen: false).deleteUser(userId);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: _pages[_pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        animationCurve: Curves.easeInSine,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        color: Colors.blue,
        items: const [
          // Icon(
          //   Icons.message_rounded,
          //   size: 30,
          //   color: Colors.white,
          // ),
          Icon(
            Icons.travel_explore_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.block_rounded,
            size: 30,
            color: Colors.white,
          ),
        ],
        index: 0,
        key: _globalKey,
        onTap: (index) {
          setState(
            () {
              _pageIndex = index;
            },
          );
        },
      ),
    );
  }
}
