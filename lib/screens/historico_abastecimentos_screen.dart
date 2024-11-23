import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoricoAbastecimentosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Abastecimentos'),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF4A148C),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('abastecimentos').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var abastecimento = snapshot.data!.docs[index];
              return Card(
                color: Color(0xFF4A148C).withOpacity(0.2),
                child: ListTile(
                  title: Text(
                    'Data: ${abastecimento['data']}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Litros: ${abastecimento['litros']} - Quilometragem: ${abastecimento['quilometragem']}',
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
