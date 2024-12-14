import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ietp/firebase_operation.dart';
import 'package:ietp/front_page.dart';
import 'package:ietp/widget/button.dart';
import 'package:just_audio/just_audio.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Reference to the `in_danger` collection
    final CollectionReference inDangerCollection =
        FirebaseFirestore.instance.collection('in_danger');

    return Scaffold(
      appBar: AppBar(
        title: const Text('IETP'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButtons(
                text: "Safe",
                onPressed: () async {
                  safeState();
                  final player = AudioPlayer();
                  await player.stop();
                },
                color: Colors.green,
                textColor: Colors.white,
              ),
              CustomButtons(
                text: "Leave the Building",
                onPressed: () {
                  deleteToken();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => FrontPage()));
                },
                color: Colors.green,
                textColor: Colors.white,
              ),
            ],
          ),

          const SizedBox(height: 20),
          const Text(
            "People in Danger:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          // StreamBuilder for `in_danger` collection
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: inDangerCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No people in danger currently.'),
                  );
                }

                // Extract the `name` field from each document
                final people = snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return data['name'] ?? 'Unknown';
                }).toList();

                return ListView.builder(
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(people[index]),
                      leading: const Icon(Icons.warning, color: Colors.red),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
