import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pasta/src/models/image_model.dart'; //apelido para o import
import 'package:pasta/src/widgets/image_list.dart';

class AppState extends State<App> {
  @override
  int numeroImagens = 1;
  List<ImageModel> imagens = [];
  void obterImagem() async {
    //uniform resource identifier
    var url = Uri.https('api.pexels.com', '/v1/search',
        {'query': 'people', 'page': '$numeroImagens', 'per_page': '1'});
    var req = http.Request('get', url);
    req.headers.addAll({
      'Autorization': 'kXtVuUuAkz0xlMVWJMSBXFJcFPv7VsE2lOzePsPy3E5roKJdHPVLOvRV'
    });
    req.send().then((result) async {
      final result = await req.send();
      if (result.statusCode == 200) {
        final response = await http.Response.fromStream(result);
        //transformar JSON em mapa
        var decodedJson = json.decode(response.body);
        var imagem = ImageModel.fromJSON(decodedJson);
        setState(() {
          numeroImagens++;
          imagens.add(imagem);
        });
      } else {
        print("Falhou");
      }
    });
  }

  Widget build(BuildContext) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Minhas imagens'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: obterImagem,
          child: const Icon(Icons.add),
        ),
        body: ImageList(imagens),
      ),
    );
  }
}

class App extends StatefulWidget {
  @override
  State<App> createState() {
    return AppState();
  }
}
