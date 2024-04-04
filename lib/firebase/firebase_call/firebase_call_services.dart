import 'package:betterbee/Animal.dart';
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

  Future<void> setAnimal(String uid, String animal) async {
    try {
      DocumentReference userDoc = _firestore.collection('users').doc(uid);
      await userDoc.update({'animals.$animal': true});
      return;
    } catch (e) {
      return;
    }
  }

  Future<List<Animal>> getDataBaseAnimals() async {
    CollectionReference animalsCollection = _firestore.collection('animals');

    QuerySnapshot snapshot = await animalsCollection.get();
    List<Animal> animals = snapshot.docs.map((doc) {
      return Animal.fromFirestore(doc);
    }).toList();
    return animals;
  }

  Future<Map<String, dynamic>?> getDescriptionAndHints(String animal) async {
    try {
      DocumentSnapshot animalDoc =
          await _firestore.collection('animals').doc(animal).get();

      if (animalDoc.exists) {
        Map<String, dynamic> animalData =
            animalDoc.data() as Map<String, dynamic>;

        return animalData;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
