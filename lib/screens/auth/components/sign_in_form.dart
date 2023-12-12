import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:chatapp_amplify/providers/user_provider.dart';
import 'package:chatapp_amplify/screens/messages/message_screen.dart';
import 'package:chatapp_amplify/shared/extension.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  
  final _formKey = GlobalKey<FormState>();
  late String _username, _password;

  void signIn({required String username, required String password}) async {
    final signInResponse = await context
        .read<UserProvider>()
        .signIn(username: username, password: password);

    signInResponse.fold((error) => context.showError(error), (signInResult) {
      if (signInResult.nextStep.signInStep == AuthSignInStep.done) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MessagesScreen(),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: RequiredValidator(errorText: requiredField),
            decoration: const InputDecoration(hintText: 'Username'),
            textInputAction: TextInputAction.next,
            onSaved: (username) {
              // Save it
              _username = username!;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              validator: RequiredValidator(errorText: "Password is required"),
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
              onSaved: (password) {
                // Save it
                _password = password!;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                signIn(username: _username, password: _password);
              }
            },
            child: context.watch<UserProvider>().isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text("Sign In"),
          ),
        ],
      ),
    );
  }
}
