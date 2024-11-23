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
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF4A148C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_nomeController, 'Nome'),
            _buildTextField(_modeloController, 'Modelo'),
            _buildTextField(_anoController, 'Ano'),
            _buildTextField(_placaController, 'Placa'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarVeiculo,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A148C),
              ),
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF2E2E2E),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Color(0xFF4A148C).withOpacity(0.2),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF4A148C)),
          ),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
