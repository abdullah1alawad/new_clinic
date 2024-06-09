import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class CustomContainer extends StatelessWidget {
  final Column data;
  final IconData icon;
  final VoidCallback onPressButton;
  final String buttonText;
  final bool cancel, loading;

  const CustomContainer({
    super.key,
    required this.data,
    required this.icon,
    required this.onPressButton,
    required this.buttonText,
    required this.cancel,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          Column(
            children: [
              ClipPath(
                clipper: RoundedDiagonalPathClipper(),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 100, 30, 50),
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
                if (cancel)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('إلغاء',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                if (cancel) const SizedBox(width: 10),
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
