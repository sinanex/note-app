

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/model/model.dart';

ValueNotifier<List<NoteData>> dataNotifier = ValueNotifier([]);

Future<void> getData() async{
  var database = await Hive.openBox<NoteData>('data');
  dataNotifier.value.clear();
  dataNotifier.value.addAll(database.values);
  dataNotifier.notifyListeners();
}

Future<void> adddata(NoteData value) async{
   var database = await Hive.openBox<NoteData>('data');
  await database.add(value);
  getData();
}
Future<void> deleteData(int index)async{
  var database = await Hive.openBox<NoteData>('data');
 await database.deleteAt(index);
 getData();
}

Future<void>editdata(int index,NoteData value)async{
   var database = await Hive.openBox<NoteData>('data');
 await  database.putAt(index, value);
 getData();
}