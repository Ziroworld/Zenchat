import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subTitile;
  const MyListTile({
    super.key, 
    required this.title, 
    required this.subTitile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(
            subTitile,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary
            ),
          ),
        ),
      ),
    );
  }
}
