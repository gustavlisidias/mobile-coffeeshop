// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, invalid_use_of_protected_member
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:delfcoff/utils/color_utils.dart';
import 'package:delfcoff/model/cardapio.dart';
import 'package:delfcoff/utils/widget_utils.dart';

class CardapioScreen extends StatefulWidget {
  const CardapioScreen({Key? key}) : super(key: key);

  @override
  _CardapioScreenState createState() => _CardapioScreenState();
}

class _CardapioScreenState extends State<CardapioScreen> {
  List<Cardapio> dados = [];

  carregarDados() async {
    final String arq = await rootBundle.loadString('data/itens.json');
    final dynamic d = await json.decode(arq);
    setState(() {
      d.forEach((item) {
        dados.add(Cardapio.fromJson(item));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await carregarDados();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 10, 0),
        elevation: 0,
        title: const Text("Produtos",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("200b00"),
          hexStringToColor("9f5229"),
          hexStringToColor("c57b45")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: dados.length,
            itemBuilder: (context, index) {
              return Card(
                shadowColor: Colors.black54,
                elevation: 5,
                child: ListTile(
                  title: Text(dados[index].nome),
                  subtitle: Text(dados[index].descricao),
                  trailing: Text(dados[index].valor),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TelaDetalhes(item: dados[index])));
                  },
                ),
              );
            }),
      ),
    );
  }
}

class TelaDetalhes extends StatelessWidget {
  const TelaDetalhes({super.key, required this.item});

  final Cardapio item;
  static String favoritado = '';
  static bool icone = false;

  @override
  Widget build(BuildContext context) {

    void _toggleFavorited() {
      if (icone) {
        icone = false;
        favoritado = '';
      } else {
        icone = true;   
        favoritado = item.nome;
      }
      
      (context as Element).reassemble();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 10, 0),
        elevation: 0,
        title: Text(item.nome,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("200b00"),
          hexStringToColor("9f5229"),
          hexStringToColor("c57b45")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ProdutoWidget("assets/images/item${item.id}.jpg"),
              const SizedBox(height: 30),
              Text(item.texto, style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: _toggleFavorited,
        backgroundColor: Color.fromARGB(255, 105, 2, 2),
        child: Icon (icone ? Icons.favorite : Icons.favorite_border),
      ),
    );
  }
}
