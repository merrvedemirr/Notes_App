import 'package:hive/hive.dart';
import 'package:notes_app/Model/note.dart';
import 'package:uuid/uuid.dart';

class HiveMethod {
  final String boxName = "notes";

  //ekle
  Future<bool> addNote(String title, String note) async {
    try {
      String id = const Uuid().v1(); //todo: Eşsiz bir Id atmak için paket kullandık.
      var box = await Hive.openBox(boxName);

      Note noteModel = Note(title: title, note: note, date: DateTime.now(), id: id);

      await box.put(id, noteModel.toJson());
      return true;
    } catch (error) {
      return false;
    }
  }

//sil
  Future<bool> deleteNote(String id) async {
    try {
      var box = await Hive.openBox(boxName);
      await box.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }

//güncelle
  Future<bool> updateNote(Note noteModel, String id) async {
    try {
      var box = await Hive.openBox(boxName);
      await box.put(id, noteModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
