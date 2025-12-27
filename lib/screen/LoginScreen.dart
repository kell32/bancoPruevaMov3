import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:appnavegacion/main.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pass = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Column(
        children: [
          TextField(controller: email, decoration: const InputDecoration(labelText: "Correo")),
          TextField(controller: pass, decoration: const InputDecoration(labelText: "Contraseña"), obscureText: true),
          ElevatedButton(onPressed: () async {
            try {
              await Supabase.instance.client.auth.signInWithPassword(email: email.text, password: pass.text);
              Navigator.push(context, MaterialPageRoute(builder: (c) => const Home()));
            } catch (e) {
              showDialog(context: context, builder: (c) => const AlertDialog(title: Text("Alert"), content: Text("Credenciales incorrectas")));
            }
          }, child: const Text("Ingresar"))
        ],
      ),
    );
  }
}