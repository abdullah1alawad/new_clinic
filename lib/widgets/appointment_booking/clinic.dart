import 'package:flutter/material.dart';

class Clinic extends StatelessWidget {
  final String clinicName, imageUrl;
  final bool isChosen;

  const Clinic({
    super.key,
    required this.clinicName,
    required this.imageUrl,
    required this.isChosen,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Center(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                image: AssetImage(imageUrl),
                height: isChosen == true ? 125 : 150,
                width: isChosen == true ? 125 : 150,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: isChosen == true ? 125 : 150,
              width: isChosen == true ? 125 : 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                clinicName,
                style: TextStyle(
                    fontSize: isChosen == true ? 20 : 25, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
