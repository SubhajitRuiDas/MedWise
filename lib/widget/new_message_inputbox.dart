// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_tech_app/utils/colors_util.dart';

class NewMessageInputbox extends StatefulWidget{
  const NewMessageInputbox({super.key});

  @override
  State<NewMessageInputbox> createState() {
    return _NewMessageInputbox();
  }
}

class _NewMessageInputbox extends State<NewMessageInputbox>{
  final _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _sendChatMessageToModel() async{
    final enteredChatText = _textEditingController.text;

    if(enteredChatText.trim().isEmpty){
      return;
    }

    // after check the user data
    FocusScope.of(context).unfocus();
    
    // final user = FirebaseAuth.instance.currentUser!;
    // final userData = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
    // //send chat data to firebase
    // FirebaseFirestore.instance.collection("chat").add({
    //   "text" : enteredChatText,
    //   "createdAt" : Timestamp.now(),
    //   "userId" : user.uid,
    //   "userName" : userData.data()!["username"],
    //   "userImage" : userData.data()!["image_url"],
    // });

    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 2, bottom: 15),
      child: Row(
        children: [
          Expanded(child: 
          TextField(
            controller: _textEditingController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: const InputDecoration(
              labelText: "Send a message....",
            ),
          ),
          ),
          IconButton(
            onPressed: () {
              _sendChatMessageToModel();
            }, 
            icon: const Icon(Icons.send),
            color: buttonColor,
          ),
        ],
      ),
    );
  }
}