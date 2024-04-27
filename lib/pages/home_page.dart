import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/firebase/firestore.dart';
import 'package:noteapp/pages/mydrawer.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final FireStoreService fireStoreService = FireStoreService();

  final TextEditingController textcontroller = TextEditingController();

  void openbox(BuildContext context, {String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextFormField(
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              'type anything';
            }
            return null;
          },
          decoration: const InputDecoration(
            hintText: "Type Your Note",
            border: OutlineInputBorder(),
          ),
          controller: textcontroller,
          style: TextStyle(),
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (docID == null) {
                  fireStoreService.addnote(textcontroller.text);
                } else {
                  fireStoreService.upadatenote(docID, textcontroller.text);
                }

                textcontroller.clear();
                Navigator.pop(context);
              },
              child: Text(
                "Done",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes app"),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.black,
        onPressed: () => openbox(context),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.getnotesstream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List noteslist = snapshot.data!.docs;
            return ListView.builder(
              itemCount: noteslist.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = noteslist[index];
                String docID = document.id;

                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String notetext = data['notes'];
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 10, bottom: 5),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: ListTile(
                        title: Text(
                          notetext,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 19,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () => openbox(docID: docID, context),
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                )),
                            IconButton(
                                onPressed: () => fireStoreService.delete(docID),
                                icon: Icon(
                                  Icons.delete,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Text(
              "No Notes...",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            );
          }
        },
      ),
    );
  }
}
