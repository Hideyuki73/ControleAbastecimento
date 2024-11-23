import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> _registrarAbastecimento() async {
    DateTime now = DateTime.now();
    String userId = FirebaseAuth.instance.currentUser!.uid;  // Obtendo o userId do usuário logado

    await FirebaseFirestore.instance.collection('abastecimentos').add({
      'userId': userId,  // Ligando o abastecimento ao usuário logado
      'veiculoId': widget.veiculoId,
      'litros': double.parse(_litrosController.text),
      'quilometragem': double.parse(_quilometragemController.text),
      'data': now,  // Usando a data e hora atuais
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Abastecimento'),
        backgroundColor: Color(0xFF4A148C),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Color(0xFF2E2E2E),  // Definindo o background cinza escuro
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField(_litrosController, 'Litros'),
              _buildTextField(_quilometragemController, 'Quilometragem'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registrarAbastecimento,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A148C),
                ),
                child: Text('Registrar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
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
