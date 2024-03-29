// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

class Animal {
  final String name;
  final String description;
  final double height;
  final String hint;
  final String hint2;
  final double positionLeft;
  final double positionTop;
  final double width;

  Animal({
    required this.name,
    required this.description,
    required this.height,
    required this.hint,
    required this.hint2,
    required this.positionLeft,
    required this.positionTop,
    required this.width,
  });
 

  // Factory constructor to create Animal object from Firestore document data
  factory Animal.fromFirestore(QueryDocumentSnapshot<Object?> doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Animal(
      name: doc.id,
      description: data['description'] ?? '',
      hint: data['hint'] ?? '',
      hint2: data['hint2'] ?? '',
      height: (data['height'] ?? 0.0).toDouble(),
      positionLeft: (data['positionLeft'] ?? 0.0).toDouble(),
      positionTop: (data['positionTop'] ?? 0.0).toDouble(),
      width: (data['width'] ?? 0.0).toDouble(),

      
    );
  }
}
