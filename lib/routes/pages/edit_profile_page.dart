import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/PetModel.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>{

  final _db = FirebaseFirestore.instance;

  final TextEditingController petNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final petNameField = TextFormField(
        autofocus: false,
        controller: petNameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Pet Name cannot be Empty.");
          }
          return null;
        },
        onSaved: (value) {
          petNameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Pet Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );

    final birthDateField = TextFormField(
        autofocus: false,
        controller: birthDateController,
        keyboardType: TextInputType.name,
        onSaved: (value) {
          birthDateController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Pet Birth Date",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );

    final ageField = TextFormField(
        autofocus: false,
        controller: ageController,
        keyboardType: TextInputType.name,
        onSaved: (value) {
          ageController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Pet Age",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );

    final breedField = TextFormField(
        autofocus: false,
        controller: breedController,
        keyboardType: TextInputType.name,
        onSaved: (value) {
          breedController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Pet Breed",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );

    final saveButton = Material(
      elevation: 5,
      borderRadius:  BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            saveEdit(
              petNameController.text,
              birthDateController.text,
              ageController.text,
              breedController.text
            );
            Navigator.of(context).pop();
          },
          child: Text(
            "Save",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 32),
          child: Column(
            children: [
              SizedBox(height:20),
              imageProfile(),
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  children: [
                    SizedBox(height:20),
                    petNameField,
                    SizedBox(height:20),
                    birthDateField,
                    SizedBox(height:20),
                    ageField,
                    SizedBox(height:20),
                    breedField,
                    SizedBox(height:20),
                    saveButton
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveEdit(String petName, String birthDate, String age, String breed) {
    final pet = PetModel();
    pet.petName=petName;
    pet.birthDate=birthDate;
    pet.age=age;
    pet.breed=breed;
    _db.collection("pets").add(pet.toMap()).then((DocumentReference doc) =>
    print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}

Widget imageProfile() {
  return const Stack(
    children: <Widget>[
      CircleAvatar(
        radius: 50.0,
        backgroundImage: AssetImage('assets/sampleprofile.png'),
      ),
      Positioned(
        bottom: 5.0,
        right: 5.0,
        child: Icon(
          Icons.camera_alt_rounded,
          color: Colors.cyan,
          size: 28.0,
        ),
      )
    ],
  );
}