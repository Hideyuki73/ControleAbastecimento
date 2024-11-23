import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdicionarVeiculoScreen extends StatefulWidget {
  @override
  _AdicionarVeiculoScreenState createState() => _AdicionarVeiculoScreenState();
}

class _AdicionarVeiculoScreenState extends State<AdicionarVeiculoScreen> {
  final _nomeController = TextEditingController();
  final _modeloController = TextEditingController();
  final _anoController = TextEditingController();
  final _placaController = TextEditingController();

  Future<void> _adicionarVeiculo() async {
    await FirebaseFirestore.instance.collection('veiculos').add({
      'nome': _nomeController.text,
      'modelo': _modeloController.text,
      'ano': _anoController.text,
      'placa': _placaController.text,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Veículo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _modeloController,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            TextField(
              controller: _anoController,
              decoration: InputDecoration(labelText: 'Ano'),
            ),
            TextField(
              controller: _placaController,
              decoration: InputDecoration(labelText: 'Placa'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarVeiculo,
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
