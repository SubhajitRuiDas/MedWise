import 'package:flutter/material.dart';
import 'package:med_tech_app/utils/colors_util.dart';

class ServiceContainer extends StatelessWidget {
  final String img;
  final String underlineTxt;

  const ServiceContainer({
    super.key,
    required this.img,
    required this.underlineTxt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [bgColor2, const Color(0xFFD8EFF5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            color: buttonColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            img,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          underlineTxt,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
