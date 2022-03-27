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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          height: 180,
          width: 240,
          color: Colors.white,
          child: const Center(
            child: Text(
              "AnimosChat",
              style: TextStyle(fontSize: 50, color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
