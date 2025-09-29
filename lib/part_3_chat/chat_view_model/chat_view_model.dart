import 'package:caremixer_test/part_3_chat/chat_model/chat_model.dart';
import 'package:rxdart/rxdart.dart';

class ChatViewModel {
  
  final BehaviorSubject<List<ChatModel>> chatList = BehaviorSubject<List<ChatModel>>();

  ChatViewModel() {
    _fetchInitialData();
  }

  _fetchInitialData()async{
      chatList.add([]);
  }

 

  void _addResponse(List<ChatModel> value){
    ChatModel? model =  value.lastWhere((element)=> element.messageType == "OWNER");
        chatList.add([...value,ChatModel(
        messageType: "SYSTEM",
        message: "RESPONSE FOR ${model.message}",
        messageTimestamp: DateTime.now(),
      )]);
  }

  void addMessage(ChatModel newMessage)async {
    final currentMessages = chatList.value;
    chatList.add([...currentMessages, newMessage]);
    await Future.delayed(Duration(seconds: 1));
    _addResponse(chatList.value);
  }

  dispose(){
    chatList.close();
  }
}