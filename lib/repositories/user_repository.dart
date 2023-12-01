import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dartz/dartz.dart';

class UserRepository {

  //aws amplify signup setup
  Future <Either<String, SignUpResult>> signUp(
    String username, email, password) async{

    // email for user login  
    final Map<AuthUserAttributeKey, String> userAttributes = {
      AuthUserAttributeKey.email: email
    };

    try {
      final result = await Amplify.Auth.signUp(
        username: username, 
        password: password,
        options: SignUpOptions(userAttributes: userAttributes)
        );
        return right(result);
    } on  AuthException catch (e) {
      return left(e.message);
    }
  }
}
