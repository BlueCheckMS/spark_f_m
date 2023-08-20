import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCB8Yd4DgXQ4uS1eC3pBh5iQiujX4dZgzQ",
            authDomain: "sparkfm-dbe6c.firebaseapp.com",
            projectId: "sparkfm-dbe6c",
            storageBucket: "sparkfm-dbe6c.appspot.com",
            messagingSenderId: "1016846557576",
            appId: "1:1016846557576:web:798c39ac6bfdaeece39a3d"));
  } else {
    await Firebase.initializeApp();
  }
}
