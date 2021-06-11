import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

String url =
    "https://www.cheapshark.com/api/1.0/games?title=batman&steamAppID=35140&limit=60&exact=0";

Future<dynamic> _getListado() async {
  final respuesta = await http.get(Uri.parse(url));

  if (respuesta.statusCode == 200) {
    return jsonDecode(respuesta.body);
  } else {
    print("Error con la respusta");
  }
}

Card miCard(String Title, String Subtitle, String Icono) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    margin: EdgeInsets.all(15),
    elevation: 10,
    child: Column(
      children: <Widget>[
        // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
          title: Text(Title),
          subtitle: Text(Subtitle),
          leading: Image.network(Icono),
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

List<Widget> listado(List<dynamic> info) {
  List<Widget> lista = [];
  info.forEach((elemento) {
    lista.add(
        miCard(elemento["external"], elemento["cheapest"], elemento["thumb"]));
  });
  return lista;
}

class Games2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mejor oferta del dia"),
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
