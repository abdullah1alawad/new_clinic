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
    double screenWidth = MediaQuery.of(context).size.width;
    double height = screenWidth / 2.7428, width = screenWidth / 2.7428;

    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(height/10),
              child: Image(
                image: AssetImage(imageUrl),
                height: isChosen == true ? height / 1.2 : height,
                width: isChosen == true ? width / 1.2 : width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: isChosen == true ? height / 1.2 : height,
              width: isChosen == true ? width / 1.2 : width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(height / 10)),
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
