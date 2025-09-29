import 'package:caremixer_test/config/layout_config/layout_config.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutConfig(
        appBarTitle: 'Chat',
        currentIndex: 2,
        child:SizedBox(height: 300,width: 400));
  }
}