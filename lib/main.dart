import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:appnavegacion/screen/LoginScreen.dart';
import 'package:appnavegacion/screen/RegistroScreen.dart';
import 'package:appnavegacion/screen/GuardarScreen.dart';
import 'package:appnavegacion/screen/LeerScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://qszgbfmjezgtvbydqlyv.supabase.co',
    anonKey: 'sb_publishable_ch-m2RN4S6PF5TXq6CiKfA_bWWKu6_P',
  );
  runApp(const MaterialApp(home: Welcome(), debugShowCheckedModeBanner: false));
}

class Welcome extends StatelessWidget {
  const Welcome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("BANCO APP"),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const Loginscreen())), 
              child: const Text("Login")
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const Registroscreen())), 
              child: const Text("Registro")
            ),
            const SizedBox(height: 20),
            const Text("Nombre: Kelly"),
            const Text("GitHub: Kell32"),
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indice = 0;
  final _paginas = [const Guardarscreen(), const LeerScreens()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas[_indice],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indice,
        onTap: (i) => setState(() => _indice = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.send), label: "Transferencias"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Depósitos"),
        ],
      ),
    );
  }
}