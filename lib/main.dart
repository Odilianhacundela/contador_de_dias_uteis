// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, override_on_non_overriding_member

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:date_time_picker/date_time_picker.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController dataInicialController = TextEditingController();
  TextEditingController dataFinalController = TextEditingController();

  String _infoText = "Informe as datas";

  void _resetField() {
    dataInicialController.text = '';
    dataFinalController.text = '';
    setState(() {
      _infoText = 'informe as datas';
    });
  }

  void _calculate() {
    setState(() {
      DateTime inicio = new DateTime.now();
      DateTime fim = DateTime.now();
      int diasUteis = 0;

      int diasUteisCalc(DateTime inicio, DateTime fim) {
        int diasUteis = 0;
        for (var dataI = inicio;
        fim.difference(dataI).inDays >= 0;
        dataI = dataI.add(Duration(days: 1))){
          if (dataI.weekday == 6 || dataI.weekday == 7){
            continue;
          }
          diasUteis ++;
        }
        return diasUteis;
      }

      _infoText = 'São ${diasUteis.toString()} dias úteis';
    });
  }

  @override
  void initState() {
    dataInicialController.text = '';
    dataFinalController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "Contador de dias úteis",
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: (_resetField),
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            splashColor: Colors.black,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.calendar_month_outlined,
                    size: 150.0, color: Colors.orange),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orange, width: 1.0)),
                    labelText: 'Data inicial',
                    labelStyle: TextStyle(color: Colors.orange),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange, fontSize: 25.0),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));
                        
                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                      print(formattedDate);
                    
                    }
                    
                  },
                  controller: dataInicialController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira a data inicial';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orange, width: 1.0)),
                    labelText: 'Data final',
                    labelStyle: TextStyle(color: Colors.orange),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange, fontSize: 25.0),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));
                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                      print(formattedDate);
                      setState(() {
                        dataFinalController.text = formattedDate;
                      });
                    }
                  },
                  controller: dataFinalController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira a data final';
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                        'Calcular',
                        style: TextStyle(color: Colors.black, fontSize: 25.0),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.orange),
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 25.0,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
