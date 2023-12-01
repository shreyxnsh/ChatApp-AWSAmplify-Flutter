import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:chatapp_amplify/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {

  final _userRepository = UserRepository();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setIsLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  //response to usermail
  Future <Either<String, SignUpResult>> signUp(
    String username, email, password) async{
      _setIsLoading(true);
      final response = await _userRepository.signUp(username, email, password);
      _setIsLoading(false);
      return response;
  }  
}

