import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color(0xFF4A148C),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Container(
        color: Color(0xFF2E2E2E),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('abastecimentos')
            .where('userId', isEqualTo: user!.uid)
            .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();

            int vehicleCount = 0;
            int recentRefuels = 0;

            // Contar veículos e abastecimentos recentes
            var veiculos = {};
            snapshot.data!.docs.forEach((doc) {
              veiculos[doc['veiculoId']] = true;
              recentRefuels++;
            });
            vehicleCount = veiculos.keys.length;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bem-vindo ao Controle de Abastecimento!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  if (user != null)
                    Column(
                      children: [
                        Card(
                          color: Color(0xFF4A148C).withOpacity(0.2),
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: Icon(Icons.person, color: Colors.white),
                            title: Text('Usuário logado', style: TextStyle(color: Colors.white)),
                            subtitle: Text(user!.email ?? '', style: TextStyle(color: Colors.white70)),
                          ),
                        ),
                        Card(
                          color: Color(0xFF4A148C).withOpacity(0.2),
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: Icon(Icons.car_rental, color: Colors.white),
                            title: Text('Total de Veículos', style: TextStyle(color: Colors.white)),
                            subtitle: Text('$vehicleCount', style: TextStyle(color: Colors.white70)),
                          ),
                        ),
                        Card(
                          color: Color(0xFF4A148C).withOpacity(0.2),
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: Icon(Icons.local_gas_station, color: Colors.white),
                            title: Text('Abastecimentos Recentes', style: TextStyle(color: Colors.white)),
                            subtitle: Text('$recentRefuels', style: TextStyle(color: Colors.white70)),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
