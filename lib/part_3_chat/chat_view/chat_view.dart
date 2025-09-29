import 'package:caremixer_test/config/layout_config/layout_config.dart';
import 'package:caremixer_test/part_3_chat/chat_model/chat_model.dart';
import 'package:caremixer_test/part_3_chat/chat_provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

    final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final ChatProvider viewModel = ChatProvider.of(context)!;
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final newMessage = ChatModel(
      messageType: "OWNER",
      message: text,
      messageTimestamp: DateTime.now(),
    );

    viewModel.chatViewModel.addMessage(newMessage);
    _controller.clear();

    // Scroll to bottom after short delay
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  @override 
  Widget build(BuildContext context) {
    return LayoutConfig(
        appBarTitle: 'Chat',
        currentIndex: 2,
        child: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatModel>>(
              stream: ChatProvider.of(context)!.chatViewModel.chatList,
              builder: (context, snapshot) {
               
                final messages = snapshot.data ?? [];
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                  
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      child: Align(
                        alignment:msg.messageType == "OWNER" ? Alignment.centerLeft : Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: msg.messageType == "OWNER" 
                            ?  Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.24).round())
                            : Theme.of(context).colorScheme.onPrimary.withAlpha((255 * 0.24).round()),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                msg.message!,
                                style: Theme.of(context).textTheme.labelSmall,
                             ),
                             Text(
                                DateFormat('EEEE, d MMM yyyy HH:mm:ss').format(msg.messageTimestamp!),
                                style: Theme.of(context).textTheme.bodySmall,
                             ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          )
        ],
      ));
  }
}