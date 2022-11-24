// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, invalid_use_of_protected_member, unnecessary_import, unused_import
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final Stream<QuerySnapshot> produtos = FirebaseFirestore.instance.collection('produtos').snapshots();

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
        child: StreamBuilder<QuerySnapshot>(
          stream: produtos,
          builder: (
            BuildContext context, 
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (snapshot.hasError) {
              return Text('Não foi possível careregar os produtos.');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Carregando...');
            }

            final dados = snapshot.requireData;

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: dados.size,
              itemBuilder: (context, index) {
                return Card(
                  shadowColor: Colors.black54,
                  elevation: 5,
                  child: ListTile(
                    title: Text(dados.docs[index]['produto']),
                    subtitle: Text(dados.docs[index]['descricao']),
                    trailing: Text(dados.docs[index]['valor']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                            TelaDetalhes(
                              produto: dados.docs[index][dados]
                            )
                        )
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class TelaDetalhes extends StatelessWidget {
  const TelaDetalhes({super.key, required this.produto});

  final Cardapio produto;
  static String favoritado = '';
  static bool icone = false;

  @override
  Widget build(BuildContext context) {

    final FirebaseAuth auth = FirebaseAuth.instance;
    void _toggleFavorited() {
      final User? user = auth.currentUser;
      final uid = user?.uid;

      CollectionReference favoritos = FirebaseFirestore.instance.collection('favoritos');
      
      favoritos.add({'produto': produto.nome, 'status': true, 'usuario': uid}).then((value) => print('Favoritado'));
      (context as Element).reassemble();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 10, 0),
        elevation: 0,
        title: Text(produto.nome,
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
              ProdutoWidget("assets/images/item${produto.id}.jpg"),
              const SizedBox(height: 30),
              Text(produto.texto, style: TextStyle(color: Colors.white70)),
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
