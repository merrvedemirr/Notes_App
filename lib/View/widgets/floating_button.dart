import 'package:flutter/material.dart';
import 'package:notes_app/View/screens/add_note_screen.dart';

// ignore: camel_case_types
class floatingButton extends StatelessWidget {
  const floatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AddNoteScreen(editMode: false, note: {}),
        ));
      },
      backgroundColor: Colors.orange,
      child: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}
