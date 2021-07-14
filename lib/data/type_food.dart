import 'package:flutter/widgets.dart';

// enum Food {
//   dry,
//   wet,
//   yummy,
//   other,
// }

class Foods {
  String type;
  String image;
  String description;

  Foods(
      {@required this.type, @required this.image, @required this.description});
}

final List<Foods> food = <Foods>[
  Foods(type: 'dry', image: 'assets/images/001.png', description: 'Сухой корм'),
  Foods(type: 'wet', image: 'assets/images/002.png', description: 'Влажный корм'),
  Foods(type: 'yummy', image: 'assets/images/003.png', description: 'Вкусняшка'),
  Foods(type: 'other', image: 'assets/images/004.png', description: 'Уточняю'),
];
