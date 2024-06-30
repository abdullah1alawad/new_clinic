import 'package:flutter/material.dart';

class Clinic extends StatelessWidget {
  final String clinicName, imageUrl;

  const Clinic({
    super.key,
    required this.clinicName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image(
            image: AssetImage(imageUrl),
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 150,
          width: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            clinicName,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
