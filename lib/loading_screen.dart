import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the home page

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay of 3 seconds before changing the route
    Future.delayed(const Duration(seconds: 1), () {
      // Replace 'YourNewRoute' with the route you want to navigate to after 3 seconds
      Navigator.of(context).pushReplacementNamed('/calender');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
          ],
        ),
      ),
    );
  }
}
