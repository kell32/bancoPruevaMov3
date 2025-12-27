import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Registroscreen extends StatelessWidget {
  const Registroscreen({super.key});
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pass = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Column(
        children: [
          TextField(controller: email, decoration: const InputDecoration(labelText: "Correo")),
          TextField(controller: pass, decoration: const InputDecoration(labelText: "Contraseña"), obscureText: true),
          ElevatedButton(onPressed: () async {
            try {
              await Supabase.instance.client.auth.signUp(email: email.text, password: pass.text);
              Navigator.pop(context);
            } catch (e) {
              showDialog(context: context, builder: (c) => const AlertDialog(title: Text("Alert"), content: Text("Error al registrar")));
            }
          }, child: const Text("Registrar"))
        ],
      ),
    );
  }
}