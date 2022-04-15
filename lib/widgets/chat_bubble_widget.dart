import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String msg;
  final bool byMe;

  const ChatBubble(this.msg, this.byMe, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Align(
        alignment: byMe ? Alignment.bottomRight : Alignment.bottomLeft,
        child: Container(
          margin: byMe
              ? EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.25,
                  8.0,
                  8.0,
                  8.0,
                )
              : EdgeInsets.fromLTRB(
                  8.0,
                  8.0,
                  MediaQuery.of(context).size.width * 0.25,
                  8.0,
                ),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.blue,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          child: Text(
            msg,
            style: const TextStyle(),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
