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
              return ListTile(
                title: Text(veiculo['nome']),
                subtitle: Text('${veiculo['modelo']} - ${veiculo['ano']}'),
              );
            },
          );
        },
      ),
    );
  }
}
