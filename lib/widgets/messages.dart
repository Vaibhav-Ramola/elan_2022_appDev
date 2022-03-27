import 'package:elan_app/models/message_instance.dart';
import 'package:elan_app/providers/user.dart';
import 'package:elan_app/widgets/chat_bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Messages extends StatelessWidget {
  final String otherUserId;
  const Messages(this.otherUserId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<UserMessages>(context, listen: false)
          .fetchMsgStream(otherUserId),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting ||
            !chatSnapshot.hasData) {
          return Center(
            child: Lottie.asset("assets/animations/message_loading.json"),
          );
        }
        List<MsgInstance> msgList = chatSnapshot.data as List<MsgInstance>;
        return RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
            );
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return Align(
                child: ChatBubble(
                  msgList[index].textMsg,
                  msgList[index].sentByMe,
                ),
              );
            },
            itemCount: msgList.length,
          ),
        );
      },
    );
  }
}
