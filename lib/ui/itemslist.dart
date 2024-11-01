import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_inventory/repository/firestorehelper.dart';
import '../model/item.dart';
import 'additem.dart';
import 'deleteorupdateitem.dart';

class ItemList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ItemListState();
}

class ItemListState extends State<ItemList> {

  // DbHelper helper = DbHelper();
  FirestoreHelper helper = FirestoreHelper();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Simple Inventory"),
      ),

      body: listItems(),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItem()),
          );
        },
        tooltip: "Adicionar novo Item",
        child: Icon(Icons.add),
      ),
    );
  }

  StreamBuilder listItems() {
    return StreamBuilder<QuerySnapshot>(
      stream: helper.getItems(),

      builder: (context, snapshot){
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var items = snapshot.data!.docs.map((doc)=>
            Item.fromDocumentSnapshot(doc)
          ).toList();

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int position) {
            return Card(
              elevation: 2.0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: getColor(items[position].condition),
                ),
                title: Text(items[position].name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Condição: ${items[position].condition}'),
                    Text('Descrição: ${items[position].description}'),
                    Text('Localização: ${items[position].location}'),
                  ],
                ),
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditItem(item: items[position]),
                    ),
                  );
                },
              ),
            );
          },
        );

        }
    );


  }

  Color getColor(String condition) {

    switch (condition) {
      case 'Ruim':
        return Colors.red;
        break;
      case 'Razoável':
        return Colors.orange;
        break;
      case 'Bom':
        return Colors.yellow;
        break;
      case 'Muito Bom':
        return Colors.green;
        break;

      default:
        return Colors.green;
    }

  }

}