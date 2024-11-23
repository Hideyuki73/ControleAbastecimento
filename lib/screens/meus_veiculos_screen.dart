import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MeusVeiculosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Veículos'),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF4A148C),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('veiculos')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var veiculo = snapshot.data!.docs[index];
              return Card(
                color: Color(0xFF4A148C).withOpacity(0.2),
                child: ListTile(
                  title: Text(
                    veiculo['nome'],
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    '${veiculo['modelo']} - ${veiculo['ano']}',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              );
            },
          );
        },
      ),
      backgroundColor: Color(0xFF2E2E2E),
    );
  }
}
