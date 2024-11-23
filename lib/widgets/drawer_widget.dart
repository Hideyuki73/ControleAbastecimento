import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.displayName ?? 'Nome do Usuário', style: TextStyle(color: Colors.white)),
            accountEmail: Text(user?.email ?? 'email@exemplo.com', style: TextStyle(color: Colors.white)),
            decoration: BoxDecoration(
              color: Color(0xFF4A148C),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            iconColor: Color(0xFF4A148C),
            title: Text('Home'),
            textColor: Colors.white,
            onTap: () => Navigator.pushNamed(context, '/home'),
          ),
          ListTile(
            leading: Icon(Icons.car_rental),
            iconColor: Color(0xFF4A148C),
            title: Text('Meus Veículos'),
            textColor: Colors.white,
            onTap: () => Navigator.pushNamed(context, '/meus_veiculos'),
          ),
          ListTile(
            leading: Icon(Icons.add),
            iconColor: Color(0xFF4A148C),
            title: Text('Adicionar Veículo'),
            textColor: Colors.white,
            onTap: () => Navigator.pushNamed(context, '/adicionar_veiculo'),
          ),
          ListTile(
            leading: Icon(Icons.history),
            iconColor: Color(0xFF4A148C),
            title: Text('Histórico de Abastecimentos'),
            textColor: Colors.white,
            onTap: () => Navigator.pushNamed(context, '/historico_abastecimentos'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            iconColor: Color(0xFF4A148C),
            title: Text('Perfil'),
            textColor: Colors.white,
            onTap: () => Navigator.pushNamed(context, '/perfil'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            iconColor: Color.fromARGB(255, 209, 8, 8),
            title: Text('Logout'),
            textColor: Colors.white,
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFF2E2E2E),
    );
  }
}
