import 'package:chatapp/models/chatModel.dart';
import 'package:chatapp/screens/chatRoom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatCard extends StatelessWidget {
  final ChatModel chatModel;
  final ChatModel sourceChat;
  ChatCard({this.chatModel,this.sourceChat});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatRoom(chatModel: chatModel,sourceChat: sourceChat,)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 30,
              child: SvgPicture.asset(
              chatModel.isGroup ? "assets/images/groups.svg" : "assets/images/person.svg",
              color: Colors.white,
              height: 36,
              width: 36,
            ),),
            trailing: Text(chatModel.time),
            title: Text(
              chatModel.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  chatModel.currentMessage,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 80,right: 20.0),
            child: Divider(thickness: 1.5,),
          )
        ],
      ),
    );
  }
}
