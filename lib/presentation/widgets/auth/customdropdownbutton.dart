import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final String hint;
  final IconData icon;
  final String? value;
  final Map<String, String> items;
  final ValueChanged<String?> onChanged;
  const CustomDropdownButton({
    super.key,
    required this.hint,
    required this.icon,
    this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint, style: const TextStyle(fontSize: 16)),
          value: value,
          isExpanded: true,
          icon: Icon(icon, color: Colors.grey),
          onChanged: onChanged,

          items:
              items.entries.map((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(
                    entry.value,
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}

class CustomDropdownButtonAvailableTimes extends StatelessWidget {
  final String hint;
  final IconData icon;
  final String? value;
  final List<String>? items;
  final ValueChanged<String?> onChanged;
  const CustomDropdownButtonAvailableTimes({
    super.key,
    required this.hint,
    required this.icon,
    this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint, style: const TextStyle(fontSize: 16)),
          value: value,
          isExpanded: true,
          icon: Icon(icon, color: Colors.grey),
          onChanged: onChanged,

          items:
              items!
                  .map(
                    (String timeValue) => DropdownMenuItem<String>(
                      value: timeValue, // The actual value this item represents
                      child: Text(timeValue), // What the user sees in the list
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
