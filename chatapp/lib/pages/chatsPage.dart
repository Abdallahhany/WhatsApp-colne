import 'package:chatapp/models/chatModel.dart';
import 'package:chatapp/screens/selectContact.dart';
import 'package:chatapp/widgets/chatCard.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final List<ChatModel> chatModel ;
  final ChatModel sourceChat;
  ChatPage({this.chatModel,this.sourceChat});
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chat),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SelectContact()));
        },
      ),
      body: ListView.builder(
          itemCount: widget.chatModel.length,
          itemBuilder: (context,index)=>ChatCard(chatModel: widget.chatModel[index],sourceChat: widget.sourceChat,)),
    );
  }
}
