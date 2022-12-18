import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  String name;
  IconData icon;
  Color color;
  VoidCallback onTap;
  CustomButton({required this.name,required this.icon,required this.color,required this.onTap});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late double height;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Container(
      height: height*0.05,
      child: ElevatedButton.icon(onPressed: widget.onTap, icon: Icon(widget.icon),
      label: Text(widget.name,maxLines: 1,overflow: TextOverflow.ellipsis,),
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color
      ),),
    );
  }
}
