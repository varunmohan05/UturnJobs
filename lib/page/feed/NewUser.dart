import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class NewUser extends StatelessWidget {
  final pages = [
    PageViewModel(
      pageColor: const Color(0xFF1E3C44),
      bubbleBackgroundColor: Color(0xff00CCFF),
      body: Text(
        'Welcome! \nSwipe to know more',
        style: TextStyle(fontSize: 20),
      ),
      title: Text('Hello',
          style: TextStyle(color: Color(0xff01D45B), letterSpacing: 3)),
      mainImage: Image.asset(
        'assets/images/logo2.png',
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor: const Color(0xFF1E3C44),
      bubbleBackgroundColor: Color(0xff00CCFF),
      body: Text(
          'One tap and the job is yours\nTap on the bubble to get in touch with the employer directly',
          style: TextStyle(fontSize: 20)),
      title: Text(
        'Take up jobs!',
        style: TextStyle(
          color: Color(0xff01D45B),
          letterSpacing: 3,
        ),
        textAlign: TextAlign.center,
      ),
      mainImage: Image.asset(
        'assets/images/feed/job.png',
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor: Color(0xFF1E3C44),
      bubbleBackgroundColor: Color(0xff00CCFF),
      body: Text('4 basic filters to find the perfect job for you',
          style: TextStyle(fontSize: 20)),
      title: Text(
        'Job search\nends here',
        style: TextStyle(color: Color(0xff01D45B), letterSpacing: 3),
        textAlign: TextAlign.center,
      ),
      mainImage: Image.asset(
        'assets/images/feed/filters.png',
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor: const Color(0xFF1E3C44),
      bubbleBackgroundColor: Color(0xff00CCFF),
      body: Text(
          'Get your laptop fixed without having to walk to any expensive store\nAsk for one-time help from your friendly neighbourhood',
          style: TextStyle(fontSize: 20)),
      title: Text(
        'Become an\nemployer!',
        style: TextStyle(color: Color(0xff01D45B), letterSpacing: 3),
        textAlign: TextAlign.center,
      ),
      mainImage: Image.asset(
        'assets/images/feed/newjob.png',
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor: Color(0xFF1E3C44),
      bubbleBackgroundColor: Color(0xff00CCFF),
      body: Text(
          'Fill in the 10 second form\nGet contacted by your employee in no time',
          style: TextStyle(fontSize: 20)),
      title: Text(
        'Simple job\nposting',
        style: TextStyle(color: Color(0xff01D45B), letterSpacing: 3),
        textAlign: TextAlign.center,
      ),
      mainImage: Image.asset(
        'assets/images/createjob/createJob.png',
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor: Color(0xFF1E3C44),
      bubbleBackgroundColor: Color(0xff00CCFF),
      body: Text(
          'We have got you covered!\nCheckout your profile and past jobs from the menu drawer\nContact us for any query',
          style: TextStyle(fontSize: 20)),
      title: Text(
        'All set!',
        style: TextStyle(color: Color(0xff01D45B), letterSpacing: 3),
        textAlign: TextAlign.center,
      ),
      mainImage: Image.asset(
        'assets/images/feed/drawer.png',
        alignment: Alignment.center,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroViewsFlutter(
        pages,
        showSkipButton: false,
        doneText: Text('Done'),
        onTapDoneButton: () {
          Navigator.pop(context);
        } //MaterialPageRoute

        ,
        pageButtonTextStyles: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
