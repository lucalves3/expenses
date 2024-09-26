import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final void Function(String) onPressed;
  List<Transaction> _transactions = [];

  TransactionList(this._transactions, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (context, index) {
          final tr = _transactions[index];
          return Card(
            child: Row(children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    )),
                padding: const EdgeInsets.all(10),
                child: Text("R\$ ${tr.value.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tr.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(DateFormat("d MMM y").format(tr.date),
                      style: TextStyle(
                        color: Colors.grey[600],
                      ))
                ],
              ),
              IconButton(
                  onPressed: () => onPressed(tr.id),
                  icon: const Icon(Icons.delete)),
            ]),
          );
        },
      ),
    );
  }
}
