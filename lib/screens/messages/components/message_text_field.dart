import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:chatapp_amplify/models/Message.dart';
import 'package:chatapp_amplify/providers/message_provider.dart';
import 'package:chatapp_amplify/providers/user_provider.dart';
import 'package:chatapp_amplify/shared/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MessageTextField extends StatefulWidget {
  const MessageTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  late final TextEditingController _messageController;
  late AuthUser _currentUser;

  @override
  void initState() {
    // TODO: implement initState
    _messageController = TextEditingController();
    _currentUser = context.read<UserProvider>().currentUser!;
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
      
      onFieldSubmitted: (value) async {
        if (value.isNotEmpty) {
          final message = Message(
              userId: _currentUser.userId,
              username: _currentUser.username,
              message: _messageController.text,
              type: "Message",
              createdAt: DateTime.now().toString());
              print(message);
          final response =
              await context.read<MessageProvider>().sendMessage(message);
          response.fold((error) => context.showError(error), (resMessage) {
            if (resMessage != null ) {
              _messageController.clear();
            }
          });
        }
      },
      decoration: InputDecoration(
        hintText: "Type message",
        border: InputBorder.none,
      ),
    );
  }
}
