import 'package:chatapp_amplify/constants.dart';
import 'package:chatapp_amplify/providers/user_provider.dart';
import 'package:chatapp_amplify/screens/auth/signin_or_signup_screen.dart';
import 'package:chatapp_amplify/screens/messages/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Image.asset("assets/images/welcome_image.png"),
            const Spacer(flex: 3),
            Text(
              "Welcome to our freedom \nmessaging app",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              "Freedom talk any person of your \nmother language.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.64),
              ),
            ),
            const Spacer(flex: 3),
            FutureBuilder(
                future: context.read<UserProvider>().checkedLogedInUser(),
                builder: (context, snapshot) {
                  Future.delayed(Duration(seconds: 1), () {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessagesScreen(),
                            ),
                            (route) => false,
                          );
                        }
                        );
                      }
                    }
                  });
                   return SkipButton();
                }),
       
          ],
        ),
      ),
    );
  }
}

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: TextButton(
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SigninOrSignupScreen(),
                ),
              ),
          child: Row(
            children: [
              Text(
                "Skip",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.8),
                    ),
              ),
              const SizedBox(width: defaultPadding / 4),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.8),
              )
            ],
          )),
    );
  }
}
