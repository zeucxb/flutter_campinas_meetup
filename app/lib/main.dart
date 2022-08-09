import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  String? _imageUrl;
  final TextEditingController _textEditingController = TextEditingController();

  bool _isLoading = false;

  generateCustomImage(String text) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // final uri = Uri.http('localhost:8080', 'generate/$text');
      // final response = await http.get(uri);

      final uri = Uri.http('localhost:8080', 'generate');
      final response = await http.post(
        uri,
        body: Picture(
          text: text,
          color: const ColorRGB(200, 50, 50),
        ).toJson(),
      );

      _imageUrl = response.body;
    } catch (_) {
      _image = customImage(text);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget _showImage() {
    if (_imageUrl != null) return Image.network(_imageUrl!);
    if (_image != null) return Image.file(_image!);

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: double.infinity,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _showImage(),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: _textEditingController,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      generateCustomImage(_textEditingController.text);
                    },
                    child: const Text('Gerar imagem'),
                  ),
                ],
              ),
      ),
    );
  }
}
