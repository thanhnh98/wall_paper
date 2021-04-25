import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BaseStateLessDialog extends StatelessWidget{
  Widget child;
  BaseStateLessDialog(this.child);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        backgroundColor: Colors.transparent,
        child: Center(
          child: child,
        )
    );
  }
}
