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
  String _errorMessage = '';

  Future<void> _adicionarVeiculo() async {
    if (!_anoValido(_anoController.text)) {
      setState(() {
        _errorMessage = 'Ano inválido. Por favor, insira um ano entre 1886 e ${DateTime.now().year}.';
      });
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('veiculos').add({
        'nome': _nomeController.text,
        'modelo': _modeloController.text,
        'ano': int.parse(_anoController.text),
        'placa': _placaController.text,
        'userId': FirebaseAuth.instance.currentUser!.uid,
      });
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao adicionar veículo: ${e.toString()}';
      });
    }
  }

  bool _anoValido(String ano) {
    int? year = int.tryParse(ano);
    return year != null && year >= 1886 && year <= DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Veículo'),
        backgroundColor: Color(0xFF4A148C),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Color(0xFF2E2E2E),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField(_nomeController, 'Nome'),
              _buildTextField(_modeloController, 'Modelo'),
              _buildTextField(_anoController, 'Ano', keyboardType: TextInputType.number),
              _buildTextField(_placaController, 'Placa'),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _adicionarVeiculo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A148C),
                ),
                child: Text('Adicionar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
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
        keyboardType: keyboardType,
      ),
    );
  }
}
