import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.values});
  final List? values;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/icons/notepad.png",
          width: 50,
        ),
        Column(
          children: [
            Text(
              "Not Defteri",
              style: GoogleFonts.pacifico(
                textStyle: const TextStyle(fontSize: 30),
              ),
            ),
            Text("${values?.length ?? 0} adet Not", style: GoogleFonts.roboto()),
          ],
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
      ],
    );
  }
}
