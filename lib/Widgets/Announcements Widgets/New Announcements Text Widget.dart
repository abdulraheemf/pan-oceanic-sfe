import 'package:flutter/material.dart';

class AnnouncementTextInputBox extends StatefulWidget {
  TextEditingController control;
  AnnouncementTextInputBox({super.key, required this.control});
  @override
  State<AnnouncementTextInputBox> createState() => _AnnouncementTextInputBoxState();
}

class _AnnouncementTextInputBoxState extends State<AnnouncementTextInputBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Padding(padding: const EdgeInsets.all(5),child: Align(
        alignment: Alignment.topLeft,
        child: TextFormField(
          controller: widget.control,
          style: const TextStyle(
            fontSize: 18
          ),
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration.collapsed(hintText: 'Type here...',hintStyle: TextStyle(
            fontSize: 18
          )),
          maxLines: null,
        ),
      ),),
    );
  }
}
