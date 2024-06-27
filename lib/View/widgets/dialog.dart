import 'package:flutter/material.dart';
import 'package:notes_app/View/utils/keys.dart';

// ignore: camel_case_types
class isQuestion extends AlertDialog {
  // ignore: non_constant_identifier_names
  final String Message;

  isQuestion(this.Message, {super.key, required BuildContext context})
      : super(
          title: Text(Message),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 122, 230, 126))),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text(
                  Keys.yes,
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text(
                  Keys.no,
                  style: TextStyle(color: Colors.black),
                )),
          ],
        );
}
