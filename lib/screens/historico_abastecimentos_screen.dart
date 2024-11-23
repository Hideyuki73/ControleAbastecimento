import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoricoAbastecimentosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Abastecimentos'),
        backgroundColor: Color(0xFF4A148C),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Color(0xFF2E2E2E),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('abastecimentos')
            .where('userId', isEqualTo: user!.uid)
            .orderBy('data', descending: true)
            .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}', style: TextStyle(color: Colors.white)));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('Nenhum abastecimento encontrado', style: TextStyle(color: Colors.white)));
            }

            // Agrupar abastecimentos por veículo
            Map<String, List<DocumentSnapshot>> abastecimentosPorVeiculo = {};
            for (var doc in snapshot.data!.docs) {
              String veiculoId = doc['veiculoId'];
              if (!abastecimentosPorVeiculo.containsKey(veiculoId)) {
                abastecimentosPorVeiculo[veiculoId] = [];
              }
              abastecimentosPorVeiculo[veiculoId]!.add(doc);
            }

            return ListView(
              children: abastecimentosPorVeiculo.keys.map((veiculoId) {
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('veiculos').doc(veiculoId).get(),
                  builder: (context, veiculoSnapshot) {
                    if (!veiculoSnapshot.hasData) return Container();
                    if (veiculoSnapshot.hasError) {
                      print('Erro ao carregar veículo: ${veiculoSnapshot.error}');
                      return Container();
                    }
                    var veiculoData = veiculoSnapshot.data!.data() as Map<String, dynamic>;
                    String veiculoNome = veiculoData['nome'];

                    // Calcular média de km/l
                    double totalKm = 0;
                    double totalLitros = 0;
                    for (var doc in abastecimentosPorVeiculo[veiculoId]!) {
                      var data = doc.data() as Map<String, dynamic>;
                      totalKm += data['quilometragem'];
                      totalLitros += data['litros'];
                    }
                    double mediaKmPorLitro = totalKm / totalLitros;

                    return Column(
                      children: [
                        Container(
                          color: Color(0xFF4A148C).withOpacity(0.5),
                          child: ExpansionTile(
                            title: Text(veiculoNome, style: TextStyle(color: Colors.white)),
                            children: abastecimentosPorVeiculo[veiculoId]!.map((abastecimentoDoc) {
                              var abastecimentoData = abastecimentoDoc.data() as Map<String, dynamic>;
                              return Card(
                                color: Color(0xFF4A148C).withOpacity(0.2),
                                child: ListTile(
                                  title: Text(
                                    'Data: ${abastecimentoData['data'].toDate()}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Litros: ${abastecimentoData['litros']} - Quilometragem: ${abastecimentoData['quilometragem']}',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.symmetric(vertical: 2.0),
                          color: Color(0xFF4A148C).withOpacity(0.4),
                          child: Text(
                            'Média de km/l: ${mediaKmPorLitro.toStringAsFixed(2)}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
