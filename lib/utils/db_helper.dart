import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_myapp/routes/medicalRecord/data/MedicalRecordModel.dart';
import 'package:flutter_myapp/routes/petProfile/data/PetModel.dart';

class DBHelper {

  final _db = FirebaseFirestore.instance;

  Future<List<PetModel>> getPetsByUserId(String userId) async {
    List<PetModel> pets = [];
    _db.collection('pets')
        .where("userId", isEqualTo: userId)
        .get()
        .then(
          (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          var pet = PetModel.fromMap({
            'petId': doc.data()['petId'],
            'userId': doc.data()['userId'],
            'petName': doc.data()['petName'],
            'birthDate': doc.data()['birthDate'],
            'age': doc.data()['age'],
            'breed': doc.data()['breed'],
            'pic': doc.data()['pic']
          });
          pets.add(pet);
        }
      },
      onError: (e) => log("Error: $e"),
    );
    return pets;
  }

  CollectionReference getPetRef(String collection) {
    final petModelRef = _db.collection(collection)
        .withConverter<PetModel>(
      fromFirestore: (snapshots, _) => PetModel.fromMap(snapshots.data()!),
      toFirestore: (petModel, _) => petModel.toMap(),
    );
    return petModelRef;
  }

  CollectionReference getRecordRef(String collection) {
    final recordModelRef = _db.collection(collection)
        .withConverter<MedicalRecordModel>(
      fromFirestore: (snapshots, _) => MedicalRecordModel.fromMap(snapshots.data()!),
      toFirestore: (recordModelRef, _) => recordModelRef.toMap(),
    );
    return recordModelRef;
  }


}