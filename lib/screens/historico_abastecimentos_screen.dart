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
      body: Container(
        color: Color(0xFF2E2E2E),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('abastecimentos').orderBy('data', descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();

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
                return FutureBuilder(
                  future: FirebaseFirestore.instance.collection('veiculos').doc(veiculoId).get(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> veiculoSnapshot) {
                    if (!veiculoSnapshot.hasData) return Container();
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

                    return ExpansionTile(
                      title: Text(veiculoNome, style: TextStyle(color: Colors.white)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Média de km/l: ${mediaKmPorLitro.toStringAsFixed(2)}',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        ...abastecimentosPorVeiculo[veiculoId]!.map((abastecimentoDoc) {
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
