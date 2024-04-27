import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  Future<void> addnote(String note) {
    return notes.add({
      'notes': note,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getnotesstream() {
    final notestream = notes.orderBy('timestamp', descending: true).snapshots();
    return notestream;
  }
  Future<void> upadatenote(String docID,String newnote){
 return notes.doc(docID).update({
    'notes': newnote,
    'timestamp':Timestamp.now(),

  });

  }

 Future<void> delete(String docID) {
   return notes.doc(docID).delete();
  }
}
