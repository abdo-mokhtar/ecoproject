import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class LocationDropdown extends StatelessWidget {
  final List<String> locations = [
    "Cairo", "Qena", "Red Sea", "Sharqia", "Sohag", "South Sinai", "Suez"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DropdownSearch<String>(
          popupProps: PopupProps.dialog(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              cursorColor: Colors.white,
              decoration: InputDecoration(
                labelText: "Search locations...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              prefixIcon: Icon(Icons.location_on),
            ),
          ),
          items: locations,
          onChanged: (value) {
            print("Selected: $value");
          },
          selectedItem: "Cairo",
        ),
      ),
    );
  }
}
