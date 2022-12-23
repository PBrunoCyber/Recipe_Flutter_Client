import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/models/errors.dart';
import 'package:food_recipe/models/recipe.dart';
import 'package:food_recipe/views/home.dart';
import 'package:food_recipe/views/widgets/rating_system.dart';
import 'package:food_recipe/controllers/recipe.api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddNewRecipe extends StatefulWidget {
  const AddNewRecipe({Key key}) : super(key: key);

  @override
  createState() => _AddNewRecipeState();
}

class _AddNewRecipeState extends State<AddNewRecipe> {
  double index = 0;
  DateTime time = DateTime(2016, 8, 6, 00, 00);
  String timeConcat;
  TextEditingController name = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController description = TextEditingController();

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

  Future<dynamic> addNewRecipe() async {
    var response = await RecipeApi.addNewRecipe(Recipe(
      name: name.text,
      image: image.text,
      description: description.text,
      totalTime: timeConcat,
      rating: index,
    ));
    return response.bodyBytes;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
          middle: const Text("Adicionar Informações"),
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
                          ),
                          onPressed: (() => _showDialog(
                                CupertinoDatePicker(
                                  initialDateTime: time,
                                  mode: CupertinoDatePickerMode.time,
                                  use24hFormat: true,
                                  onDateTimeChanged: (DateTime time) {
                                    setState(() {
                                      this.time = time;
                                      timeConcat =
                                          "${time.hour} hr ${time.minute} min";
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
                  controller: name,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    hintText: "Type a name of recipe: ",
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Description of recipe:"),
                TextFormField(
                  controller: description,
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
                  controller: image,
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
                      "Adicionar Informações",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      var message = await addNewRecipe();
                      if (message.toString() != "[]") {
                        ErrorExceptions error =
                            ErrorExceptions.parseErrors(utf8.decode(message));
                        print(error.message);
                      } else {
                        if (mounted) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomePage()));
                        }
                      }
                    },
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
