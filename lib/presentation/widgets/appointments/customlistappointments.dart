import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class CustomListAppointments extends StatelessWidget {
  final Widget child;
  const CustomListAppointments({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      //left: 80.0, right: 50.0, top: 20.0
      padding: EdgeInsets.symmetric(horizontal: 60.0 , vertical: 10.0),
      child: SizedBox(height: 50, child: child),
    );
  }
}

class Appointments extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const Appointments({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 5),
            decoration:
            isSelected
                ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 3,
                  color: MyColors.secondColor,
                ),
              ),
            )
                : null,
            child: Text(
              text,
              style: const TextStyle(color: MyColors.greyDark, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
