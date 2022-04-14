import 'package:flutter/material.dart';

class ListTileBtn extends StatefulWidget {
  final int? index;
  final List<int>? intList;
  final List<String>? itemList;

  const ListTileBtn({Key? key, this.index, this.intList, this.itemList})
      : super(key: key);
  @override
  _ListTileBtnState createState() => _ListTileBtnState();
}

class _ListTileBtnState extends State<ListTileBtn> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(widget.itemList![widget.index!]),
      Expanded(
          child: ListTile(
        title: Text(widget.intList![widget.index!].toString()),
        trailing: ElevatedButton(
          onPressed: () {
            setState(() {
              widget.intList![widget.index!] += 1;
            });
          },
          child: const Text('Button'),
        ),
        onTap: () {},
      ))
    ]);
  }
}
