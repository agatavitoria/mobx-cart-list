import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_cart_list/app/models/item_model.dart';
import 'package:mobx_cart_list/app/pages/home/home_controller.dart';
import 'components/item_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  _dialog() {
    var model = ItemModel();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Adicionar Item'),
          content: TextField(
            onChanged: model.setTitle,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Novo Item',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.addItem(model);
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: controller.setFilter,
          decoration: InputDecoration(
            hintText: 'Pesquisa...',
          ),
        ),
      ),
      body: Observer(
        builder: (_) {
          if (controller.output.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: controller.output.data.map<Widget>((item) {
              return ItemWidget(
                item: item,
                removeClicked: () {
                  controller.removeItem(item);
                },
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _dialog();
        },
      ),
    );
  }
}
