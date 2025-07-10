import 'package:flutter/material.dart';

class CustomSearchBarField extends StatelessWidget {
  const CustomSearchBarField(
      {super.key,
        required this.userInput,
        required this.hint, required this.onTap});
  final String hint;
  final TextEditingController userInput;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize:  16,
        fontWeight: FontWeight.w400,
      ),
      autofocus: true,
      onChanged: (value) => userInput,
      controller: userInput,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade300,
        filled: true,
        errorStyle: TextStyle(
          color: Colors.redAccent,
          fontSize: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        isDense: true,
        contentPadding:
        const EdgeInsets.only(left: 16, bottom: 0, top: 0, right: -10),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey,
          size: MediaQuery.sizeOf(context).width * 0.06,
        ),
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            Icons.filter_list,
            color: Colors.black,
            size:MediaQuery.sizeOf(context).width * 0.06,
          ),
        ),
        hintText: hint,
        hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14),
      ),
    );
  }
}