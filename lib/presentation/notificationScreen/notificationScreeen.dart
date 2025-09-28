import 'package:flutter/material.dart';


class NotificationScreen extends StatefulWidget {
  final String id;
   const NotificationScreen({super.key,required this.id});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    // final message = ModelRoute.of(context)!.setting.argument;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Message'),

      ),
      body: Container(
        child: Center(child: Text("Notification page"+widget.id)),
      ),
    );
  }
}
