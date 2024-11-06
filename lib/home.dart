import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  Home({super.key});
  
  final double _sheetPosition = 0.5;
  final DraggableScrollableController shitController = DraggableScrollableController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: const Drawer(
          child: SafeArea(child: Text(" je suis un drawer"))),
      appBar: AppBar(
        title: Title(color: Colors.blue, child: const Text("AAAA")),
        backgroundColor: Colors.amber,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                developer.log("hallo");
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Stack(
        children:[ 
        const Image(image: AssetImage("assets/Brigitte.jpg")),
        Center(
          child: Draggable(
            dragAnchorStrategy: (draggable, context, position) {
              return position;
            },
            onDragEnd: (details) {
              if (details.offset.dx.abs() >
                    details.offset.dy.abs() &&
                  details.offset.dx > 0) {
                developer.log("droite");
              } else if (details.offset.dx.abs() >
                    details.offset.dy.abs() &&
                  details.offset.dx < 0) {
                developer.log("gauche");
              } else if (details.offset.dy.abs() >
                    details.offset.dx.abs() &&
                  details.offset.dy > 0) {
                if(shitController.size == 0){
                  Navigator.pushNamed(context, '/profile');
                }
                shitController.jumpTo(0);
              } else if (details.offset.dy.abs() >
                    details.offset.dx.abs() &&
                  details.offset.dy < 0) {
                shitController.jumpTo(0.5);
              } else if (details.offset.dy.abs() < 5 &&
                  details.offset.dx.abs() <5) {
                     developer.log("profile");
                shitController.jumpTo(0);
              }
            },
            feedback: Container(
              height: 800.0,
              width: 400.0,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(0)),
            ),
            child: Container(
              height: 800.0,
              width: 400.0,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(0)),
            ),
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: _sheetPosition,
          minChildSize: 0,
          maxChildSize: 1,
          controller: shitController,
          snap: true,
          snapSizes: const [0, 0.5, 1.0],
          builder: (BuildContext context, ScrollController scrollController){
            return Container(
              color: Colors.blue[100],
              child: ListView.builder(
                controller: scrollController,
                itemCount: 25,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
              )
            );
          }
        ),
        ]
      )
    );
  }
}