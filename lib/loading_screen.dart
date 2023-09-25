import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> authenticate() async {
    final localAuth = LocalAuthentication();
    try {
      final isAuthenticated = await localAuth.authenticate(
        localizedReason:
            'Authenticate to access the app', // Displayed to the user
      );
      if (isAuthenticated) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          proceed();
        });
        // Biometric authentication successful
        // You can navigate to the next screen or perform other actions here
      } else {
        // Biometric authentication failed or user canceled
        // Handle this as needed
      }
    } catch (e) {
      // Handle errors
    }
  }

  void proceed() {
    Navigator.of(context).pushReplacementNamed('/calender');
  }

  Future<bool> checkBiometrics() async {
    final localAuth = LocalAuthentication();
    try {
      return await localAuth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

  Widget showBiometrics() {
    return !kReleaseMode
        ? TextButton(
            onPressed: () async {
              final hasBiometrics = await checkBiometrics();
              if (hasBiometrics) {
                await authenticate();
              } else {
                proceed();
                // Biometrics not available on this device
              }
            },
            child: const Text('Authenticate with Biometrics'),
          )
        : const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            showBiometrics(),
          ],
        ),
      ),
    );
  }
}
