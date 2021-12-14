import 'package:flutter/material.dart';
import 'package:marsyeats/data/dataMeal.dart';
import 'package:numberpicker/numberpicker.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:rxdart/subjects.dart';

class InputWeigth extends StatelessWidget {
  InputWeigth({Key? key}) : super(key: key);
  final BehaviorSubject<int> weigth = BehaviorSubject.seeded(8);

  @override
  Widget build(BuildContext context) {
    DataMeal data = context.read<DataMeal>();
    data.setWeigth(weigth.value);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: StreamBuilder<int>(
        stream: weigth.stream,
        builder: (context, snapshot) {
          data.setWeigth(weigth.value);
          return NumberPicker(
            axis: Axis.horizontal,
            value: weigth.value,
            itemCount: 5,
            itemWidth: 50,
            haptics: true,
            maxValue: 50,
            minValue: 0,
            onChanged: (curr) {
              weigth.add(curr);
            },
          );
        },
      ),
    );
  }
}
