import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_indelatv11/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
 final Future < FirebaseApp > _initialization = Firebase.initializeApp();  
 
  @override
  Widget build(BuildContext context) {
    //inicializando flutterfire
    return FutureBuilder(
      future: _initialization,
      builder:(context, snapshot){
        //revision de errores
        if (snapshot.hasError) {
          print("Sometime went wrong");
        }
        if(snapshot.connectionState==ConnectionState.done){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}


