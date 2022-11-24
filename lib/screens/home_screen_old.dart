// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_const_constructors, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:delfcoff/screens/signin_screen.dart';
import 'package:delfcoff/utils/color_utils.dart';
import 'package:delfcoff/screens/cardapio_screen.dart';
import 'package:delfcoff/screens/form_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 10, 0),
        elevation: 0,
        title: const Text("Menu",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("200b00"),
            hexStringToColor("9f5229"),
            hexStringToColor("c57b45")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: StadiumBorder(),
                    textStyle: TextStyle(fontSize: 20)
                  ),
                  onPressed: () { 
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CardapioScreen()));
                  },
                  child: Text('Produtos')
                ),

                const SizedBox(height: 25),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: StadiumBorder(),
                    textStyle: TextStyle(fontSize: 20)
                  ),
                  onPressed: () => _favoriteDialog(context),
                  child: Text('Favoritos')
                ),

                const SizedBox(height: 25),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: StadiumBorder(),
                    textStyle: TextStyle(fontSize: 20)
                  ),
                  onPressed: () => _openMapa(-21.187192,-47.8333054),
                  child: Text('Localização')
                ),

                const SizedBox(height: 25),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: StadiumBorder(),
                    textStyle: TextStyle(fontSize: 20)
                  ),
                  onPressed: () { 
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormScreen()));
                  },
                  child: Text('Fale Conosco')
                ),

                const SizedBox(height: 25),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: StadiumBorder(),
                    textStyle: TextStyle(fontSize: 20)
                  ),
                  onPressed: () => _sobreDialog(context),
                  child: Text('Sobre')
                ),

                const SizedBox(height: 25),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 105, 2, 2),
                    shape: StadiumBorder(),
                    textStyle: TextStyle(fontSize: 20)
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    });
                  },
                  child: Text('Sair')
                ),
                
              ],
            ),
          ))),
    );
  }

  Future<void> _openMapa(double latitude, double longitude) async {
    final Uri mapa = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    if (!await launchUrl(mapa)) {
    throw 'Localização indisponível';
    }
  }

  Future<void> _sobreDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sobre'),
          content: const Text('Aplicativo Delf Coffee por Gustavo Lisi e Caio Lizardo, com o objetivo de divulgação e captação de clientes para venda de produtos da marca.'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _favoriteDialog(BuildContext context) {
    String favoritos = TelaDetalhes.favoritado;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Favoritos'),
          content: Text(favoritos),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
