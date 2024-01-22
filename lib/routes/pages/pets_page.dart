import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myapp/routes/pages/edit_profile_page.dart';
import 'package:provider/provider.dart';

import '../../db/db_helper.dart';
import '../../model/PetModel.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<StatefulWidget> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DBHelper db = DBHelper();
    final petModelRef = db.getPetRef("pets");

    final addButton = Material(
        elevation: 5,
        borderRadius:  BorderRadius.circular(30),
        color: Colors.redAccent,
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditProfilePage()));
            },
            child: Text(
              "Add",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            )
        ),
      );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: StreamBuilder<QuerySnapshot<PetModel>>(
                    stream: petModelRef.where("userId", isEqualTo: _auth.currentUser!.uid).snapshots().cast(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {}
                      if (!snapshot.hasData) {
                        return const Text('Loading...');
                      }
                      final data = snapshot.requireData;
                      return ListView.builder(
                        itemCount: data.docs.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            // child: SizedBox(height: 100,
                            //   child: ListTile(
                            //     onTap: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) => EditProfilePage()));
                            //     },
                            //     title: Text(data.docs[index].data().petName!),
                            //     leading: CircleAvatar(
                            //       backgroundImage: AssetImage('assets/sampleprofile.png'),
                            //     ),
                            //   ),
                            // ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                              child: Column(
                                children: [
                                  ExpandablePanel(
                                    header: Text(data.docs[index].data().petName!,
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    collapsed: const CircleAvatar(
                                      backgroundImage: AssetImage('assets/sampleprofile.png'),
                                    ),
                                    expanded: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Breed: ${data.docs[index].data().breed!}", textAlign:TextAlign.left),
                                        Text("Age: ${data.docs[index].data().age!}", textAlign:TextAlign.left),
                                        Text("BirthDate: ${data.docs[index].data().birthDate!}", textAlign:TextAlign.left),
                                      ],
                                    ),
                                  ),
                                ]
                              )
                            )
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              addButton
            ],
          ),
      ),
    );
  }
}