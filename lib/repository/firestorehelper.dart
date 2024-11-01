import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/item.dart';

class FirestoreHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para inserir dados no banco.
  void createItem(Item item) {
    _firestore.collection("items").add(
      {
        "name": item.name,
        "description": item.description,
        "condition": item.condition,
        "location": item.location,
      }
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getItems() {
    return _firestore.collection("items").snapshots();
  }

  // Método para atualizar registro.
  void updateItem(Item item)  {
    _firestore.collection("items").doc(item.id).update(item.toMap());
  }

  // Método para apagar registro.
  void deleteItem(String id) {
    _firestore.collection("items").doc(id).delete();
  }


}