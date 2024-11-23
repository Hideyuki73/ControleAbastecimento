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

  int vehicleCount = 0;
  int recentRefuels = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (user != null) {
      // Contar veículos
      QuerySnapshot vehicleSnapshot = await FirebaseFirestore.instance
          .collection('veiculos')
          .where('userId', isEqualTo: user!.uid)
          .get();
      setState(() {
        vehicleCount = vehicleSnapshot.size;
      });

      // Contar abastecimentos recentes
      QuerySnapshot refuelSnapshot = await FirebaseFirestore.instance
          .collection('abastecimentos')
          .where('userId', isEqualTo: user!.uid)
          .orderBy('data', descending: true)
          .limit(5)
          .get();
      setState(() {
        recentRefuels = refuelSnapshot.size;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo ao Controle de Abastecimento!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (user != null)
              Column(
                children: [
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Usuário logado'),
                      subtitle: Text(user!.email ?? ''),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Icon(Icons.car_rental),
                      title: Text('Total de Veículos'),
                      subtitle: Text('$vehicleCount'),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Icon(Icons.local_gas_station),
                      title: Text('Abastecimentos Recentes'),
                      subtitle: Text('$recentRefuels'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
