
import 'package:flutter/material.dart';
import 'package:flutter_indelatv11/pages/create_page.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:[
          UserAccountsDrawerHeader(
            accountName:Text('Erick Degnny'),
            accountEmail:Text('deggny@gmail.com'), 
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/42959490.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage(
                  'assets/img-tubo.jpg',
                  ),
                fit: BoxFit.cover
              ),
            )
          ),
        ListTile(
          leading: Icon(Icons.production_quantity_limits_sharp),
          title: Text('Producto'),
      
          onTap: ()=>{
            Navigator.push(
              context, MaterialPageRoute(builder: (context)=>CreateEspecification())),
          },
        ),

        ListTile(
          leading: Icon(Icons.bar_chart_sharp),
          title: Text('Avance de Produccion'),
          onTap: ()=>print('AvanP'),
        ),

        ListTile(
          leading: Icon(Icons.people),
          title: Text('Usuarios'),
          onTap: ()=>print('Usu'),
        ),

        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notificacion'),
          onTap: ()=>print('Conf'),
        ),

        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Salir'),
          onTap: ()=>print('Sal'),
        ),
        ]
      ),
    );
  }
}