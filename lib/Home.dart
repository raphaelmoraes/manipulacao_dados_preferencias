import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Não consegui atualizar na tela

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerCampo = TextEditingController();

    String _textSalvo = "Nada salvo";

    _salvar() async {
      String valorDigitado = _controllerCampo.text;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("nome", valorDigitado);

      setState(() {
        _textSalvo = prefs.getString("nome") ?? "Sem valor 1";
      });

      print("salvar - $valorDigitado");
    }

    _recuperar() async {
      final prefs = await SharedPreferences.getInstance();

      setState(() {
        _textSalvo = prefs.getString("nome") ?? "Sem valor 1";
      });

      print("recuperar - $_textSalvo");
    }

    _remover() async {
      final prefs = await SharedPreferences.getInstance();

      prefs.remove("nome");
      print("remover");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Manipulação de dados"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Digite Algo"),
              controller: _controllerCampo,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _salvar,
                  child: Text("Salvar"),
                ),
                ElevatedButton(
                  onPressed: _recuperar,
                  child: Text("Recuperar"),
                ),
                ElevatedButton(
                  onPressed: _remover,
                  child: Text("Remover"),
                ),
              ],
            ),
            Text(
              _textSalvo,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
