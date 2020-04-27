import 'package:UturnJobs/const/color_const.dart';
import 'package:UturnJobs/const/page_str_const.dart';
import "package:UturnJobs/util/SizeUtil.dart";
import 'package:UturnJobs/util/UsefulVariables.dart';
import 'package:UturnJobs/util/cityListUpdate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';

import 'feed_const.dart';
final GlobalKey<ScaffoldState> scaffoldKeyFeedPage = GlobalKey<ScaffoldState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
var initializationSettingsAndroid = AndroidInitializationSettings(
    'ic_stat_name');
var initializationSettingsIOS = IOSInitializationSettings();
var initializationSettings = InitializationSettings(
    initializationSettingsAndroid, initializationSettingsIOS);
var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    '0', 'UturnJobs', 'Alert regarding your payment',
    importance: Importance.Max, priority: Priority.High);
var iOSPlatformChannelSpecifics = IOSNotificationDetails();
var platformChannelSpecifics = NotificationDetails(
    androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

bool saving1=false;
Firestore _firestore=Firestore.instance;
CityList cityList=CityList();
List states = ["Any","Andaman and Nicobar Islands", "Andhra Pradesh", "Arunachal Pradesh", "Assam","Bihar","Chandigarh","Chhattisgarh","Dadra and Nagar Haveli","Daman and Diu","Delhi","Goa","Gujarat","Haryana","Himachal Pradesh","Jammu and Kashmir","Jharkhand","Karnataka","Kerala","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Puducherry","Punjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh","Uttarakhand","West Bengal"];
List cities= ['Any'];
List time= ['Today','Past 3 days','Past 7 days'];
List sort= ['Newest First', 'Oldest First'];
List support =['Select','Feedback','Payment Issue','Other'];
String currentSupport = "Select";

String currentState = "Any";
String currentCity = "Any";
String currentTime = "Past 3 days";
String currentSort = 'Newest First';
class JobListings extends StatefulWidget {

  @override
  _JobListingsState createState() => _JobListingsState();

}

class _JobListingsState extends State<JobListings> {


  TextEditingController reasonController=TextEditingController();

  void changeDropDownStateItem(String selectedState) {
    setState(() {
      currentState = selectedState;
      currentCity=cityList.cityListUpdateFilter(selectedState)[0];
      cities=cityList.cityListUpdateFilter(selectedState);
    });
  }

  void changeDropDownCityItem(String selectedCity) {
    setState(() {
      currentCity = selectedCity;
    });
  }

  void changeDropDownSortItem(String selectedSort) {
    setState(() {
      currentSort = selectedSort;
    });
  }

  void changeDropDownTimeItem(String selectedTime) {
    setState(() {
      currentTime = selectedTime;
    });
  }

  void changeDropDownSupportItem(String selectedSupport) {
    setState(() {
      currentSupport = selectedSupport;
    });
  }

  void _postJob(){
    Navigator.pushNamed(scaffoldKeyFeedPage.currentContext, PAGES[4]);
  }


  Future<bool> _onWillPop() {
    if(scaffoldKeyFeedPage.currentState.isDrawerOpen)
      Navigator.pop(context);
    else if(!scaffoldKeyFeedPage.currentState.isDrawerOpen)
      scaffoldKeyFeedPage.currentState.openDrawer();

    return scaffoldKeyFeedPage??false;
  }

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if (Variable.newUser == true)
      Navigator.pushNamed(context, PAGES[8]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[DrawerHeader(
              child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text("UTURN JOBS",style: TextStyle(fontSize: 20,color: TEXT_BLACK,letterSpacing: 3,fontWeight: FontWeight.w700),),
                    FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
                        onPressed: (){Navigator.pop(context);},
                        child: Icon(Icons.arrow_back_ios,size: 32,))
                  ]),
              decoration: BoxDecoration(
                color: Color(0xff01D45B),
              ),
            ),
              ListTile(
                  title: Text('New Here?'),
                  onTap: () {
                    Navigator.pushNamed(
                        scaffoldKeyFeedPage.currentContext, PAGES[8]);
                  }),
              ListTile(
                  title: Text('My Profile'),
                  onTap: (){
                    Navigator.pushNamed(scaffoldKeyFeedPage.currentContext,PAGES[5]);
                  }),
              ListTile(
                  title: Text('Your Purchases'),
                  onTap: (){
                    Navigator.pushNamed(scaffoldKeyFeedPage.currentContext, PAGES[6]);}),
              ListTile(
                  title: Text('Failed Purchases'),
                  onTap: (){
                    Navigator.pushNamed(scaffoldKeyFeedPage.currentContext, PAGES[7]);}),


              ListTile(
                title: Text('Contact Support'),
                onTap: () {
                  Navigator.pop(context);
                  String hintText='Select an option first';
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {return StatefulBuilder(
                          builder: (context, setState){
                            return AlertDialog(

                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20) ) ,
                              title: Text('How can we help you'),
                              content: Container(
                                height: MediaQuery.of(context).size.height/4,
                                child: Padding(
                                  padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 10,top: 25),
                                  child: Column(
                                    children: <Widget>[
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isDense: true,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                          isExpanded: true,
                                          onChanged: (value){
                                            setState(() {
                                              if(value!='Select')
                                                hintText='Tell us more about it';
                                              else
                                                hintText='Select an option first';
                                              currentSupport = value;
                                            });},
                                          items: support.map((items) {
                                            return DropdownMenuItem<String>(
                                              value: items,
                                              child: Text(
                                                items,
                                              ),
                                            );
                                          }).toList(),
                                          value: currentSupport,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextField(
                                        maxLines: null,
                                        style: TextStyle(color: Color(0xFF1E3C44),fontFamily: 'Montserrat' ),
                                        controller: reasonController,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(hintText: hintText,hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Montserrat' )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.all(10.0),

                              actions: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.only(right:20.0),
                                  child: RaisedButton(
                                      color: Colors.grey,
                                      disabledColor: Colors.blueGrey,
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      disabledElevation: 0,
                                      child: Container(child: Text('Cancel',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
                                      onPressed:(){Navigator.pop(context);}
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right:20.0),
                                  child: RaisedButton(

                                    color: Color(0xff00CCFF),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    elevation: 8,
                                    child: Container(child: Text('Send',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                    onPressed: ()async {
                                      if(currentSupport=='Select')
                                        Toast.show(
                                          'Please select an option',
                                          context,
                                          duration: 3,
                                          gravity: Toast.CENTER,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                        );
                                      else if(reasonController.text.isEmpty)
                                        Toast.show(
                                          'Please tell us more about it',
                                          context,
                                          duration: 3,
                                          gravity: Toast.CENTER,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                        );
                                      else {
                                        final MailOptions mailOptions = MailOptions(
                                          body: reasonController.text.toString(),
                                          subject: 'UturnSupport $currentSupport ${Variable.email}',
                                          recipients: ['utjobs@outlook.com','support@uturnjobs.com'],
                                          isHTML: true,
                                          bccRecipients: ['varunmohan05@gmail.com'],
                                          // ccRecipients: ['third@example.com'],
                                          //  attachments: [ 'path/to/image.png', ],
                                        );

                                        Navigator.of(context).pop();

                                        try {
                                          await FlutterMailer.send(mailOptions);
                                        }
                                        catch(e) {
                                          showInSnackBar('Error! Gmail must be installed');
                                        }
                                      }
                                    },
                                  ),
                                )
                              ],
                            );}
                      );
                      });
                },
              ),

              ListTile(
                title: Text('Sign Out'),
                onTap: () {
                  Alert(
                    context: context,
                    type: AlertType.info,
                    title: "SIGN OUT",
                    desc: "Do you wish to sign out?",
                    buttons: [
                      DialogButton(
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            try {
                              FirebaseAuth auth=FirebaseAuth.instance;
                              await auth.signOut().whenComplete((){Navigator.pushNamedAndRemoveUntil(
                                  context, PAGES[0], (Route<dynamic> route) => false);});
                            }
                            catch(e) {
                              Toast.show(
                                '${e.message}',
                                context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.CENTER,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              );                      }
                          },
                          color: Color(0xff00CCFF)
                      ),
                      DialogButton(
                        child: Text(
                          "No",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: Colors.grey,
                      )
                    ],
                  ).show();
                },
              ),],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        key: scaffoldKeyFeedPage,
        floatingActionButton: FloatingActionButton(

          backgroundColor: Color(0xff01D45B),

          onPressed: _postJob,
          tooltip: 'Post A Job',
          child: Icon(Icons.keyboard_arrow_up,color: Color(0xFF1E3C44),size: 50,),
        ),
        appBar: AppBar(title: Text("JOB LISTINGS",style: TextStyle(color: Color(0xff01D45B),letterSpacing: 3),),backgroundColor: Color(0xFF1E3C44) ,
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
              onTap:(){scaffoldKeyFeedPage.currentState.openDrawer();},child: Icon(Icons.menu,color:Color(0xff01D45B) ,)),),
        body: ModalProgressHUD(
          inAsyncCall: saving1,
          child: Container(
            color: Color(0xFF1E3C44),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Wrap(children: <Widget>[
                  stateColorBox(
                      "STATE", currentState),
                  cityColorBox(
                      "CITY", currentCity),
                  timeColorBox("TIME", currentTime),

                  sortColorBox("SORT", currentSort)
                ]),


                Expanded(
                  child: JobStream(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget stateColorBox(String title, String currentState) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20,
        bottom: 8,
      ),
      child: Container(
        height: 25,
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
                style: TextStyle(fontSize: 12, color:  Color(0xFF1E3C44)),
              ),
            ),
            Expanded(
              flex: 2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  style: TextStyle(
                    fontSize: 14,
                    color:  Color(0xFF1E3C44),
                  ),
                  isExpanded: true,
                  onChanged: changeDropDownStateItem,
                  items: states.map((items) {
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

  Widget cityColorBox(String title, String currentCity, ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20,
        bottom: 8,
      ),
      child: Container(
        height: 25,
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
                style: TextStyle(fontSize: 12, color: Color(0xFF1E3C44)),
              ),
            ),
            Expanded(
              flex: 2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1E3C44),
                  ),
                  isExpanded: true,
                  onChanged: changeDropDownCityItem,
                  items: cities.map((items) {
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

  Widget sortColorBox(String title, String currentState) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20,
        bottom: 8,
      ),
      child: Container(
        height: 25,
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
                style: TextStyle(fontSize: 12, color: Color(0xFF1E3C44)),
              ),
            ),
            Expanded(
              flex: 2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1E3C44),
                  ),
                  isExpanded: true,
                  onChanged: changeDropDownSortItem,
                  items: sort.map((items) {
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(
                        items,
                      ),
                    );
                  }).toList(),
                  value: currentSort,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeColorBox(String title, String currentState) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20,
        bottom: 8,
      ),
      child: Container(
        height: 25,
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
                style: TextStyle(fontSize: 12, color: Color(0xFF1E3C44)),
              ),
            ),
            Expanded(
              flex: 2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1E3C44),
                  ),
                  isExpanded: true,
                  onChanged: changeDropDownTimeItem,
                  items: time.map((items) {
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(
                        items,
                      ),
                    );
                  }).toList(),
                  value: currentTime,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(

        stream: _firestore
            .collection(
            'Jobs')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }


          final jobs = currentSort=='Newest First'?snapshot.data.documents.reversed:snapshot.data.documents;

          List<JobBubble> jobBubbles = [];
          for (var job in jobs) {
            final jobTitle = job.data['Job Title'];
            final jobDescription = job.data['Job Description'];
            final pay = job.data['Pay'];
            final state = job.data['State'];
            final city = job.data['City'];
            final payType = job.data['Pay Type'];
            final whatsApp = job.data['WhatsApp'];
            final name = job.data['Name'];
            final dpUrl= job.data['DpUrl'];
            final String date= job.data['date'];
            final String jobEmail=job.data['Email'];
            bool success=false;

            if((state==currentState&&city==currentCity)||currentState=='Any'||(currentState==state&&currentCity=='Any')) {
              switch(currentTime) {   case 'Today':       if(DateTime.now().difference(DateTime.parse(date)).inDays==0)
                success=true;
              break;

                case 'Past 3 days': if(DateTime.now().difference(DateTime.parse(date)).inDays<=2)
                  success=true;
                break;

                case 'Past 7 days': if(DateTime.now().difference(DateTime.parse(date)).inDays<=7)
                  success=true;
                break;
              }
              if(success)
                jobBubbles.add(JobBubble(
                  jobEmail:jobEmail,
                  dpUrl: dpUrl,
                  name: name,
                  jobTitle: jobTitle,
                  jobDescription: jobDescription,
                  pay: pay,
                  state: state,
                  city: city,
                  payType: payType,
                  whatsApp: whatsApp,
                ));
            }
          }
          return ListView(
            reverse: false,
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
            children: jobBubbles,

          );
        }
    );
  }
}

class JobBubble extends StatelessWidget {
  JobBubble({this.jobEmail,this.dpUrl,this.name,this.jobTitle, this.jobDescription, this.pay,this.state,this.city, this.payType, this.whatsApp});

  final String jobEmail;
  final dpUrl;
  final String name;
  final String jobTitle;
  final String jobDescription;
  final String pay;
  final String state;
  final String city;

  final String payType;
  final String whatsApp;


  @override
  Widget build(BuildContext context) {
    double finalpay=double.parse(pay)*5;

    return GestureDetector(
      onTap: (){
        if(jobEmail!=Variable.email) {

          showDialog(
              context: context,builder: (_) => AssetGiffyDialog(
            image: Image.asset('assets/images/feed/takeup.png',fit: BoxFit.contain,),
            title: Text('Take Up The Job?',
              style: TextStyle(
                  fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            description: Text('Get this job for Rs ${finalpay/100} only! After successful payment you will be connected to the employer via WhatsApp.',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            buttonOkColor: Color(0xff00CCFF),
            onOkButtonPressed: () async{
              Navigator.pop(context);

              Toast.show(
                'Please wait...',
                context,
                duration: 2,
                gravity: Toast.CENTER,
                backgroundColor: Colors.grey,
                textColor: Colors.black,
              );

              DocumentSnapshot doc=await _firestore.collection('UserProfiles').document('${Variable.email}').get();

              String employeeName=doc.data['FULL NAME'];
              String employeeMobile=doc.data['MOBILE'];
              String employeeCity=doc.data['CITY'];
              String employeeState=doc.data['STATE'];

              void _handlePaymentSuccess(PaymentSuccessResponse response)async {
                await flutterLocalNotificationsPlugin.show(
                    0, 'Payment Successful!', 'good luck for the job!',
                    platformChannelSpecifics);
                showDialog(
                    barrierDismissible: false,
                    context: context, builder: (_) =>
                    AssetGiffyDialog(
                      image: Image.asset(
                        'assets/images/createjob/published.png', fit: BoxFit.contain,),
                      title: Text('Congratulations!',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600),
                      ),
                      description: Text(
                        'You are now connected with your employer',
                        textAlign: TextAlign.center,
                        style: TextStyle(),
                      ),
                      buttonOkColor: Color(0xff00CCFF),
                      onOkButtonPressed: () async {
                        Navigator.pop(context);
                      },
                      onlyOkButton: true,));
                await _firestore.collection('Jobs')
                    .document(Variable.email)
                    .delete();

                Navigator.pop(scaffoldKeyFeedPage.currentState.context);

                Toast.show(
                  'Please wait...',
                  context,
                  duration: 3,
                  gravity: Toast.CENTER,
                  backgroundColor: Colors.grey,
                  textColor: Colors.black,
                );
                try {
                  await _firestore.collection('PaymentSuccess')
                      .document(response.paymentId)
                      .setData({
                    'Job_title': jobTitle,
                    'Job_desc': jobDescription,
                    'Employee_name': employeeName,
                    'Employee_mob': employeeMobile,
                    'Employee_city': employeeCity,
                    'Employee_state': employeeState,
                    'Employee_email': Variable.email,
                    'Employer_name': name,
                    'Employer_mob': whatsApp,
                    'Employer_city': city,
                    'Employer_state': state,
                    'Employer_email': jobEmail,
                    'Amount_rs': '${finalpay / 100}',
                    'Payment_id': response.paymentId,
                  });
                }
                catch (e) {
                  Toast.show(
                    'Error recording transaction, ignoring..',
                    context,
                    duration: 3,
                    gravity: Toast.CENTER,
                    backgroundColor: Colors.grey,
                    textColor: Colors.black,
                  );
                }
                try {
                  FlutterLaunch.launchWathsApp(phone: '+91$whatsApp',
                      message: "Hello, contacting you regarding your Ad placed on UTurnJobs");
                }
                catch (e) {
                  await sendSMS(
                      message: "Hello, contacting you regarding your Ad placed on UTurnJobs",
                      recipients: ['+91$whatsApp'])
                      .catchError((onError) {
                    print(onError);
                  });
                }
              }
              void _handlePaymentError(PaymentFailureResponse response)async {
                await flutterLocalNotificationsPlugin.show(
                    0, 'Payment Failed!', 'please try again or contact support',
                    platformChannelSpecifics);
                Toast.show(
                  'Payment failed! Please retry or contact support',
                  context,
                  duration: 5,
                  gravity: Toast.CENTER,
                  backgroundColor: Colors.grey,
                  textColor: Colors.black,
                );
                await _firestore.collection('PaymentFailure').document().setData({
                  'Job_title':jobTitle,
                  'Job_desc':jobDescription,
                  'Employee_name':employeeName,
                  'Employee_mob':employeeMobile,
                  'Employee_city':employeeCity,
                  'Employee_state':employeeState,
                  'Employee_email': Variable.email,
                  'Employer_name': name,
                  'Employer_mob': whatsApp,
                  'Employer_city':city,
                  'Employer_state':state,
                  'Employer_email': jobEmail,
                  'Amount_rs': '${finalpay / 100}',
                  'Payment_error':'${response.message.toString()}'});
              }

              var _razorpay = Razorpay();
              var options = {
                'key': 'rzp_live_Pb6pprIEVvlG1E',
                'amount': finalpay,
                'name': 'Uturn Jobs',
                'description': '',
                'prefill': {
                  'contact': '',
                  'email': ''
                }
              };
              _razorpay.open(options);

              _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
              _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,_handlePaymentError);
            },
          ) );
        }
        else {
          Alert(
            context: context,
            type: AlertType.info,
            title: "DELETE",
            desc: "Do you wish to delete your job post?",
            buttons: [
              DialogButton(
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () async {
                    try {
                      Navigator.pop(context);
                      await _firestore.collection('Jobs').document(Variable.email).delete();
                    }
                    catch(e) {
                      Navigator.pop(context);
                      Toast.show(
                        '${e.message}',
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.CENTER,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );                      }
                  },
                  color: Color(0xff00CCFF)
              ),
              DialogButton(
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                color: Colors.grey,
              )
            ],
          ).show();
        }
      },

      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Container(
          alignment: AlignmentDirectional.topStart,
          constraints: BoxConstraints.expand(height: SizeUtil.getAxisY(240.0)),
          child: Stack(
            children: <Widget>[
              _listItemContent(name,jobTitle,jobDescription,pay,state,city,payType),
              Positioned(
                width: SizeUtil.getAxisBoth(130.0),
                height: SizeUtil.getAxisBoth(130.0),
                bottom: SizeUtil.getAxisY(41.0),
                left: SizeUtil.getAxisX(27.0),
                child: CircleAvatar(backgroundImage: NetworkImage(dpUrl)),
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

Widget _listItemContent(String name,String jobTitle,String jobDescription,String pay,String state,String city,String payType) => Positioned(
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
          child: _textBack('Pay: ₹$pay${payType=='Lump Sum'?'':'/hr'}',isBold: true),
        ),
        Positioned(
          bottom: SizeUtil.getAxisY(60.0),
          left: SizeUtil.getAxisX(80.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color:  Color(0xFF1E3C44),
                  size: SizeUtil.getAxisBoth(30.0),
                ),
                SizedBox(
                  width: SizeUtil.getAxisX(16.0),
                ),
                _textBack("$city, $state"),
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
                Icons.person,
                color:  Color(0xFF1E3C44),
                size: SizeUtil.getAxisBoth(30.0),
              ),
              SizedBox(
                width: SizeUtil.getAxisX(16.0),
              ),
              _textBack(name),
            ],
          ),
        ),
      ],
    ),
  ),
);
void showInSnackBar(String value) {
  FocusScope.of(scaffoldKeyFeedPage.currentState.context).requestFocus(new FocusNode());
  scaffoldKeyFeedPage.currentState?.removeCurrentSnackBar();
  scaffoldKeyFeedPage.currentState.showSnackBar(new SnackBar(
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
