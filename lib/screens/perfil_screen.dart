import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final _auth = FirebaseAuth.instance;
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      _emailController.text = user.email ?? '';
    }
  }

  Future<void> _updateUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      if (_nicknameController.text.isNotEmpty) {
        // Atualizar nickname no Firestore
      }
      if (_emailController.text.isNotEmpty) {
        await user.updateEmail(_emailController.text);
      }
      if (_senhaController.text.isNotEmpty) {
        await user.updatePassword(_senhaController.text);
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Perfil atualizado com sucesso')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF4A148C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_nicknameController, 'Nickname'),
            _buildTextField(_emailController, 'Email'),
            _buildTextField(_senhaController, 'Senha', obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUserProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A148C),
              ),
              child: Text('Atualizar Perfil'),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF2E2E2E),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool obscureText = false}) {
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
        obscureText: obscureText,
      ),
    );
  }
}
