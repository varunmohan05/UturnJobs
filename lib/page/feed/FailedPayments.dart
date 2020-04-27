import 'package:UturnJobs/const/color_const.dart';
import 'package:UturnJobs/page/feed/feed_const.dart';
import 'package:UturnJobs/util/SizeUtil.dart';
import 'package:UturnJobs/util/UsefulVariables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class FailedPayments extends StatelessWidget {
  Firestore _firestore=Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(

        stream: _firestore.collection('PaymentFailure').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }


          final paymentFails =snapshot.data.documents.reversed;
          DocumentSnapshot fail;
          List<JobFailBubble> jobFailBubbles = [];
          for(fail in paymentFails)
            {
              if(fail.data['Employee_email']==Variable.email)
                {

                  String jobTitle=fail.data['Job_title'];
                  String jobDesc=fail.data['Job_desc'];
                  String name=fail.data['Employer_name'];
                  String whatsApp=fail.data['Employer_mob'];
                  String amount=fail.data['Amount_rs'];
                  String message=fail.data['Payment_error'];

                  jobFailBubbles.add(JobFailBubble(
                    name: name,
                    jobTitle: jobTitle,
                    jobDesc :jobDesc,
                    amount: amount,
                    message:message,
                    whatsApp: whatsApp,
                  ));
                }
            }


          return Scaffold(
            backgroundColor:Color(0xFF1E3C44) ,
            appBar: AppBar(title: Text("FAILED PURCHASES",style: TextStyle(color:
            Color(0xff01D45B),letterSpacing: 3),),backgroundColor: Color(0xFF1E3C44) ,
              centerTitle: true,
              elevation: 0,
              leading: GestureDetector(
                  onTap:(){Navigator.pop(context);},
                  child: Icon(Icons.arrow_forward_ios,color:Color(0xff01D45B) ,)),),
            body: SafeArea(
              child: ListView(
                reverse: false,
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
                children: jobFailBubbles,

              ),
            ),
          );
        }
    );
  }
}

class JobFailBubble extends StatelessWidget {
  JobFailBubble({this.name,this.jobTitle,this.jobDesc,this.amount,this.message,this.whatsApp,});
    final String name;
    final String jobTitle;
    final String jobDesc;
    final String message;
    final String amount;
    final String whatsApp;


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        {
            Toast.show(
              'Contact Support!!',
              context,
              duration: 2,
              gravity: Toast.CENTER,
              backgroundColor: Colors.grey,
              textColor: Colors.black,
            );

        }
      },

      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Container(
          alignment: AlignmentDirectional.topStart,
          constraints: BoxConstraints.expand(height: SizeUtil.getAxisY(240.0)),
          child: Stack(
            children: <Widget>[
              _listItemContent(name,jobTitle,jobDesc,amount,message),
              Positioned(
                width: SizeUtil.getAxisBoth(130.0),
                height: SizeUtil.getAxisBoth(130.0),
                bottom: SizeUtil.getAxisY(41.0),
                left: SizeUtil.getAxisX(27.0),
                child: CircleAvatar(backgroundColor: Colors.white,
                  child: Icon(Icons.do_not_disturb,color: Colors.grey,size: 45,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _textBack(content,
    {color = TEXT_BLACK_LIGHT,
      size = TEXT_SMALL_2_SIZE,
      isBold = false}) =>
    Text(
      content,
      style: TextStyle(
          color:  Color(0xFF1E3C44),
          fontSize: SizeUtil.getAxisBoth(size),
          fontWeight: isBold ? FontWeight.w700 : null),
    );

Widget _listItemContent(String name,String jobTitle,String jobDescription,String amount,String message) => Positioned(
  bottom: 0.1,
  left: SizeUtil.getAxisX(100.0),
  child: Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 8.0,
          spreadRadius: 0.0,
          offset: Offset(3.0, 4.0), // shadow direction: bottom right
        )
      ],
      borderRadius: BorderRadius.circular(
        SizeUtil.getAxisBoth(22.0),
      ),
      color:Color(0xff00CCFF),
    ),
    height: SizeUtil.getAxisY(220.0),
    width: SizeUtil.getAxisY(528.0),
    child: Stack(
      children: <Widget>[
        Positioned(
          top: SizeUtil.getAxisY(20.0),
          left: SizeUtil.getAxisX(80.0),
          child: _textBack(jobTitle,
              size: TEXT_SMALL_3_SIZE, isBold: true),
        ),
        Positioned(
          top: SizeUtil.getAxisY(60.0),
          left: SizeUtil.getAxisX(80.0),
          child:
          _textBack(jobDescription, size: TEXT_SMALL_SIZE),
        ),
        Positioned(
          top: SizeUtil.getAxisY(172.0),
          right: SizeUtil.getAxisX(20.0),
          child: _textBack('for ₹$amount',isBold: true),
        ),
        Positioned(
          bottom: SizeUtil.getAxisY(60.0),
          left: SizeUtil.getAxisX(80.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.person,
                  color:  Color(0xFF1E3C44),
                  size: SizeUtil.getAxisBoth(30.0),
                ),
                SizedBox(
                  width: SizeUtil.getAxisX(16.0),
                ),
                _textBack("$name"),
              ]),
        ),
        Positioned(
          bottom: SizeUtil.getAxisY(20.0),
          left: SizeUtil.getAxisX(80.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.warning,
                color:  Colors.red,
                size: SizeUtil.getAxisBoth(30.0),
              ),
              SizedBox(
                width: SizeUtil.getAxisX(16.0),
              ),
              _textBack('$message'),
            ],
          ),
        ),
      ],
    ),
  ),
);
