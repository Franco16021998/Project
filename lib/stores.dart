import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

String url = "https://www.cheapshark.com/api/1.0/stores";

Future<dynamic> _getListado() async {
  final respuesta = await http.get(Uri.parse(url));

  if (respuesta.statusCode == 200) {
    return jsonDecode(respuesta.body);
  } else {
    print("Error con la respusta");
  }
}

List<Widget> listado(List<dynamic> info) {
  List<Widget> lista = [];
  info.forEach((elemento) {
    lista.add(miCard(elemento["storeName"], elemento["storeID"],
        elemento["images"]["logo"]));
  });
  return lista;
}

Card miCard(String Title, String Subtitle, String Icono) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: EdgeInsets.all(15),
    elevation: 10,
    child: Column(
      children: <Widget>[
        // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
          title: Text(Title),
          subtitle: Text(Subtitle),
          leading: Image.network("https://www.cheapshark.com" + Icono),
        ),

        // Usamos una fila para ordenar los botones del card
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(onPressed: () => {}, child: Text('Aceptar')),
            FlatButton(onPressed: () => {}, child: Text('Cancelar'))
          ],
        )
      ],
    ),
  );
}

class Stores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Listado de plataformas"),
        ),
        body: FutureBuilder<dynamic>(
          future: _getListado(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot);
              return ListView(children: listado(snapshot.data));
            } else {
              print("No hay información");
              return Text("Sin data");
            }
          },
          initialData: Center(child: CircularProgressIndicator()),
        ));
  }
}
