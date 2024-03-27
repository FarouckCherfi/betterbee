import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, bool> _initialAnimals = {
    "Bee": false,
    "Elephant": false,
    "Giraffe": false,
    "Zebra": false,
    "Tiger": false,
    "Monkey": false,
    "Cat": false,
    "Panda": false,
    "Koala": false,
    "Hippo": false
  };

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (userCredential.user != null) {
      User? user = userCredential.user;
      await _firestore.collection('users').doc(user!.uid).set({
        'username': username,
        'animals': _initialAnimals,
      });
    }
    return userCredential.user;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        String uid = firebaseUser.uid;
        String username = googleUser?.displayName ?? "New User";
        final docSnapShot = await _firestore.collection('users').doc(uid).get();

        // Première connexion sinon on ne modifie pas la BDD
        if (!docSnapShot.exists) {
          await _firestore.collection('users').doc(uid).set({
            'username': username,
            'animals': _initialAnimals,
          });
        }
      }
      return userCredential.user;
    } on Exception catch (e) {
      print('exception->$e');
    }
  }
}
