import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search for a City",
          hintStyle: TextStyle(
            color: Colors.green.shade400,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.green.shade400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          filled: true,
          fillColor: Colors.green.shade50,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        ),
      ),
    );
  }
}
