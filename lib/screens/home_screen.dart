import 'package:flutter/material.dart';

import '../models/tarefas.dart';

class ListaItens extends StatefulWidget {
  @override
  _ListaItensState createState() => _ListaItensState();
}

class _ListaItensState extends State<ListaItens> {
  List<Tarefa> itens = [];
  
  int proximoId = 1;

  // Método para adicionar um item
  void adicionarItem(String nome, DateTime data) {
    setState(() {
      itens.add(Tarefa(id: proximoId, nome: nome, data: data));
      proximoId++;
    });
  }

  // Método para editar um item
  void editarItem(int id, String novoNome, DateTime novaData) {
    setState(() {
      final index = itens.indexWhere((item) => item.id == id);
      if (index != -1) {
        itens[index] = Tarefa(id: id, nome: novoNome, data: novaData);
      }
    });
  }

  // Método para deletar um item
  void deletarItem(int id) {
    setState(() {
      itens.removeWhere((Tarefa) => Tarefa.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de tarefas'),
      backgroundColor: Colors.blue,),
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (context, index) {
          final item = itens[index];
          return ListTile(
            title: Text(item.nome),
            subtitle: Text(item.data.toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.orange,
                  onPressed: () {
                    // Chame o método editarItem aqui
                    editarItem(item.id, 'Tarefa Editada', DateTime.now());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    deletarItem(item.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Chame o método adicionarItem aqui
          adicionarItem('Nova Tarefa', DateTime.now());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}