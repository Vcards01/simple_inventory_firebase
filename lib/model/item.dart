import 'package:cloud_firestore/cloud_firestore.dart';

class Item {

  // Atributos:

  late String? _id;
  late String _name;
  late String? _description;
  late String _condition;
  late String _location;


  Item(this._name, this._location, this._condition, [this._description]);

  Item.fromDocumentSnapshot(DocumentSnapshot doc){
    _id = doc.id;
    _name = doc["name"];
    _description = doc["description"];
    _condition = doc["condition"];
    _location = doc["location"];
  }

  // Construtor para quando já tivermos o id.
  Item.withId(this._id, this._name, this._location, this._condition,
      [this._description]);

  Item.fromMap(dynamic o)
      : _id = o["id"],
        _name = o["name"],
        _description = o["description"],
        _condition = o["condition"],
        _location = o["location"];

  // Getters...
  String get priority => _location;

  String get condition => _condition;

  String? get description => _description;

  String get location => _location;

  String get name => _name;

  String? get id => _id;

  // Setters...

  set name(String newTitle) {
    if (newTitle.length <= 255) {
      _name = newTitle;
    }
  }

  set description(String? newDescription) {
    if (newDescription != null && newDescription.length <= 255) {
      _description = newDescription;
    }
  }

  set location(String newLocation) {
    if (newLocation.length <= 255) {
      _location = newLocation;
    }
  }

  set condition(String newCondition) {
    _condition = newCondition;
  }

  Map <String, dynamic> toMap(){
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["description"] = _description;
    map["condition"] = _condition;
    map["location"] = _location;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }


}

