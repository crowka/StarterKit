import 'package:firebase_auth/firebase_auth.dart';
// TODO: Update this import once UserFromFirebaseUser is migrated to the authentication feature
// import 'package:shared/main.dart'; 
// Assuming UserFromFirebaseUser will be in something like:
import 'package:jump_off_platform/features/authentication/data/models/user_model.dart'; // Or domain/entities depending on its nature

// TODO: Consider making this class implement an abstract AuthRepository or similar from the domain layer.
class AuthService { // Consider renaming to FirebaseAuthService or similar for clarity
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // TODO: Manage error messages more robustly, perhaps by returning Result types or specific exceptions.
  String? errorMessage; // Made nullable as it's not always set before use

  //Create User Object from Firebase User
  Future<UserFromFirebaseUser?> getCurrentUser() async { // Return type and method made nullable friendly
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        String token = await user.getIdToken();
        return _userFromFirebaseUser(user, token);
      } else {
        return null;
      }
    } catch (err) {
      // TODO: Log the actual error (err) for debugging purposes.
      // Avoid print in production code; use a logging framework.
      print(err); 
      errorMessage = getMessageFromErrorCode(err is FirebaseException ? err.code : 'UNKNOWN_ERROR');
      print(errorMessage);
      // TODO: Instead of returning Future.error, consider throwing a specific domain exception.
      return Future.error(errorMessage!);
    }
  }

  //Signin With email and password
  String getMessageFromErrorCode(String errorCode) { // Parameter type explicitly String
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE": // This case is deprecated
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      // break; // Unreachable
      case "ERROR_WRONG_PASSWORD": // This case is deprecated
      case "wrong-password":
        return "Wrong email/password combination.";
      // break; // Unreachable
      case "ERROR_USER_NOT_FOUND": // This case is deprecated
      case "user-not-found":
        // Combined with the other user-not-found as they had different messages
        return "No user found with this email. Please signUp to continue or check your email."; 
      // break; // Unreachable
      case "ERROR_USER_DISABLED": // This case is deprecated
      case "user-disabled":
        return "User disabled.";
      // break; // Unreachable
      case "ERROR_TOO_MANY_REQUESTS": // This case is deprecated
      // case "operation-not-allowed": // This was duplicated with server error, likely a typo
        return "Too many requests to log into this account.";
      // break; // Unreachable
      case "ERROR_OPERATION_NOT_ALLOWED": // This case is deprecated
      case "operation-not-allowed":
        return "Server error, please try again later.";
      // break; // Unreachable
      case "ERROR_INVALID_EMAIL": // This case is deprecated
      case "invalid-email":
        return "Email address is invalid.";
      // break; // Unreachable
      // Removed duplicate "user-not-found" case which was covered above
      default:
        return "Login failed. Please try again.";
      // break; // Unreachable
    }
  }

  //Register with email and password
  Future<UserFromFirebaseUser?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // TODO: userCredential.user might be null, handle this case.
      String token = await userCredential.user!.getIdToken();
      return _userFromFirebaseUser(userCredential.user!, token);
    } catch (err) {
      print(err);
      errorMessage = getMessageFromErrorCode(err is FirebaseException ? err.code : 'UNKNOWN_ERROR');
      print(errorMessage);
      return Future.error(errorMessage!);
    }
  }

  Future<UserFromFirebaseUser?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // TODO: userCredential.user might be null, handle this case.
      String token = await userCredential.user!.getIdToken();
      return _userFromFirebaseUser(userCredential.user!, token);
    } catch (err) {
      print(err);
      errorMessage = getMessageFromErrorCode(err is FirebaseException ? err.code : 'UNKNOWN_ERROR');
      print(errorMessage);
      return Future.error(errorMessage!);
    }
  }

  //signout
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //getMessageFromErrorCode
  // TODO: user can be null, add null check before accessing properties or ensure it's never null here.
  UserFromFirebaseUser? _userFromFirebaseUser(User? user, String token) { // Made user nullable
    return user != null
        ? UserFromFirebaseUser(uid: user.uid, email: user.email ?? '', token: token) // Handle potential null email
        : null;
  }
} 