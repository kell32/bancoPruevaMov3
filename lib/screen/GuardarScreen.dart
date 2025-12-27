import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Guardarscreen extends StatelessWidget {
  const Guardarscreen({super.key});
  @override
  Widget build(BuildContext context) {
    final id = TextEditingController();
    final nombre = TextEditingController();
    final monto = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Transferencia")),
      body: Column(
        children: [
          TextField(controller: id, decoration: const InputDecoration(labelText: "ID")),
          TextField(controller: nombre, decoration: const InputDecoration(labelText: "Destinatario")),
          TextField(controller: monto, decoration: const InputDecoration(labelText: "Monto")),
          ElevatedButton(onPressed: () async {
            await Supabase.instance.client.from('transferencias').insert({
              'id_trans': id.text,
              'destinatario': nombre.text,
              'monto': double.parse(monto.text),
            });
            id.clear(); nombre.clear(); monto.clear();
          }, child: const Text("Guardar"))
        ],
      ),
    );
  }
}