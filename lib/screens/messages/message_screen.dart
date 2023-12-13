import 'package:chatapp_amplify/constants.dart';
import 'package:chatapp_amplify/providers/user_provider.dart';
import 'package:chatapp_amplify/screens/auth/sign_in_screen.dart';
import 'package:chatapp_amplify/shared/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../models/ChatMessage.dart';
import 'components/chat_input_field.dart';
import 'components/message_tile.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Flutter Dev Chat"),
        actions: [
          IconButton(
            onPressed: () async {
              final response = await context.read<UserProvider>().signOut();
              response.fold((error) => context.showError(error),
                  (result) => Get.to(()=> const SignInScreen()) );
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ListView.builder(
                itemCount: demeChatMessages.length,
                itemBuilder: (context, index) => MessageTile(
                  message: demeChatMessages[index].text,
                  isSender: index == 1,
                ),
              ),
            ),
          ),
          const ChatInputField(),
        ],
      ),
    );
  }
}
