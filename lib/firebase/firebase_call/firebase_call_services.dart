import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseCallServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getAnimals(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        Map<String, dynamic>? animals =
            userData['animals'] as Map<String, dynamic>?;
        return animals;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
