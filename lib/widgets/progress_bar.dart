import 'package:flutter/material.dart';

circular_ProgressIndicator()
{
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top:12),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        Colors.cyan
      ),
    ),
  );
}
