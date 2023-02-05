import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Text_form_field extends StatelessWidget {
  final TextEditingController controller;
  final String texthint;
  final IconData? data;
  bool? obscure;
  bool?enabled;
  Text_form_field({
    required this.controller,required this.texthint,this.obscure=false,required this.data
,this.enabled=true});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        obscureText: obscure!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
              prefixIcon: Icon(
            data,
                color: Colors.black,
        ),
          focusColor: Theme.of(context).primaryColor,
          hintText: texthint
        ),
      ),
    );
  }
}
