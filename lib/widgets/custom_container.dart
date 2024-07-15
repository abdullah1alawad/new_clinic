import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class CustomContainer extends StatelessWidget {
  final Widget data;
  final IconData icon;
  final VoidCallback onPressButton;
  final VoidCallback? secondOnPreesButton;
  final String buttonText;
  final String? secondButtonText;
  final bool loading;
  final double? height;

  const CustomContainer({
    super.key,
    required this.data,
    required this.icon,
    required this.onPressButton,
    required this.buttonText,
    required this.loading,
    this.height,
    this.secondOnPreesButton,
    this.secondButtonText,
  });

  @override
  Widget build(BuildContext context) {
    MediaQueryData screenInfo = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 20, horizontal: screenInfo.size.width / 20.571),
      child: Stack(
        children: <Widget>[
          Column(
            children: [
              ClipPath(
                clipper: RoundedDiagonalPathClipper(),
                child: Container(
                  height: height,
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    screenInfo.size.width / 13.714,
                    100,
                    screenInfo.size.width / 13.714,
                    30,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: data,
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (secondButtonText != null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: secondOnPreesButton,
                    child: Text(secondButtonText!,
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                if (secondButtonText != null) const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: onPressButton,
                  child: loading == true
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : Text(buttonText,
                          style: Theme.of(context).textTheme.titleSmall),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
