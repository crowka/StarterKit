abstract class AuthenticationRepository {
  Future<dynamic> signUpWithEmailAndPassword(String email, String password);
  Future<dynamic> loginWithEmailAndPassword(String email, String password);
  Future<dynamic> getUserData(int id);
} 