
import 'package:flutter/material.dart';
import 'package:flutter_indelatv11/widgets/navBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CreateEspecification extends StatefulWidget {
  CreateEspecification({Key? key}) : super(key: key);

  @override
  _CreateEspecificationState createState() => _CreateEspecificationState();
}

class _CreateEspecificationState extends State<CreateEspecification> {
final _formKey = GlobalKey<FormState>();

  var operacion="";
  var cliente="";
  var descripcion="";
//create text controller

//of the textfield

  final operacionController = TextEditingController();
  final clienteController = TextEditingController();
  final descripcionController = TextEditingController();

  @override
  void dispose(){
    //clean up the controller
    operacionController.dispose();
    clienteController.dispose();
    descripcionController.dispose();
  }
  clearText(){
    operacionController.clear();
    clienteController.clear();
    descripcionController.clear();
  }

//addingent student
  CollectionReference proyecto = FirebaseFirestore.instance.collection('Proyect');

  Future<void> addProyect(){
    return proyecto
    .add({'operacion':operacion,'cliente':cliente,'descripcion':descripcion})
    .then((value) => print('Producto Added'))
   .catchError((error)=>print('Faile to Add Product:$error'));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'assets/logo-indelat.png',
          width: 120,
          height: 40.0,
          ), 
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                  decoration:InputDecoration(
                    labelText:'Operacion',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: 
                      TextStyle(color: Colors.redAccent,
                      fontSize:15),
                  ),
                  controller: operacionController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please Enter Operacion';
                    }
                    return null;
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                  decoration:InputDecoration(
                    labelText:'Cliente',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: 
                      TextStyle(color: Colors.redAccent,
                      fontSize:15),
                  ),
                  controller: clienteController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please Enter Cliente';
                    }
                    return null;
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                 // obscureText: true,
                  decoration:InputDecoration(
                    labelText:'Descripcion',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: 
                      TextStyle(color: Colors.redAccent,
                      fontSize:15),
                  ),
                  controller: descripcionController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please Enter Descripcion';
                    }
                    return null;
                  },
                ),
              ),

              



              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed:(){
                        //validate return true if the forma es valida, otherwise false
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            operacion = operacionController.text;
                            cliente = clienteController.text;
                            descripcion = descripcionController.text;
                            addProyect();
                            clearText();
                          });
                        }
                      },
                      child: Text(
                        'Registrar',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),

                    ElevatedButton(
                      onPressed:()=>{clearText()},
                      child: Text(
                        'Reset',
                        style: TextStyle(fontSize: 18.0),
                      ), 
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}