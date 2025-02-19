import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class LocationDropdown extends StatelessWidget {
  final List<String> locations = [
    "Cairo",
    "Qena",
    "Red Sea",
    "Sharqia",
    "Sohag",
    "South Sinai",
    "Suez"
  ];

  LocationDropdown({super.key});

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
          dropdownDecoratorProps: const DropDownDecoratorProps(
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
