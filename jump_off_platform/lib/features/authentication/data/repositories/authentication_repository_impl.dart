import 'package:api_sdk/main.dart'; // This import will need fixing later
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<dynamic> signUpWithEmailAndPassword(
      String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // simulate a network delay
    final response = await ApiSdk.signUpWithEmailAndPassword(
        {'email': email, 'password': password});

    return response;
  }

  @override
  Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // simulate a network delay
    final response = await ApiSdk.loginWithEmailAndPassword(
        {'email': email, 'password': password});

    return response;
  }

  @override
  Future<dynamic> getUserData(int id) async {
    final response = await ApiSdk.getUserData(id);

    return response;
  }
} 