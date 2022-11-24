// ignore_for_file: prefer_const_declarations, library_private_types_in_public_api, prefer_const_constructors, unused_local_variable, avoid_print

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:delfcoff/utils/color_utils.dart';
import 'package:delfcoff/utils/widget_utils.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 10, 0),
        elevation: 0,
        title: const Text(
          "Contato",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
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
              children:[
                reusableTextField("Nome Completo", Icons.person_outline, false, controllerName),
                const SizedBox(height: 20),
                reusableTextField("Email", Icons.email_outlined, false, controllerEmail),
                const SizedBox(height: 20),
                reusableTextField("Assunto", Icons.subject_outlined, false, controllerSubject),
                const SizedBox(height: 20),
                reusableTextField("Mensagem", Icons.message_outlined, false, controllerMessage, maxLines: 5),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: StadiumBorder(),
                    textStyle: TextStyle(fontSize: 20)
                  ),
                  onPressed: () => sendEmail(
                    name: controllerName.text, 
                    email: controllerEmail.text, 
                    subject: controllerSubject.text, 
                    message: controllerMessage.text,
                    context: context
                    ), 
                  child: Text('Enviar'))
              ],
            ),
          ))),
    );
  }
}

Future sendEmail ({
  required String name,
  required String email,
  required String subject,
  required String message,
  required BuildContext context
}) async {

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode ({
      'service_id': 'service_ualmsgw',
      'template_id': 'template_quc240f',
      'user_id': 'LaANLjEgM6zlopfxE',
      'template_params': {
        'from_name': name,
        'reply_to': email,
        'subject': subject,
        'message': message,
      },
    }),
  );

  if (response.body == 'OK') {
    showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: Text("Sucesso!"),
      content: Text("Agradecemos o contato e retornaremos em breve."),
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
    });
  } else {
    showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: Text("Erro!"),
      content: Text("Por favor verifique se as informações foram preenchidas corretamente."),
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
    });
  }

}
