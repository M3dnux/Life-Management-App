import 'package:flutter/material.dart';

TextField getTextFieldDesign(
    {required String hintText,
    required TextEditingController field,
    required bool isObscure}) {
  return TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: const BorderSide(
            color: Color(0xff987284)), // Change the border color to 0xff987284
        borderRadius: BorderRadius.circular(30.0),
      ),
      hintText: hintText, //! diff
      fillColor: const Color(0xff987284).withOpacity(
          0.44), // Change the background color to 0xff987284 with 44% opacity
      filled: true,
      labelStyle: const TextStyle(
          color: Colors.black), // Change the label text color to 0x000
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: Colors.black), // Change the focused border color to 0x000
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
    controller: field, //! diff
    obscureText: isObscure, //! diff
    keyboardType: (isObscure)
        ? TextInputType.text
        : TextInputType
            .emailAddress, //! !!!!!!!!! need changing!!!!!!!!!!diff for email
    enableSuggestions: false,
    autocorrect: false,
    style: const TextStyle(
        color: Colors.black), // Change the input text color to 0x000
        cursorColor: Colors.black, // Change the cursor color to 0x000
  );
}

TextButton getTextButtonDesign({
  required void Function()? function,
  required String text,
}) {
  return TextButton(
    onPressed: function,
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(10.0),
      backgroundColor: const Color(0xff6cae75),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(
          color: Color(0xff6cae75),
        ),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: const Color(0xfffbfaf2),
        fontWeight: FontWeight.bold,
        fontSize: 29.0,
      ),
    ), //! diff
  );
}
