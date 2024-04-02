import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:payroll_app/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:payroll_app/src/features/core/screens/dashboard/dashboard.dart';
import 'package:payroll_app/src/repository/authentication/exception/signup_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  // late final User firebaseUser;
  // late Stream<User?> _userStream;


  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    // firebaseUser = _auth.currentUser! ;
    // _userStream = FirebaseAuth.instance.authStateChanges();
    // // firebaseUser =
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  // If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => const Dashboard());
  }

  //FUNC
  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const Dashboard())
          : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
    return null;
  }

  Future<void> logout() async => await _auth.signOut();

  // return email for any screen
  String getUserEmail() {
    String? email = firebaseUser.value?.email;
    String userEmail = '';
    if (email != null) {
      userEmail = email;
    }
    return userEmail;
  }
}
