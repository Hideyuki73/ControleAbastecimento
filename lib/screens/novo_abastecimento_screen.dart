import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NovoAbastecimentoScreen extends StatefulWidget {
  final String veiculoId;

  NovoAbastecimentoScreen({required this.veiculoId});

  @override
  _NovoAbastecimentoScreenState createState() => _NovoAbastecimentoScreenState();
}

class _NovoAbastecimentoScreenState extends State<NovoAbastecimentoScreen> {
  final _litrosController = TextEditingController();
  final _quilometragemController = TextEditingController();
  final _dataController = TextEditingController();

  Future<void> _registrarAbastecimento() async {
    await FirebaseFirestore.instance.collection('abastecimentos').add({
      'veiculoId': widget.veiculoId,
      'litros': double.parse(_litrosController.text),
      'quilometragem': double.parse(_quilometragemController.text),
      'data': DateTime.parse(_dataController.text),
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Abastecimento'),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF4A148C)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _litrosController,
              decoration: InputDecoration(labelText: 'Litros'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _quilometragemController,
              decoration: InputDecoration(labelText: 'Quilometragem'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _dataController,
              decoration: InputDecoration(labelText: 'Data'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registrarAbastecimento,
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
