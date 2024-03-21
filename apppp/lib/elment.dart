import 'package:flutter/material.dart';

class ListTilClass extends StatefulWidget {
  const ListTilClass(task, {Key? key}) : super(key: key);

  @override
  State<ListTilClass> createState() => _ListTilClass();
}

class _ListTilClass extends State<ListTilClass>{
  get task => null;

  @override
  Widget build(BuildContext context) {
  return ListTile(
    title: Text(task['title']),
    subtitle: Text(task['description'])
  );
  }
}
