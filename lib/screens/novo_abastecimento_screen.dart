import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NovoAbastecimentoScreen extends StatefulWidget {
  final String veiculoId;
  final String? abastecimentoId;
  final Map<String, dynamic>? existingData;

  NovoAbastecimentoScreen({
    required this.veiculoId,
    this.abastecimentoId,
    this.existingData,
  });

  @override
  _NovoAbastecimentoScreenState createState() => _NovoAbastecimentoScreenState();
}

class _NovoAbastecimentoScreenState extends State<NovoAbastecimentoScreen> {
  final _litrosController = TextEditingController();
  final _quilometragemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingData != null) {
      _litrosController.text = widget.existingData!['litros'].toString();
      _quilometragemController.text = widget.existingData!['quilometragem'].toString();
    }
  }

  Future<void> _registrarAbastecimento() async {
    DateTime now = DateTime.now();
    String userId = FirebaseAuth.instance.currentUser!.uid;

    var abastecimentoData = {
      'userId': userId,
      'veiculoId': widget.veiculoId,
      'litros': double.parse(_litrosController.text),
      'quilometragem': double.parse(_quilometragemController.text),
      'data': now,
    };

    if (widget.abastecimentoId == null) {
      await FirebaseFirestore.instance.collection('abastecimentos').add(abastecimentoData);
    } else {
      await FirebaseFirestore.instance.collection('abastecimentos').doc(widget.abastecimentoId).update(abastecimentoData);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.abastecimentoId == null ? 'Novo Abastecimento' : 'Editar Abastecimento'),
        backgroundColor: Color(0xFF4A148C),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Color(0xFF2E2E2E),
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
                child: Text(widget.abastecimentoId == null ? 'Registrar' : 'Salvar', style: TextStyle(color: Colors.white)),
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
