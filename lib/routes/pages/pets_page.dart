import 'package:flutter/material.dart';
import 'package:flutter_myapp/routes/pages/edit_profile_page.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<StatefulWidget> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  late List<String> _pets;

  @override
  void initState() {
    _pets =['sample'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: ListView.builder(
          itemCount: _pets.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
              ),
              child: SizedBox(
                height: 100,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) =>
                    EditProfilePage()));
                  },
                  title: Text(_pets[index]),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/sampleprofile.png'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}