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
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return UserAccountsDrawerHeader(
                  accountName: Text('Nome do Usuário', style: TextStyle(color: Colors.white)),
                  accountEmail: Text('email@exemplo.com', style: TextStyle(color: Colors.white)),
                  decoration: BoxDecoration(
                    color: Color(0xFF4A148C),
                  ),
                );
              }
              User user = snapshot.data!;
              return UserAccountsDrawerHeader(
                accountName: Text(user.displayName ?? 'Nome do Usuário', style: TextStyle(color: Colors.white)),
                accountEmail: Text(user.email ?? 'email@exemplo.com', style: TextStyle(color: Colors.white)),
                decoration: BoxDecoration(
                  color: Color(0xFF4A148C),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.white),
            title: Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushNamed(context, '/home'),
          ),
          ListTile(
            leading: Icon(Icons.car_rental, color: Colors.white),
            title: Text('Meus Veículos', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushNamed(context, '/meus_veiculos'),
          ),
          ListTile(
            leading: Icon(Icons.add, color: Colors.white),
            title: Text('Adicionar Veículo', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushNamed(context, '/adicionar_veiculo'),
          ),
          ListTile(
            leading: Icon(Icons.history, color: Colors.white),
            title: Text('Histórico de Abastecimentos', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushNamed(context, '/historico_abastecimentos'),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.white),
            title: Text('Perfil', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushNamed(context, '/perfil'),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.white)),
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
