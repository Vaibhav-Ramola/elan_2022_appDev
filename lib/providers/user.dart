import 'package:elan_app/models/message_instance.dart';
import 'package:elan_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class UserMessages with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Map<String, List<MsgInstance>>> _msgs = [];
  List<User> _users = [];
  User _myUser = User(
    userId: "",
    isOnline: false,
    userName: "",
  );

  List<Map<String, List<MsgInstance>>> get msgs {
    return [..._msgs];
  }

  List<User> get users {
    return [..._users];
  }

  Future<void> addUser(String user) async {
    _myUser = User(userId: "", isOnline: true, userName: user);
    final url = Uri.parse(
        "https://elan-app-cec32-default-rtdb.firebaseio.com/users.json");
    await http.post(
      url,
      body: json.encode(
        {
          "userName": user,
          "messages": {},
          "isOnline": true,
          "userID": DateTime.now().toIso8601String(),
        },
      ),
    );

    return Future.value();
  }

  Future<void> deleteUser(String userId) async {
    final url = Uri.parse(
        "https://elan-app-cec32-default-rtdb.firebaseio.com/users/$userId.json");
    await http.delete(url); //.then(
    //(value) => //print("User Deleted"),
    //);
  }

  Stream<List<User>> get fetchAndSetUsersStream async* {
    yield await fetchAndSetUsers();
  }

  Future<List<User>> fetchAndSetUsers() async {
    _users = [];
    final url = Uri.parse(
        "https://elan-app-cec32-default-rtdb.firebaseio.com/users.json");
    try {
      final response = await http.get(url);

      //print(json.decode(response.body));

      Map<String, dynamic> responseData =
          json.decode(response.body) as Map<String, dynamic>;
      responseData.forEach(
        (key, value) {
          Map<String, dynamic> data = value as Map<String, dynamic>;
          bool isOnline = data["isOnline"] as bool;
          String name = data["userName"] as String;
          _users.add(
            User(
              userId: key,
              isOnline: isOnline,
              userName: name,
            ),
          );
        },
      );
      _myUser =
          _users.firstWhere((element) => element.userName == _myUser.userName);
      //print("My user ID : " + _myUser.userId);
      _users.removeWhere((element) => element.userName == _myUser.userName);
    } catch (error) {
      //print(error);
    }
    return [..._users];
  }

  Stream<List<MsgInstance>> fetchMsgStream(String otherUserId) =>
      Stream.periodic(const Duration(milliseconds: 500)).asyncMap(
        (event) => fetchAndSetMessages(otherUserId),
      );

  Stream<List<MsgInstance>> getMsgListStream(String otherUserId) {
    return Stream<List<MsgInstance>>.fromFuture(
      fetchAndSetMessages(otherUserId),
    );
  }

  Future<List<MsgInstance>> fetchAndSetMessages(String otherUserId) async {
    List<MsgInstance> msgList = [];
    // print("MY ID : " + _myUser.userId);
    // print("Other user ID : " + otherUserId);
    final url = Uri.parse(
      "https://elan-app-cec32-default-rtdb.firebaseio.com/users/${_myUser.userId}/messages/$otherUserId.json",
    );
    try {
      final response = await http.get(url);
      // print("value of response : " + response.body);
      if (response.contentLength == 0) {
        return msgList;
      }
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      responseData.forEach((key, value) {
        msgList.add(
          MsgInstance(
            dateTime: DateTime.parse(value["dateTime"]),
            sentByMe: value["byMe"],
            textMsg: value["text"],
          ),
        );
      });
    } catch (e) {
      // print(e.toString());
    }
    return msgList;
  }

  Future<void> deleteUserMessages(String hisId) async {
    final url = Uri.parse(
        "https://elan-app-cec32-default-rtdb.firebaseio.com/users/${_myUser.userId}/messages/$hisId.json");
    final url1 = Uri.parse(
        "https://elan-app-cec32-default-rtdb.firebaseio.com/users/$hisId.json");
    try {
      await http.patch(
        url1,
        body: json.encode(
          {
            "isOnline": false,
          },
        ),
      );
      await http.delete(url);
    } catch (e) {
      // print(e.toString());
    }
  }

  Future<void> unBlockUser(String id) async {
    final url = Uri.parse(
        "https://elan-app-cec32-default-rtdb.firebaseio.com/users/$id.json");
    try {
      await http.patch(
        url,
        body: json.encode(
          {
            "isOnline": true,
          },
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendMsg(String myId, String hisId, String msg) async {
    // print("His ID : " + hisId);
    // print("My ID : " + myId);
    final urlToMe = Uri.parse(
        "https://elan-app-cec32-default-rtdb.firebaseio.com/users/$myId/messages/$hisId.json");
    final urlToHim = Uri.parse(
        "https://elan-app-cec32-default-rtdb.firebaseio.com/users/$hisId/messages/$myId.json");
    try {
      await http.post(
        urlToMe,
        body: json.encode(
          {
            "text": msg,
            "byMe": true,
            "dateTime": DateTime.now().toIso8601String(),
          },
        ),
      );

      await http.post(
        urlToHim,
        body: json.encode(
          {
            "text": msg,
            "byMe": false,
            "dateTime": DateTime.now().toIso8601String(),
          },
        ),
      );
    } catch (e) {
      // print(e.toString());
    }
  }

  String get myUserName {
    return _myUser.userName;
  }

  String get myUserId {
    return _myUser.userId;
  }

  bool get myUserIsOnline {
    return _myUser.isOnline;
  }
}
