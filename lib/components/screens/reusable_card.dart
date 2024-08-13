import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({required this.colour,required this.cardchild,required this.onPress,required this.image});

  final Color colour;
  final Widget cardchild;
  final void Function()? onPress;
  final DecorationImage image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 170.0,
        child: cardchild,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: colour,
            image: image,
          border: Border.all(
            color: Colors.blue
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),

    );
  }
}
