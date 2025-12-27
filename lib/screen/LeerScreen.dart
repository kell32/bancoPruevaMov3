import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class LeerScreens extends StatelessWidget {
  const LeerScreens({super.key});

  Future<List> cargarDatos() async {
    final String res = await rootBundle.loadString('assets/data/depositos.json');
    return json.decode(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Depósitos")),
      body: FutureBuilder(
        future: cargarDatos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text("Error al cargar JSON"));
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          List data = snapshot.data as List;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              // Acceso a los mapas internos según tu nueva estructura
              final transferencia = data[i];
              final detalles = transferencia['detalles'];
              final destino = transferencia['destino'];

              return ListTile(
                // La imagen está dentro de 'detalles' -> 'imagen_comprobante'
                leading: Image.network(
                  detalles['imagen_comprobante'], 
                  width: 50,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.account_balance),
                ),
                title: Text(transferencia['banco']),
                subtitle: Text("Monto: \$${transferencia['monto']}"),
                onTap: () {
                  showDialog(
                    context: context, 
                    builder: (c) => AlertDialog(
                      title: const Text("Detalle de Depósito"),
                      content: Text(
                        "ID: ${transferencia['id']}\n"
                        "Destinatario: ${destino['nombre']}\n"
                        "Fecha: ${transferencia['fecha']}\n"
                        "Estado: ${detalles['estado']}"
                      ),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(c), child: const Text("OK"))
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}