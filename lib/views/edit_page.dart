import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/models/recipe.dart';
import 'package:food_recipe/views/widgets/rating_system.dart';

class EditPage extends StatefulWidget {
  final Recipe recipe;
  const EditPage({@required this.recipe, Key key}) : super(key: key);

  @override
  createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  int index = 0;
  DateTime time = DateTime(2016, 8, 6, 00, 00);

  void _showDialog(Widget child) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 280,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
          middle: const Text("Editar Informações"),
          leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new, size: 30),
          )),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Avaliação:"),
                        RatingWidget((index) {
                          setState(() {
                            this.index = index;
                          });
                        }),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Time to cook:"),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.black),
                              backgroundColor: Colors.amber),
                          onPressed: (() => _showDialog(
                                CupertinoDatePicker(
                                  initialDateTime: time,
                                  mode: CupertinoDatePickerMode.time,
                                  use24hFormat: true,
                                  onDateTimeChanged: (DateTime time) {
                                    setState(() {
                                      this.time = time;
                                    });
                                  },
                                ),
                              )),
                          child: Text(
                            '${time.hour} hr ${time.minute} min',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text("Name of recipe:"),
                TextFormField(
                  controller: TextEditingController(text: widget.recipe.name),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    hintText: "Type a name of recipe: ",
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Description of recipe:"),
                TextFormField(
                  controller:
                      TextEditingController(text: widget.recipe.description),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    hintText: "Type a description of recipe: ",
                  ),
                  maxLines: 10,
                ),
                const SizedBox(height: 20),
                const Text("Image of recipe:"),
                TextFormField(
                  controller: TextEditingController(text: widget.recipe.image),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    hintText: "Type a image of recipe: ",
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 40),
                        side: const BorderSide(color: Colors.black),
                        backgroundColor: Colors.amber),
                    child: const Text(
                      "Editar Informações",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
