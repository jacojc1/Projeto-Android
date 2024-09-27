import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF1C3166),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF00A9D4),
        ),
        scaffoldBackgroundColor: const Color(0xFF40FFDC),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(), // Começa com a tela de login
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key}); // Construtor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bem-vindo ao Controle de Água!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navega para a tela de controle de água
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ControleAguaPage(),
                  ),
                );
              },
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}

class ControleAguaPage extends StatefulWidget {
  const ControleAguaPage({super.key});

  @override
  ControleAguaPageState createState() => ControleAguaPageState();
}

class ControleAguaPageState extends State<ControleAguaPage> {
  double _aguaConsumida = 1500.0;
  final double _metaAgua = 2000.0;

  final List<String> _historico = [];

  void _adicionarAgua(double quantidade) {
    setState(() {
      _aguaConsumida += quantidade;
      _historico.add('${quantidade.toStringAsFixed(0)} ml - ${DateTime.now().toLocal()}');
    });
  }

  void _navegarParaHistorico() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HistoricoPage(historico: _historico),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de Água Diária'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _navegarParaHistorico,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Controle o seu consumo de água!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Meta: ${_metaAgua.toStringAsFixed(0)} ml', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Consumido: ${_aguaConsumida.toStringAsFixed(0)} ml', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            LinearProgressIndicator(
              value: _aguaConsumida / _metaAgua,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
            ),
            const SizedBox(height: 30),
            Text(
              _aguaConsumida < _metaAgua ? 'Meta não atingida! Beba mais água!' : 'Meta atingida! Parabéns!',
              style: TextStyle(fontSize: 18, color: _aguaConsumida < _metaAgua ? Colors.red : Colors.green),
            ),
            const SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantidade em ml',
                border: const OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_drink, color: Theme.of(context).primaryColor),
              ),
              onSubmitted: (value) {
                _adicionarAgua(double.parse(value));
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _adicionarAgua(200),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Adicionar 200ml', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoricoPage extends StatelessWidget {
  final List<String> historico;

  const HistoricoPage({super.key, required this.historico}); // Recebe a lista de histórico

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Consumo'),
      ),
      body: ListView.builder(
        itemCount: historico.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(historico[index]),
          );
        },
      ),
    );
  }
}
