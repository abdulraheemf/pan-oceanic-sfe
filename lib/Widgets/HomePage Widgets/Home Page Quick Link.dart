import 'package:flutter/material.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';

class HomePageQuickLink extends StatefulWidget {
  String description;
  IconData icon;
  VoidCallback onTap;
  HomePageQuickLink({super.key, required this.description,required this.icon,required this.onTap});

  @override
  State<HomePageQuickLink> createState() => _HomePageQuickLinkState();
}

class _HomePageQuickLinkState extends State<HomePageQuickLink> {
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: height*0.12,
        width: width*0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            SizedBox(width: width*0.01,),
            Container(
              height: height*0.09,
              width: width*0.05,
              decoration: BoxDecoration(
                color: MyConstants.goodCardHomePageCardColor,
                borderRadius: BorderRadius.circular(3)
              ),
              child: Center(
                child: Icon(widget.icon,size: 50,),
              ),
            ),
            SizedBox(width: width*0.01,),
            Expanded(child: Text(widget.description,style: TextStyle(fontSize: 18),))

          ],
        ),
      ),
    );
  }
}
