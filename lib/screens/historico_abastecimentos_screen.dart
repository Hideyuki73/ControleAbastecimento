import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoricoAbastecimentosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Abastecimentos'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('abastecimentos').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var abastecimento = snapshot.data!.docs[index];
              return ListTile(
                title: Text('Data: ${abastecimento['data']}'),
                subtitle: Text('Litros: ${abastecimento['litros']} - Quilometragem: ${abastecimento['quilometragem']}'),
              );
            },
          );
        },
      ),
    );
  }
}
