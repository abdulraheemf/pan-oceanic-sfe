import 'package:flutter/material.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';

class HomePageLeftColumnEntry extends StatefulWidget {
  IconData icon;
  String description;
  bool isHome;
  VoidCallback onTap;
  HomePageLeftColumnEntry({super.key, required this.icon,required this.description,this.isHome=false,required this.onTap});

  @override
  State<HomePageLeftColumnEntry> createState() => _HomePageLeftColumnEntryState();
}

class _HomePageLeftColumnEntryState extends State<HomePageLeftColumnEntry> {
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        widget.onTap;
      },
      child: Container(
        height: height*0.07,
        decoration: BoxDecoration(
          color: (widget.isHome)?const Color(0xFF303551):MyConstants.homePageLeftMenuColor,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(widget.icon,color: (widget.isHome)?Colors.white:Colors.white.withOpacity(0.4),),
            ),
            Flexible(
              child: Text(widget.description,style: TextStyle(
                color: (widget.isHome)?Colors.white:Colors.white.withOpacity(0.4)
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,),
            )
          ],
        ),
      ),
    );
  }
}
