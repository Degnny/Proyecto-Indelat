import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_indelatv11/pages/update_page.dart';

class ListProyectPage extends StatefulWidget {
  ListProyectPage({Key? key}) : super(key: key);

  @override
  _ListProyectPageState createState() => _ListProyectPageState();
}

class _ListProyectPageState extends State<ListProyectPage> {
  final Stream<QuerySnapshot> proyectStream = FirebaseFirestore.instance.collection('Proyect').snapshots();
  
  
  //for deleting user
  CollectionReference proyect = FirebaseFirestore.instance.collection('Proyect');

  Future<void> deleteProduct(id){
   // print("User Delete $id");
   return proyect
   .doc(id)
   .delete()
   .then((value) => print('Producto Delete'))
   .catchError((error)=>print('Faile to Delete user:$error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream: proyectStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      if (snapshot.hasError) {
          print ('Something went wrong');
        }
      if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),
          );
        }

        final List storedocs = [];
        snapshot.data!.docs.map((DocumentSnapshot document){
          Map a = document.data()as Map<String, dynamic>;
          storedocs.add(a);
          a['id'] = document.id;
          
        }).toList();

      return Container(

      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          1:FixedColumnWidth(140),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [

              TableCell(
                child: Container(
                  color:  Colors.black,
                  child: Center(
                    child: Text(
                      'Operacion',
                      style: TextStyle(
                        color: Colors.yellow.shade400,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                 ),
               ),
             ),
             
             TableCell(
                child: Container(
                  color:  Colors.black,
                  child: Center(
                    child: Text(
                      'Cliente',
                      style: TextStyle(
                        color: Colors.yellow.shade400,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                 ),
               ),
             ),

             TableCell(
                child: Container(
                  color:  Colors.black,
                  child: Center(
                    child: Text(
                      'Acción',
                      style: TextStyle(
                        color: Colors.yellow.shade400,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                 ),
               ),
             )
            ],
          ),

          for (var i = 0; i < storedocs.length; i++)...[
          TableRow(
            children: [
              TableCell(
                child: Center(
                  child: Text(storedocs[i]['operacion'], style: TextStyle(fontSize: 18.0))
                ),
              ),
              TableCell(
                child: Center(
                  child: Text(storedocs[i]['cliente'], style: TextStyle(fontSize: 18.0))
                ),
              ),
              //TableCell(
                //child: Center(
                 // child: Text(storedocs[i]['descripcion'], style: TextStyle(fontSize: 18.0))
                //),
              //),
              TableCell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed:()=>{
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context)=>
                            UpdateProductPage(id:storedocs[i]['id']),
                          ),
                        )
                      } ,
                      icon: Icon(
                        Icons.edit,
                        color: Colors.orange,
                      ),
                    ),
                    IconButton(
                      onPressed:()=> {deleteProduct(storedocs[i]['id'])},
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ), 
                    )
                  ],
                ),
              )
            ]
          )
          ]
        ],
      ),
    );

      }
    );
  }
}