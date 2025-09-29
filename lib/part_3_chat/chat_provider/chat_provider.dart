
import 'package:caremixer_test/part_3_chat/chat_view_model/chat_view_model.dart';
import 'package:flutter/material.dart';

class ChatProvider extends InheritedWidget{

  final ChatViewModel chatViewModel;

  ChatProvider({super.key,Widget? child})
  : chatViewModel =  ChatViewModel(),
    super(child: child!);

  @override
  bool updateShouldNotify(ChatProvider oldWidget){
    return true;
  }

  static ChatProvider? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<ChatProvider>();
  }
}