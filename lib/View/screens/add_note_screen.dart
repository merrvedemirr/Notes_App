import 'package:flutter/material.dart';
import 'package:notes_app/Model/note.dart';
import 'package:notes_app/View/utils/gradient_box.dart';
import 'package:notes_app/View/utils/keys.dart';
import 'package:notes_app/View/widgets/custom_iconbutton.dart';
import 'package:notes_app/View/widgets/custom_textformfield.dart';
import 'package:notes_app/View/widgets/dialog.dart';
import 'package:notes_app/ViewModel/methods/hive_method.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key, required this.editMode, required this.note});
  final bool editMode;
  final Map note;
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  bool editMode = false;
  bool isThereeChange = false;

  void addNote() async {
    if (_titleController.text.isNotEmpty || _noteController.text.isNotEmpty) {
      HiveMethod hive = HiveMethod();
      bool response = await hive.addNote(_titleController.text, _noteController.text);
      if (response == true) {
        //başarılı mesajı
      } else {
        //başarısız mesajı
      }
    }
  }

  Future<void> updateNote() async {
    if (_titleController.text.isNotEmpty || _noteController.text.isNotEmpty) {
      HiveMethod hive = HiveMethod();
      Note note = Note(
          title: _titleController.text, note: _noteController.text, date: widget.note["date"], id: widget.note["id"]);
      bool response = await hive.updateNote(note, widget.note["id"]);
      if (response == true) {
        //başarılı
      } else {
        //başarısız.
      }
    }
  }

  void deleteNote() async {
    HiveMethod hive = HiveMethod();
    bool response = await hive.deleteNote(widget.note["id"]);
    if (response == true) {
      //başarılı
    } else {
      //başarısız.
    }
  }

  Future<bool> checkChange() async {
    if (!isThereeChange) {
      Navigator.pop(context);
      return true;
    } else {
      bool response = await showDialog(
        context: context,
        builder: (context) {
          return isQuestion(Keys.changequestion, context: context);
        },
      );
      if (response) {
        //kaydet
        if (widget.editMode) {
          updateNote(); //güncelle
          Navigator.pop(context);
        } else {
          addNote(); //kaydet ekle
          Navigator.pop(context);
        }
        return true;
      } else {
        Navigator.pop(context);
        return false;
      }
    }
  }

  @override
  void initState() {
    if (widget.editMode) {
      //todo: eğer nota tıklayarak geldiyse bunları gereken kısımlara yaz.
      _titleController.text = widget.note["title"];
      _noteController.text = widget.note["note"];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        await checkChange();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
            child: Column(
              children: [
                _customAppBar(context),
                //title kısmı
                CustomTextFormField(
                    editMode: editMode,
                    controller: _titleController,
                    onChanged: (value) {
                      if (!isThereeChange) {
                        setState(() {
                          isThereeChange = true;
                        });
                      }
                    },
                    hintText: Keys.titleHintText,
                    height: MediaQuery.of(context).size.width / 7.0),
                //note kısmı
                CustomTextFormField(
                    editMode: editMode,
                    controller: _noteController,
                    onChanged: (value) {
                      if (!isThereeChange) {
                        setState(() {
                          isThereeChange = true;
                        });
                      }
                    },
                    hintText: Keys.noteHintText,
                    height: MediaQuery.of(context).size.width / 1.3)
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TextFormField _noteContainer() {
  //   return TextFormField(
  //     readOnly: !editMode,
  //     controller: _noteController,
  //     maxLines: 15,
  //     minLines: null,
  //     keyboardType: TextInputType.text,
  //     onChanged: (value) {
  //       //kaydedilmeyen değişiklikler var mı?
  //       if (!isThereeChange) {
  //         setState(() {
  //           isThereeChange = true;
  //         });
  //       }
  //     },
  //     decoration: InputDecoration(
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //       ),
  //       hintText: Keys.noteHintText,
  //     ),
  //   );
  // }

  // Container _titleContainer() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 20),
  //     margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 20),
  //     width: double.infinity,
  //     height: 50,
  //     decoration: BoxDecoration(
  //         color: const Color.fromARGB(255, 254, 177, 33).withOpacity(0.2), borderRadius: BorderRadius.circular(30)),
  //     child: TextFormField(
  //       readOnly: !editMode,
  //       controller: _titleController,
  //       minLines: 1,
  //       keyboardType: TextInputType.text,
  //       onChanged: (value) {
  //         if (!isThereeChange) {
  //           setState(() {
  //             isThereeChange = true;
  //           });
  //         }
  //       },
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //         hintText: Keys.titleHintText,
  //       ),
  //     ),
  //   );
  // }

//APPBAR KISMI
  Container _customAppBar(BuildContext context) {
    return Container(
      decoration: gradientBoxDecoration(),
      child: Row(
        children: [
          CustomIconButton(
              icon: Icons.arrow_back_ios_new_outlined,
              onPressed: () async {
                checkChange();
              }),
          const Spacer(),
          CustomIconButton(
              icon: editMode ? Icons.remove_red_eye_outlined : Icons.edit_rounded,
              onPressed: () {
                setState(() {
                  editMode = !editMode;
                });
              }),
          CustomIconButton(
            icon: Icons.check,
            onPressed: () {
              if (widget.editMode) {
                updateNote(); //güncelle
              } else {
                addNote(); //kaydet ekle
              }
              Navigator.pop(context);
            },
          ),
          widget.editMode
              ? CustomIconButton(
                  icon: Icons.delete_outline_outlined,
                  onPressed: () async {
                    bool response = await showDialog(
                      context: context,
                      builder: (context) {
                        return isQuestion(Keys.deletequestion, context: context);
                      },
                    );
                    if (response) {
                      deleteNote();
                      Navigator.pop(context);
                    }
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
