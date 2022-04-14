import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:item_list_hw/list_tile_btn.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeItemListPage(),
    );
  }
}

class HomeItemListPage extends StatefulWidget {
  const HomeItemListPage({Key? key}) : super(key: key);

  @override
  _HomeItemListPageState createState() => _HomeItemListPageState();
}

class _HomeItemListPageState extends State<HomeItemListPage> {
  late List<String> itemList;
  late List<int> intList;
  void processData() {
    itemList = List<String>.generate(10, (i) => 'Item ${i + 1}');
    intList = List<int>.generate(10, (_) => 0);
  }

  final TextEditingController _indexController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? itemInput;
  int? itemIntInput;
  final _random = Random();

  @override
  void initState() {
    processData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('面試題目'),
        centerTitle: true,
      ),
      body: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _itemController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your Item!',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _indexController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        hintText: 'Enter Index!',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Where u wanna put?';
                        } else if (int.parse(value) > intList.length) {
                          return "Can only choose from 0 ~ ${intList.length}";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState!.validate()) {
                            // Process data.
                            // Index input
                            itemIntInput = int.parse(_indexController.text);
                            // Item input
                            itemInput = _itemController.text;

                            setState(() {
                              itemList.insert(itemIntInput!, itemInput!);
                              intList.insert(itemIntInput!, 0);
                              _indexController.text = '';
                              _itemController.text = '';
                            });
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
              const IndexExchange(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Color.fromARGB(
                          _random.nextInt(256),
                          _random.nextInt(256),
                          _random.nextInt(256),
                          _random.nextInt(256)),
                      //Create another state so the color won't rerender again when
                      //clicking the button.
                      child: ListTileBtn(
                          index: index, intList: intList, itemList: itemList),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IndexExchange extends StatefulWidget {
  const IndexExchange({Key? key}) : super(key: key);

  @override
  State<IndexExchange> createState() => IndexExchangeState();
}

class IndexExchangeState extends State<IndexExchange> {
  final TextEditingController _index1 = TextEditingController();
  final TextEditingController _index2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(children: [
            Flexible(
                child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _index1,
              decoration: const InputDecoration(
                hintText: 'Index 1',
                border: OutlineInputBorder(),
              ),
            )),
            Flexible(
                child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _index2,
              decoration: const InputDecoration(
                hintText: 'Index 2',
                border: OutlineInputBorder(),
              ),
            )),
          ]),
        ),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  String temp;
                  setState(() {
                    if (_index1.text.isNotEmpty && _index2.text.isNotEmpty) {
                      temp = _index1.text;
                      _index1.text = _index2.text;
                      _index2.text = temp;
                    } else {
                      debugPrint("Empty");
                    }
                  });
                },
                child: const Text('Exchange'))),
      ],
    );
  }
}
