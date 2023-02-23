import 'package:flutter/material.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';
import 'package:provider/provider.dart';

import '../../Customs/custom_alert.dart';
import '../../Customs/custom_snackbar.dart';
import '../../Providers/firestore_provider.dart';
import '../../Widgets/Announcements Widgets/New Announcements Text Widget.dart';
import '../../Widgets/General Widgets/back_button Widget.dart';

class NewAnnouncementsPage extends StatefulWidget {
  const NewAnnouncementsPage({Key? key}) : super(key: key);

  @override
  State<NewAnnouncementsPage> createState() => _NewAnnouncementsPageState();
}

class _NewAnnouncementsPageState extends State<NewAnnouncementsPage> {
  late double width;
  late double height;
  late final dynamic firestoreProvider;
  late TextEditingController announcementTitle;
  late TextEditingController announcementBody;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    firestoreProvider = Provider.of<FirestoreProvider>(context, listen: false);
    firestoreProvider.fetchCurrentUserData();
    announcementTitle = TextEditingController();
    announcementBody = TextEditingController();
  }
  @override
  void dispose(){
    super.dispose();
    announcementBody.dispose();
    announcementTitle.dispose();
  }
  void removeDialog(){
    Navigator.pop(context);
  }
  void clearFields(){
    announcementTitle.clear();
    announcementBody.clear();
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: width * 0.01, right: width * 0.01),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(
                heading: 'CREATE NEW ANNOUNCEMENT',
              ),
              TitleText(text: 'Title'),
              SizedBox(height: 0.01*height,),
              Expanded(child: AnnouncementTextInputBox(control: announcementTitle,),flex: 1,),
              SizedBox(height: 0.01*height,),
              TitleText(text: 'Body'),
              SizedBox(height: 0.01*height,),
              Expanded(flex: 3,child: AnnouncementTextInputBox(control: announcementBody,),),
              SizedBox(height: 0.01*height,),
              Container(
                width: width,
                height: height*0.05,
                child: ElevatedButton(onPressed:() async {
                  if (_formKey.currentState!.validate()) {
                    ShowDialog.showErrorDialog(
                        context,
                        'Are you sure?',
                        'Are you sure you wish to post this announcement?',
                        'images/lotties/post.json',
                        'Cancel',
                        Colors.red,
                        'Post',
                        Colors.green, () async {
                      try {
                        await firestoreProvider.addAnnouncement(
                            announcementTitle.text.trim(), announcementBody.text
                            .trim());
                        clearFields();
                        removeDialog();
                      } catch (e) {
                        removeDialog();
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnack().customSnackBar(
                                'Could not post this announcement!', Colors.red,
                                height, width));
                      }
                    },
                        height,
                        width);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: MyConstants.homePageLeftMenuColor
                ), child: Text('POST NEW ANNOUNCEMENT!',
                    style: TextStyle(color: Colors.white),),),
              ),
              SizedBox(height: 0.01*height,),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  String text;
  TitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text,
      style: const TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold
      ),),
    );
  }
}
