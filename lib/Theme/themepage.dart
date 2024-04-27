import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/Theme/themeprovider.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text('Theme'),
            trailing: CupertinoSwitch(
              value:
                  Provider.of<Themeprivoder>(context, listen: false).isdarkmode,
              onChanged: (value) =>
                  Provider.of<Themeprivoder>(context, listen: false)
                      .toogletheme(),
            ),
          ),
        ),
      ),
    );
  }
}
