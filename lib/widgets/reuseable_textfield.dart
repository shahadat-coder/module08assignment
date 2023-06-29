import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final String? labelText;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyBordType;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final  Icon? prefixIcon ;

  const ReusableTextField(
      {super.key,
        this.minLines,
        this.maxLines,
        required this.labelText,
        this.controller,
        this.prefixIcon,
        this.onChanged,
        this.keyBordType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyBordType,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon:prefixIcon,
        labelText: labelText,
        floatingLabelStyle: const TextStyle(fontSize: 13),
        labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        contentPadding:
        const EdgeInsets.symmetric(vertical:7, horizontal: 10),
        alignLabelWithHint: true,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.cyan,
            width: 0.7,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.7,
          ),
        ),
      ),
    );
  }
}
