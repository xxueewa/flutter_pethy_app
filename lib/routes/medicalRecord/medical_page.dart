import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myapp/routes/medicalRecord/data/MedicalRecordModel.dart';
import 'package:flutter_myapp/routes/medicalRecord/document_scan_page.dart';
import '../../utils/db_helper.dart';
import '../../utils/http_client.dart';
import 'data/Album.dart';

class MedicalPage extends StatefulWidget {
  const MedicalPage({super.key});

  @override
  State<StatefulWidget> createState() => _MedicalPageState();
}

class _MedicalPageState extends State<MedicalPage> {
  final _auth = FirebaseAuth.instance;
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DBHelper db = DBHelper();
    HttpClient client = HttpClient();
    final recordModelRef = db.getRecordRef("medicalRecords");
    futureAlbum = client.testClient();
    final addButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DocumentScanPage()));
          },
          child: const Text(
            "Add",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: [
            FutureBuilder<Album>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.title);
                } else {
                  return Text('${snapshot.error}');
                }
              },
            ),
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: StreamBuilder<QuerySnapshot<MedicalRecordModel>>(
                  stream: recordModelRef
                      .where("userId", isEqualTo: _auth.currentUser!.uid)
                      .snapshots()
                      .cast(),
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
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 12.0),
                                child: Column(children: [
                                  ExpandablePanel(
                                    header: Text(
                                        data.docs[index].data().petName!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    collapsed: Text(data.docs[index].data().recordId!),
                                    expanded: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Vet: ${data.docs[index].data().vetClinic!}",
                                            textAlign: TextAlign.left),
                                        Text(
                                            "Record: ${data.docs[index].data().record!}",
                                            textAlign: TextAlign.left),
                                        Text(
                                            "Cost: ${data.docs[index].data().cost!}",
                                            textAlign: TextAlign.left),
                                      ],
                                    ),
                                  ),
                                ])));
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