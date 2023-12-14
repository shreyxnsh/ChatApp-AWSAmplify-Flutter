import 'package:flutter/material.dart';


class MessageTextField extends StatefulWidget {
  const MessageTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {

  late final TextEditingController _messageController;

  @override
  void initState() {
    // TODO: implement initState
    _messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _messageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _messageController,
      textInputAction: TextInputAction.send,
      onFieldSubmitted: (value) {
        
      },
      decoration: InputDecoration(
        hintText: "Type message",
        border: InputBorder.none,
      ),
    );
  }
}