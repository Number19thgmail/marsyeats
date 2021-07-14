import 'package:flutter/material.dart';

class EatingFor24Hours extends StatelessWidget {
  final int weight;
  final String title;
  EatingFor24Hours.builder({@required this.weight, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Card(
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        child: ListTile(
          tileColor: Colors.transparent,
          leading: Image(
            image: weight < 31
                ? AssetImage(
                    'assets/images/hungry.png',
                  )
                : (weight > 46
                    ? AssetImage('assets/images/fat.png')
                    : AssetImage('assets/images/norm.png')),
            fit: BoxFit.contain,
          ),
          title: Text('$title дали $weight грамм'),
          subtitle: Text(
            'Норма 45 грамм',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
