import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaAtualController = TextEditingController();
  final _novaSenhaController = TextEditingController();
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _nicknameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
    }
  }

  Future<void> _atualizarPerfil() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.updateDisplayName(_nicknameController.text);
        await user.reload();
        setState(() {
          _errorMessage = 'Perfil atualizado com sucesso!';
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'Erro ao atualizar perfil: ${e.toString()}';
        });
      }
    }
  }

  Future<void> _alterarSenha() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.updatePassword(_novaSenhaController.text);
        setState(() {
          _errorMessage = 'Senha atualizada com sucesso!';
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'Erro ao alterar senha: ${e.toString()}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Color(0xFF4A148C),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Color(0xFF2E2E2E),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField(_emailController, 'Email', readOnly: true),
              _buildTextField(_nicknameController, 'Nickname'),
              _buildTextField(_senhaAtualController, 'Senha Atual', obscureText: true),
              _buildTextField(_novaSenhaController, 'Nova Senha', obscureText: true),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: _errorMessage.contains('sucesso') ? Colors.green : Colors.red),
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _atualizarPerfil,
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF4A148C)),
                child: Text('Salvar', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: _alterarSenha,
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF4A148C)),
                child: Text('Alterar Senha', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool obscureText = false, bool readOnly = false}) {
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
        readOnly: readOnly,
      ),
    );
  }
}
