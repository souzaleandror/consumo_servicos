import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado = "";
  TextEditingController _controller = TextEditingController();

  _recuperarCep() async {
    http.Response response;
    String cep = _controller.text;

    String url = "https://viacep.com.br/ws/" + cep + "/json/";

    response = await http.get(url);
    print("status code" + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("resposta" + response.body);
      //convert.json(response.body);
      Map<String, dynamic> retorno = json.decode(response.body);
      String logradouro = retorno["logradouro"];
      String complemente = retorno["complemente"];
      String bairro = retorno["bairro"];
      String localidade = retorno["localidade"];

      print(retorno);
      print("${logradouro} - ${complemente} - ${bairro} - ${localidade}");
      setState(() {
        _resultado =
            "${logradouro} - ${complemente} - ${bairro} - ${localidade}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de cep"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.number,
            controller: _controller,
            decoration: InputDecoration(
              labelText: "Digite um cep",
            ),
            style: TextStyle(fontSize: 25),
          ),
          RaisedButton(
            onPressed: _recuperarCep,
            child: Text("Clique aqui"),
          ),
          Text(
            _resultado,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
