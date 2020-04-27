import 'dart:async';
import 'dart:io';

import 'package:UturnJobs/const/page_str_const.dart';
import 'package:UturnJobs/const/size_const.dart';
import 'package:UturnJobs/util/UsefulVariables.dart';
import 'package:UturnJobs/util/cityListUpdate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
bool saving2=false;
final GlobalKey<ScaffoldState> _scaffoldKeyProfileCreate   =
new GlobalKey<ScaffoldState>();
String filePathidproof;
String filePathaddressproof;
File _image;
FirebaseUser user1;

class CreateProfile extends StatefulWidget {
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  String email;
  String gender='Male';
  AuthCredential credential1;
  bool resendClicked=false;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  CityList cityList=CityList();
  String _currentDate = 'Select Date';
  List _states = ["Andaman and Nicobar Islands", "Andhra Pradesh",
    "Arunachal Pradesh", "Assam","Bihar","Chandigarh","Chhattisgarh",
    "Dadra and Nagar Haveli","Daman and Diu","Delhi","Goa","Gujarat","Haryana",
    "Himachal Pradesh","Jammu and Kashmir","Jharkhand","Karnataka","Kerala",
    "Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland",
    "Odisha","Puducherry","Punjab","Rajasthan","Sikkim","Tamil Nadu",
    "Telangana","Tripura","Uttar Pradesh","Uttarakhand","West Bengal"];
  List _cities= ['Delhi'];
  List _idProof= ['Select','Aadhaar Card','Passport',
  'Driving License',
  'Election Comission ID Card',
  'Pan Card',
  'Pensioner Card having photo',
  'Kissan Passbook having photo'];
  List _addressProof=['Select','Aadhaar Card',
  'Passport',
  'Election Commission ID Card',
  'Ration Card with address',
  'Pensioner’s Card with address',
  'Kissan Passbook with address',
  ];
  String _currentIDProof = 'Select';
  String _currentAddressProof = 'Select';
  String _currentState = "Delhi";
  String _currentCity = "Delhi";

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerMobile = TextEditingController();
  //TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserEmail();
  }

  void getUserEmail()async{
    setState(() {
      saving2=true;
    });
    user1 =await _auth.currentUser();
    credential1 = EmailAuthProvider.getCredential(email: email,password: Variable.password);
    email=user1.email;
    setState(() {
      saving2=false;
    });
  }
  void changeDropDownStateItem(String selectedState) {
    setState(() {
      _currentState = selectedState;
      _currentCity=cityList.cityListUpdate(selectedState)[0];
      _cities=cityList.cityListUpdate(selectedState);

    });
  }
  void changeDropDownCityItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }

  void changeDropDownIDProofItem(String selectedIDProof) async {

    if(selectedIDProof!='Select') {
      filePathidproof = await FilePicker.getFilePath(type: FileType.ANY);
      final StorageReference storageRef =
      FirebaseStorage.instance.ref().child('$email/idproof');
      storageRef.putFile(File(filePathidproof));
    }
    setState(() {
      _currentIDProof = selectedIDProof;

    });

  }
  void changeDropDownAddressProofItem(String selectedAddressProof) async {
    if(selectedAddressProof!='Select') {
      filePathaddressproof = await FilePicker.getFilePath(type: FileType.ANY);
      final StorageReference storageRef =
      FirebaseStorage.instance.ref().child('$email/addressproof');
      storageRef.putFile(File(filePathaddressproof));
    }
    setState(() {
      _currentAddressProof = selectedAddressProof;
    });
  }
  Future _selectDate() async {
    DateTime picked = await showDatePicker(

        initialDatePickerMode: DatePickerMode.year,

        context: context,
        initialDate: new DateTime(2000),
        firstDate: new DateTime(1960),
        lastDate: new DateTime(2010),);
    if (picked != null)
      setState(
        () => _currentDate = picked.day.toString()+'/'+picked.month.toString()+'/'+picked.year.toString(),
      );
  }

  bool _male = true;
  bool _famele = false;

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: (){FocusScope.of(context).requestFocus(new FocusNode()); },
        child: Scaffold(
          key: _scaffoldKeyProfileCreate,
          appBar: AppBar(title: Text("CREATE PROFILE",style: TextStyle(color: Color(0xff01D45B),letterSpacing: 3),),backgroundColor: Color(0xFF1E3C44) ,
            centerTitle: true,
            elevation: 0,
            leading: GestureDetector(
                onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_forward_ios,color:Color(0xff01D45B) ,)),),
          body: ModalProgressHUD(
            inAsyncCall: saving2,
            child: Stack(
                children: <Widget>[
                  Container(
                    color: Color(0xFF1E3C44),
                    height: _media.height,
                    width: _media.width,
                  ),

              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        _image==null?Material(
                          elevation: 8,
                            shape: CircleBorder(),
                          color: Colors.white,

                          child: GestureDetector(
                            child: Icon(Icons.add,color: Color(0xff00CCFF),size: 80,),
                          onTap: ()async{
                            await getImage();
                          },
                        )):FlatButton(
                          onPressed: ()async{
                            await getImage();
                          },
                          child:Image.file(_image,width: 200,height: 300,)),
                        _image==null?SizedBox(
                          height: 30,
                        ):Container(height: 0,),
                        _image==null?Text(
                          "Upload Your Profile Picture",
                          style: TextStyle(
                            color: Color(0xff01D45B),
                            letterSpacing: 3,
                            fontSize: 15.0,
                            fontFamily: 'Montserrat',
                          ),
                        ):Container(height: 0,),
                        SizedBox(
                          height: 40,
                        ),
                        Column(

                          children: <Widget>[
                        fieldColorBox(
                             "FULL NAME", "Your Name",TextInputType.text, _controllerName),
                        fieldColorBox(
                             "AGE", "Your Age",TextInputType.number, _controllerAge),
                        dateColorBox(
                             "BIRTHDAY", _currentDate, _selectDate),
                        shadowColorBox(
                             "GENDER", "Male", "Female"),
                        Wrap(children: <Widget>[
                          stateColorBox(
                               "STATE", _currentState),
                        ]),
                        Wrap(children: <Widget>[
                        cityColorBox(
                             "CITY", _currentCity),
                        ]),
                        fieldColorBox(
                             "FULL ADDRESS", "Your Address",TextInputType.text, _controllerAddress),
                            fieldColorBox(
                                 "MOBILE", "Number",TextInputType.phone, _controllerMobile),
                            Wrap(children: <Widget>[
                              idColorBox(
                                   "UPLOAD PHOTO ID PROOF", _currentIDProof),
                            ]),
                            Wrap(children: <Widget>[
                              addressColorBox(
                                   "UPLOAD ADDRESS PROOF", _currentAddressProof),
                            ]),
                       ], ),
                        SizedBox(
                          height: 12,
                        ),
                        nexButton("Submit"),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
              ),
            ],
              ),
          ),

        ),
      ),
    );
  }

  Widget stateColorBox(
       String title, String currentState) {
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
              flex: 1,
              child: Text(
                title,
                style: TextStyle(fontSize: TEXT_SMALL_SIZE, color: Color(0xFF1E3C44), fontFamily: 'Montserrat'),
              ),
            ),
            Expanded(
              flex: 1,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  style: TextStyle(
                    fontSize: TEXT_SMALL_SIZE,
                    fontWeight: FontWeight.w600,
                      color: Color(0xFF1E3C44), fontFamily: 'Montserrat'                  ),
                  isExpanded: true,
                  onChanged: changeDropDownStateItem,
                  items: _states.map((items) {
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(
                        items,
                      ),
                    );
                  }).toList(),
                  value: currentState,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cityColorBox(
      String title, String currentCity, ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
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
              flex: 1,
              child: Text(
                title,
                style: TextStyle(fontSize: TEXT_SMALL_SIZE,fontFamily: 'Montserrat', color: Color(0xFF1E3C44)),
              ),
            ),
            Expanded(
              flex: 1,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  style: TextStyle(
                    fontSize: TEXT_SMALL_SIZE,
                    fontWeight: FontWeight.w600, color: Color(0xFF1E3C44), fontFamily: 'Montserrat'                  ),
                  isExpanded: true,
                  onChanged: changeDropDownCityItem,
                  items: _cities.map((items) {
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(
                        items,
                      ),
                    );
                  }).toList(),
                  value: currentCity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget idColorBox(
    String title, String currentIDProof, ) {
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
              flex: 1,
              child: Text(
                title,
                style: TextStyle(fontSize: TEXT_SMALL_SIZE, fontFamily: 'Montserrat',color: Color(0xFF1E3C44)),
              ),
            ),
            Expanded(
              flex: 1,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: TEXT_SMALL_SIZE,
                      color: Color(0xFF1E3C44), fontFamily: 'Montserrat'                  ),
                  isExpanded: true,
                  onChanged: changeDropDownIDProofItem,
                  items: _idProof.map((items) {
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(
                        items,
                      ),
                    );
                  }).toList(),
                  value: currentIDProof,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }Widget addressColorBox(
      String title, String currentAddressProof, ) {
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
              flex: 1,
              child: Text(
                title,
                style: TextStyle(fontSize: TEXT_SMALL_SIZE,fontFamily: 'Montserrat', color: Color(0xFF1E3C44)),
              ),
            ),
            Expanded(
              flex: 1,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: TEXT_SMALL_SIZE,
                      color: Color(0xFF1E3C44), fontFamily: 'Montserrat'
                  ),
                  isExpanded: true,
                  onChanged: changeDropDownAddressProofItem,
                  items: _addressProof.map((items) {
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(
                        items,
                      ),
                    );
                  }).toList(),
                  value: currentAddressProof,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget shadowColorBox(
     String title, String male, String famale) {
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
              flex: 1,
              child: Text(
                title,
                style: TextStyle(fontSize: TEXT_SMALL_SIZE,fontFamily: 'Montserrat', color: Color(0xFF1E3C44)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Wrap(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      male,
                      style: TextStyle(
                        fontSize: TEXT_SMALL_SIZE,
                        fontFamily: 'Montserrat',
                        color: _male ? Color(0xFF1E3C44) : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      gender=male;
                      setState(() {
                        _famele = false;
                        _male = true;
                      });
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    child: Text(
                      famale,
                      style: TextStyle(
                        fontSize: TEXT_SMALL_SIZE,
                        color: _famele ? Color(0xFF1E3C44) : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      gender=famale;
                      setState(() {
                        _famele = true;
                        _male = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fieldColorBox(String title, String text,TextInputType textInputType,
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
              flex: 1,
              child: Text(
                title,
                style: TextStyle(fontSize: TEXT_SMALL_SIZE, fontFamily: 'Montserrat',color: Color(0xFF1E3C44)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Wrap(
                children: <Widget>[
                  TextField(
                    style: TextStyle(
                        fontWeight: FontWeight.w600,

                        fontSize: TEXT_SMALL_SIZE, fontFamily: 'Montserrat',color: Color(0xFF1E3C44)
                    ),
                    keyboardType: textInputType,
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: text,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,

                            fontSize: TEXT_SMALL_SIZE, fontFamily: 'Montserrat',color: Colors.grey
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateColorBox(
     String title, String data, Function function) {
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
              flex: 1,
              child: Text(
                title,
                style: TextStyle(fontSize: TEXT_SMALL_SIZE, fontFamily: 'Montserrat',color: Color(0xFF1E3C44)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Wrap(
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      data,
                      style: TextStyle(
                        fontSize: TEXT_SMALL_SIZE,
                        fontFamily: 'Montserrat',color: data=='Select Date'?Colors.grey:Color(0xFF1E3C44),
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    onPressed: function,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nexButton(String text) {
    //DocumentSnapshot doc;
    DocumentReference docRef=_firestore.collection('UserProfiles').document('$email');
      //doc= await docRef.get();
    String smsCode;
    String verificationId;

    Future<bool> smsCodeDialog(BuildContext context) {
      return showDialog(

          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(

                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20) ) ,
                title: Text('SMS Verification Code'),
                content: Padding(
                  padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 10,top: 5),
                  child: TextField(

                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      smsCode = value;
                    },
                  ),
                ),
                contentPadding: EdgeInsets.all(10.0),

                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      color: Color(0xff00CCFF),
                      disabledColor: Colors.blueGrey,
                      elevation: 8,
                    disabledElevation: 0,
                    child: Container(child: Text('Resend',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
                      onPressed: resendClicked==true?null: ()async{
                        if(resendClicked==false) {
                          setState(() {
                            resendClicked = true;
                          });
                          Navigator.pop(context);
                          smsCodeDialog(context);
                        }
                        Toast.show(
                          'Requesting a new code..',
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.blueGrey,
                          textColor: Colors.black,
                        );
                        final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
                          verificationId = verId;
                        };

                        final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
                          verificationId = verId;
                          Toast.show(
                            'Code Resent!',
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM,
                            backgroundColor: Colors.blueGrey,
                            textColor: Colors.black,
                          );


                        };

                        final PhoneVerificationCompleted verifiedSuccess = (AuthCredential authCredential) {
                          authCredential=authCredential;
                          print('verified');

                        };

                        final PhoneVerificationFailed veriFailed = (AuthException exception) {
                          showInSnackBar(exception.message);

                        };

                        await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: "+91${_controllerMobile.text}",
                            codeAutoRetrievalTimeout: autoRetrieve,
                            codeSent: smsCodeSent,
                            timeout: const Duration(seconds: 0),
                            verificationCompleted: verifiedSuccess,
                            verificationFailed: veriFailed);
                      },
                ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      color: Color(0xff00CCFF),
                      elevation: 8,
                      child: Container(child: Text('Done',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                      onPressed: ()async {try {
                        Navigator.of(context).pop();
                        Toast.show(
                          'Verifying...',
                          context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.blueGrey,
                          textColor: Colors.black,
                        );


                        final AuthCredential credential = PhoneAuthProvider
                            .getCredential(
                          verificationId: verificationId,
                          smsCode: smsCode,
                        );

                        Toast.show(
                          'Loading...',
                          context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.TOP,
                          backgroundColor: Colors.blueGrey,
                          textColor: Colors.black,
                        );


                        await user1.linkWithCredential(credential);

                        if (user1 != null) {



                            final StorageReference storageRef =
                          FirebaseStorage.instance.ref().child('$email/dp');
                            StorageUploadTask uploadTask = storageRef.putFile(_image);
                            StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
                            String url = await storageTaskSnapshot.ref.getDownloadURL();
                          await docRef.setData({'FULL NAME': _controllerName.text,'AGE':_controllerAge.text,'BIRTHDAY':_currentDate,'GENDER':gender,'STATE':_currentState,'CITY':_currentCity,'FULL ADDRESS':_controllerAddress.text,'MOBILE':_controllerMobile.text,'DPURL':url});
                            Variable.email = email;
                            Navigator.pushNamedAndRemoveUntil(_scaffoldKeyProfileCreate.currentContext, PAGES[3], (Route<dynamic> route) => false);

                        }
                        setState(() {
                          saving2=false;
                        });

                      }
                      catch(e)
                      {
                        setState(() {
                          saving2=false;
                        });
                        Toast.show(
                          'Invalid Code!!',
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.blueGrey,
                          textColor: Colors.black,
                        );
                      }

                      },
                    ),
                  )
                ],
              ),
            );
          });
    }
    Future<void> verifyPhone() async {

      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
        verificationId = verId;
      };

      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        verificationId = verId;
        smsCodeDialog(context).then((value) {
          print('Signed in');
        });
      };

      final PhoneVerificationCompleted verifiedSuccess = (AuthCredential authCredential) {
        authCredential=authCredential;
        print('verified');

      };

      final PhoneVerificationFailed veriFailed = (AuthException exception) {
        showInSnackBar(exception.message);

      };

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+91${_controllerMobile.text}",
          codeAutoRetrievalTimeout: autoRetrieve,
          codeSent: smsCodeSent,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verifiedSuccess,
          verificationFailed: veriFailed);
    }


    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Color(0xff00CCFF),
      child: Text(
        text,
        style: TextStyle(letterSpacing: 1,fontSize: 20,color: Colors.white,fontFamily: 'Montserrat')
      ),
      onPressed: ()async{
      if(_image!=null&&_currentIDProof!='Select'&&filePathidproof!=null&&_currentAddressProof!='Select'&&filePathaddressproof!=null&&_controllerAddress.text!=null&&_controllerAge.text.isNotEmpty&&_controllerName.text.isNotEmpty&&_controllerMobile.text.isNotEmpty&&_image!=null&&_controllerAddress.text.isNotEmpty)
        {
          setState(() {
            saving2=true;
          });
        await verifyPhone();

    }
      else
        showInSnackBar('Please fill all the fields');
        },
    );
  }
  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKeyProfileCreate.currentState?.removeCurrentSnackBar();
    _scaffoldKeyProfileCreate.currentState.showSnackBar(new SnackBar(
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
}
