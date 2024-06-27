import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.editMode,
    required this.controller,
    this.maxLines = 1,
    required this.onChanged,
    required this.hintText,
    required this.height,
  });
  final bool editMode;
  final TextEditingController controller;
  final maxLines;
  final ValueChanged<String> onChanged;
  final String hintText;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 20),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 254, 177, 33).withOpacity(0.2), borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        readOnly: !editMode,
        controller: controller,
        minLines: 1,
        maxLines: maxLines,
        keyboardType: TextInputType.text,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
// if (!isThereeChange) {
          //   setState(() {
          //     isThereeChange = true;
          //   });
          // }