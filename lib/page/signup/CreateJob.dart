import 'dart:async';

import 'package:UturnJobs/const/size_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
bool saving2=false;
final GlobalKey<ScaffoldState> _scaffoldKeyCreateJob   =
new GlobalKey<ScaffoldState>();

class CreateJob extends StatefulWidget {
  @override
  _CreateJobState createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  String paytype="Lump Sum";


  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerPay = TextEditingController();

  void initState() {
    super.initState();
  }

  bool _perhour = false;
  bool _lumpsum = true;

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery
        .of(context)
        .size;

    return GestureDetector(
      onTap: (){FocusScope.of(context).requestFocus(new FocusNode()); },
      child: Scaffold(
        key: _scaffoldKeyCreateJob,
        appBar: AppBar(title: Text("POST A JOB",style: TextStyle(color:
        Color(0xff01D45B),letterSpacing: 3),),backgroundColor: Color(0xFF1E3C44) ,
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
              onTap:(){Navigator.pop(context);},
              child: Icon(Icons.keyboard_arrow_down,color:Color(0xff01D45B) ,size: 40,)),),
        body: ModalProgressHUD(
          inAsyncCall: saving2,

          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  height: _media.height,
                  width: _media.width,
                  color: Color(0xFF1E3C44),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Image.asset('assets/images/logo.png',width: 180,)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Tell us about the job",style: TextStyle(
                      color: Color(0xff00CCFF),
                      letterSpacing: 3,
                      fontSize: 22.0,
                      fontFamily: 'Montserrat',
                    ),),
                    SizedBox(
                      height: 40,
                    ),
                    Column(

                      children: <Widget>[
                        fieldColorBox(
                            "Job Title", "eg. Need an affidavit from Lawyer",
                            TextInputType.text, _controllerTitle),
                        fieldColorBox(
                            "Description", "Desciribe your job requirments ",
                            TextInputType.text, _controllerDescription),

                        fieldColorBox(
                            "Pay Amount", "Amount in Rs",
                            TextInputType.number, _controllerPay),
                        shadowColorBox(
                            "Pay Format", "Per Hour",
                            "Lump Sum"),
                      ],),
                    SizedBox(
                      height: 20,
                    ),
                    nexButton("POST"),
                    SizedBox(
                      height: 20,
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }


  Widget shadowColorBox( String title, String perhour,
      String lumpsum) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              paytype = perhour;
              setState(() {
                _lumpsum = false;
                _perhour = true;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 23.0,
                right: 23,
                bottom: 12,
              ),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xff01D45B),
                  borderRadius: BorderRadius.circular(20),


                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        perhour,
                        style: TextStyle(fontSize: TEXT_NORMAL_SIZE,fontWeight:_perhour ?FontWeight.bold:FontWeight.normal, color: _perhour ? Color(0xFF1E3C44) : Colors.grey),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        _controllerPay.text.isNotEmpty ? "Rs ${_controllerPay
                            .text} per hour" : 'per hour payment',
                        style: TextStyle(
                          fontSize: 12,
                          color: _perhour ? Color(0xFF1E3C44) : Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              paytype = lumpsum;
              setState(() {
                _lumpsum = true;
                _perhour = false;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25,
                bottom: 12,
              ),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xff01D45B),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 30,
                      offset: Offset(1.0, 9.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        lumpsum,
                        style: TextStyle(fontSize: TEXT_NORMAL_SIZE,fontWeight:  _lumpsum ?FontWeight.bold:FontWeight.normal, color: _lumpsum ? Color(0xFF1E3C44) : Colors.grey),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        _controllerPay.text.isNotEmpty?"Rs ${_controllerPay.text} one-time":'one-time payment',
                        style: TextStyle(
                          fontSize: 12,
                          color: _lumpsum ? Color(0xFF1E3C44) : Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fieldColorBox( String title, String text,
      TextInputType textInputType,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25,
        bottom: 12,
      ),
      child: Container(
        height: 50,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),

        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 30,
            ),
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: TextStyle(fontSize: TEXT_SMALL_SIZE, color: Color(0xFF1E3C44)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Wrap(
                children: <Widget>[
                  TextField(
                    onChanged: (text){
                      if(title=='Pay Amount'&&double.parse(text)<=5000)
                        setState(() {
                          _controllerPay.text;
                        });
                      else
                      if (title == 'Pay Amount' && double.parse(text) > 5000) {
                        showInSnackBar('Pay should not be greater than ₹5000');
                        setState(() {
                          _controllerPay.text = '5000';
                          controller.text = '5000';
                        });
                      }
                    },
                    style: TextStyle(
                        fontSize: TEXT_SMALL_SIZE, color: Color(0xFF1E3C44),fontFamily: 'Montserrat' ),
                    keyboardType: textInputType,
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: text,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: TEXT_SMALL_SIZE, color: Colors.grey,fontFamily: 'Montserrat' )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    FocusScope.of(_scaffoldKeyCreateJob.currentState.context).requestFocus(new FocusNode());
    _scaffoldKeyCreateJob.currentState?.removeCurrentSnackBar();
    _scaffoldKeyCreateJob.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Widget nexButton(String text) {
    FirebaseUser user;
    String email;

    Future<void> postJob() async {
      try {
        user = await _auth.currentUser();
        email = user.email;
        DocumentReference docRef2;
        DocumentSnapshot doc2;
        String name;
        String whatsapp;
        String state;
        String city;
        docRef2 = _firestore.collection('UserProfiles').document(email);
        doc2 = await docRef2.get();
        if (doc2.data != null) {
          state = doc2.data['STATE'].toString();
          city = doc2.data['CITY'].toString();
          whatsapp = doc2.data['MOBILE'].toString();
          name = doc2.data['FULL NAME'].toString();
        }
        print(name);
        DocumentReference docRef = _firestore.collection('Jobs').document(email);
        DocumentSnapshot profileSnap = await _firestore.collection('UserProfiles').document(email).get();
        String dpUrl=profileSnap.data['DPURL'];
        await docRef.setData({
          'Name':name,
          'Job Title': _controllerTitle.text,
          'Job Description': _controllerDescription.text,
          'Pay Type': paytype,
          'Pay': _controllerPay.text,
          'State': state,
          'City': city,
          'WhatsApp': whatsapp,
          'Email': email,
          'DpUrl': dpUrl,
          'day': DateTime.now().day,
          'month' : DateTime.now().month,
          'year': DateTime.now().year,
          'date': DateTime.now().toString()
        });
        setState(() {
          saving2 = false;
        });
        showDialog(
            barrierDismissible: false,
            context: context, builder: (_) =>
            AssetGiffyDialog(
              image: Image.asset(
                'assets/images/createjob/published.png', fit: BoxFit.contain,),
              title: Text('Published!',
                style: TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              description: Text(
                'Soon you would be contacted by your potential employee!',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              buttonOkColor: Color(0xff00CCFF),
              onOkButtonPressed: () {
                Navigator.pop(_scaffoldKeyCreateJob.currentState.context);
                Navigator.pop(_scaffoldKeyCreateJob.currentState.context);
              },
              onlyOkButton: true,));
      }
      catch (e) {
        setState(() {
          saving2 = false;
        });
        showInSnackBar(e.message);
      }
    }

    return Padding(

      padding: const EdgeInsets.only(bottom: 30.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Color(0xff00CCFF),
        onPressed: () async {
          if (_controllerPay.text.isNotEmpty &&
              _controllerTitle.text.isNotEmpty &&
              _controllerDescription.text.isNotEmpty) {
            if (double.parse(_controllerPay.text) <= 5000) {
              setState(() {
                saving2 = true;
              });
              await postJob();
            }
            else
              showInSnackBar('Pay should not be greater than ₹5000');
          }
          else {
            showInSnackBar('Please fill in all the fields correctly');
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 10.0),
          child: Text('Post',style: TextStyle(letterSpacing: 1,fontSize: 20,color: Colors.white,fontFamily: 'Montserrat'),),
        ),
      ),
    );
  }
}
