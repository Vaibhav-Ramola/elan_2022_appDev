import 'package:flutter/material.dart';

class LogoWidget extends StatefulWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  State<LogoWidget> createState() => _LogoWidgetState();
}

class _LogoWidgetState extends State<LogoWidget>
    with SingleTickerProviderStateMixin {
  bool isElevated = false;
  AnimationController? _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (!isElevated) {
      setState(
        () {
          isElevated != isElevated;
        },
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        // border: Border.all(
        //   color: Colors.blue,
        //   style: BorderStyle.solid,
        //   width: 1.5,
        // ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            //blurStyle: BlurStyle.outer,
            color: Colors.grey[600]!,
            spreadRadius: 10,
            offset: const Offset(4, 4),
          ),
          BoxShadow(
            blurRadius: 10.0,
            //blurStyle: BlurStyle.outer,
            color: Colors.grey[50]!,
            spreadRadius: 4.0,
            offset: const Offset(-4, -4),
          )
        ],
      ),
      child: const Text(
        "AmiGos Chat",
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }
}
