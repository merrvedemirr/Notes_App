import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/View/screens/add_note_screen.dart';
import 'package:notes_app/View/utils/gradient_box.dart';
import 'package:notes_app/View/utils/keys.dart';
import 'package:notes_app/View/widgets/dialog.dart';
import 'package:notes_app/ViewModel/methods/hive_method.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({super.key, required this.values});
  // ignore: prefer_typing_uninitialized_variables
  final values;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        //todo: uzun süre basılı tutunca silinme özelliği
        bool response = await showDialog(
          context: context,
          builder: (context) {
            return isQuestion(Keys.deletequestion, context: context);
          },
        );
        if (response) {
          HiveMethod hive = HiveMethod();
          setState(() async {
            await hive.deleteNote(widget.values["id"]);
          });
        }
      },
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddNoteScreen(editMode: true, note: widget.values),
        ));
      },
      child: Container(
        decoration: gradientBoxDecoration(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Column(
                children: [
                  //note title kısmı
                  Text(
                    widget.values["title"],
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.lora(
                      textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  //note body kısmı
                  Expanded(
                    child: Text(
                      widget.values["note"],
                      style: GoogleFonts.nunito(textStyle: const TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
