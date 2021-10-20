
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateProductPage extends StatefulWidget {
    final String id;

  UpdateProductPage({Key? key,required this.id}) : super(key: key);

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
 final _formKey = GlobalKey<FormState>();

  CollectionReference proyect = FirebaseFirestore.instance.collection('Proyect');


  Future<void> updateProduct(id,operacion,cliente,descripcion){
    return proyect
    .doc(id)
    .update({'operacion':operacion,'cliente':cliente,'descripcion':descripcion})
    .then((value) => print('Product Update'))
   .catchError((error)=>print('Failed to update product:$error'));
  }
  @override
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
      //getting especify data by id

        child:FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(future: FirebaseFirestore.instance.collection('Proyect')
        .doc(widget.id)
        .get(),
        builder: (_,snapshot){
          if(snapshot.hasError){
            print('Something went wrong');
          }
          if(snapshot.connectionState == ConnectionState.waiting)
          {
            return Center(child:CircularProgressIndicator(),);
          }
          var data = snapshot.data!.data();
          var operacion = data!['operacion'];
          var cliente = data['cliente'];
          var descripcion= data['descripcion'];

          return Padding(
          padding: EdgeInsets.symmetric(vertical: 30,horizontal: 30),
          child:ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                initialValue: operacion,
                autofocus: false,
                onChanged: (value)=>operacion=value,
                decoration: InputDecoration(
                  labelText:'Operacion',
                  labelStyle:TextStyle(fontSize: 20.0),
                  border: OutlineInputBorder(),
                  errorStyle: 
                  TextStyle(color:Colors.redAccent,
                  fontSize: 15
                  ),
                ),
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
                  initialValue: cliente,
                  autofocus: false,
                  onChanged: (value)=>cliente=value,
                  decoration:InputDecoration(
                    labelText:'Cliente',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: 
                      TextStyle(color: Colors.redAccent,
                      fontSize:15),
                  ),
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
                  initialValue: descripcion,
                  autofocus: false,
                  onChanged: (value)=>descripcion=value,
                  //obscureText: true,
                  decoration:InputDecoration(
                    labelText:'Descripcion',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: 
                      TextStyle(color: Colors.redAccent,
                      fontSize:15),
                  ),
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
                          updateProduct(widget.id, operacion, cliente, descripcion);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed:()=>{},
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
        )
        );


          
        }
        )
        
        
      ),

    );
  }
}