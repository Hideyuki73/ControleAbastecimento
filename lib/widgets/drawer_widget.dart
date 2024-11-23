import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Nome do Usuário'),
            accountEmail: Text('email@exemplo.com'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Navigator.pushNamed(context, '/home'),
          ),
          ListTile(
            leading: Icon(Icons.car_rental),
            title: Text('Meus Veículos'),
            onTap: () => Navigator.pushNamed(context, '/meus_veiculos'),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Adicionar Veículo'),
            onTap: () => Navigator.pushNamed(context, '/adicionar_veiculo'),
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Histórico de Abastecimentos'),
            onTap: () => Navigator.pushNamed(context, '/historico_abastecimentos'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () => Navigator.pushNamed(context, '/perfil'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
