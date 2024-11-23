import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Inicializando Firebase...");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Firebase inicializado com sucesso.");
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Abastecimento',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/meus_veiculos': (context) => MeusVeiculosScreen(),
        '/adicionar_veiculo': (context) => AdicionarVeiculoScreen(),
        '/historico_abastecimentos': (context) => HistoricoAbastecimentosScreen(),
        '/perfil': (context) => PerfilScreen(),
      },
    );
  }
}

