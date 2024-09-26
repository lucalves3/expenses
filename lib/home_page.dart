import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: 't${_transactions.length + 1}',
      title: title,
      value: value,
      date: DateTime.now(),
    );
    setState(() {
      _transactions.add(newTransaction);
    });

    _closeTransactionFormModal(context);
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  // abre modal

  _openTransactionFormModal(BuildContext context) {
    // transforma o TransactionForm em um modal GENAIL
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTransaction);
        });
  }

  // fecha modal
  _closeTransactionFormModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas pessoais'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                child: const Text(
                  "Gráfico",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans"),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                TransactionList(_transactions, _removeTransaction),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
