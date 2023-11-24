import 'package:flutter/material.dart';


void main() {
  var app = MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Minhas imagens'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('teste'),
        child: const Icon(Icons.add_a_photo_outlined),
      ),
      ),
    );
  runApp(app);
}
