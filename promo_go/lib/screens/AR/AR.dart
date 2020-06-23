import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AR extends StatefulWidget {
  @override
  _ARState createState() => _ARState();
}

class _ARState extends State<AR> {
  ArCoreController arCoreController;
  Uint8List imageData;

  @override
  void initState() {
    super.initState();
    loadAsset('visa.jpg');
  }

  void loadAsset(String name) async {
    rootBundle.load('assets/images/$name')
        .then((data) => setState(() => this.imageData = data.buffer.asUint8List()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Find and catch the promotion!"),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);

    _addSphere(arCoreController);
  }

  void onTapHandler(String name) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text("You found the promo!")),
    );
  }

  void _addSphere(ArCoreController controller) {
    final material = ArCoreMaterial(
        color: Color.fromARGB(120, 66, 134, 244), textureBytes: imageData);
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.3,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(1, 0, -1.5),
    );

    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}