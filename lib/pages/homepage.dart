import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marsyeats/data/oneMeal.dart';
import 'package:marsyeats/data/dataMeal.dart';
import 'package:marsyeats/data/type_food.dart';
import 'package:marsyeats/elements/day.dart';
import 'package:marsyeats/servises/auth.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
import 'package:marsyeats/servises/operation.dart';

class Homepage extends StatefulWidget {
  final String name;
  const Homepage({Key key, this.name}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String title = 'Что дали?';
  Foods selectedType = food.where((element) => element.type == 'dry').first;
  int weigth = 10;
  TextEditingController textController = TextEditingController();

  Widget getDescription() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'По-моему, тут надо дополнить что дали',
              hintMaxLines: 2,
            ),
            textAlign: TextAlign.center,
            controller: textController,
            textInputAction: TextInputAction.done),
      ),
    );
  }

  Widget stepWetFood() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: StepperSwipe(
        initialValue: 10,
        speedTransitionLimitCount: 3,
        firstIncrementDuration: Duration(milliseconds: 250),
        secondIncrementDuration: Duration(milliseconds: 100),
        direction: Axis.horizontal,
        iconsColor: Colors.black,
        dragButtonColor: Colors.black45,
        withFastCount: true,
        maxValue: 50,
        minValue: 0,
        stepperValue: 10,
        onChanged: (curr) {
          weigth = curr;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<OneMeal> meals = context.watch<DataMeal>().getMeals;

    void _onChangeMeals() async {
      OneMeal current = OneMeal(
        food: selectedType.type,
        time: DateTime.now()
            .toString(), //DateFormat('HH:mm').format(DateTime.now()),
        description: selectedType.type == 'dry'
            ? weigth.toString()
            : textController.text,
        name: '${widget.name.toString().split(' ').first}',
      );
      await DatabaseService().addMeal(meal: current);
      textController.clear();
    }

    void selected(S2SingleState<String> s) => setState(() {
          title = s.value.toString();
          selectedType =
              food.where((element) => element.description == s.value).first;
        });

    Widget selectFood() {
      return Center(
        child: SmartSelect<String>.single(
          title: "Что дали?",
          modalType: S2ModalType.bottomSheet,
          value: 'Сухой корм',
          onChange: selected,
          choiceItems: food
              .map((e) => S2Choice(
                    value: e.description,
                    title: e.description,
                  ))
              .toList(),
          tileBuilder: (context, state) {
            return Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: Text(state.value),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).dividerColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage(
                        selectedType.image,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
                onTap: state.showModal,
              ),
            );
          },
        ),
      );
    }

    Widget _makePoints() {
      return CircleAvatar(
        backgroundColor: Colors.orange,
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.cyan,
              child: ListView(
                children: [
                  ElevatedButton(
                    onPressed: signOutGoogle,
                    child: Text('outlog'),
                  ),
                  Day(
                    meals: meals
                        .where(
                          (element) =>
                              DateFormat('MM.dd')
                                  .format(DateTime.parse(element.time)) ==
                              DateFormat('MM.dd').format(
                                DateTime.now().add(Duration(days: -1)),
                              ),
                        )
                        .toList(),
                    header: 'Вчера',
                  ),
                  Day(
                    meals: meals
                        .where(
                          (element) =>
                              DateFormat('MM.dd')
                                  .format(DateTime.parse(element.time)) ==
                              DateFormat('MM.dd').format(
                                DateTime.now(),
                              ),
                        )
                        .toList(),
                    header: 'Сегодня',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      height: 20,
                      child: Center(
                        child: _makePoints(),
                      ),
                    ),
                  ),
                  Day(
                    meals: meals
                        .where(
                          (element) => DateTime.parse(element.time)
                              .add(Duration(days: 1))
                              .isAfter(DateTime.now()),
                        )
                        .toList(),
                    header: 'За последние 24 часа',
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.cyan,
            height: 200,
            width: 500,
            child: Row(
              children: [
                Expanded(
                  child: Column(children: [
                    Container(
                      height: 100,
                      child: selectFood(),
                    ),
                    Container(
                      height: 80,
                      child: selectedType.type == 'dry'
                          ? stepWetFood()
                          : getDescription(),
                    ),
                  ]),
                ),
                GestureDetector(
                  onTap: _onChangeMeals,
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width / 4,
                    color: Colors.transparent,
                    alignment: Alignment.centerRight,
                    child: Image(
                      image: AssetImage('assets/images/put_food.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
