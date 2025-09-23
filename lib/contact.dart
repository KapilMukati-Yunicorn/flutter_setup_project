import 'package:flutter/material.dart';

class ContactClass extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      height: 20,
      width: MediaQuery.of(context).size.width,
      color: Colors.red,
      child: Text("Hii"),
    );
  }
}