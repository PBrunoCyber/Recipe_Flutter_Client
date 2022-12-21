import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String name;
  final String totalTime;
  final double rating;
  final String image;
  const RecipeCard(
      {Key key,
      @required this.name,
      @required this.totalTime,
      @required this.rating,
      @required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 180,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0.0, 10.0),
            blurRadius: 9,
          )
        ],
        image: DecorationImage(
          image: NetworkImage(image),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.25),
            BlendMode.multiply,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                child: Row(children: [
                  const Icon(Icons.star_outline_outlined,
                      color: Colors.amber, size: 20),
                  const SizedBox(width: 3),
                  Text(rating.toString(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                child: Row(children: [
                  const Icon(Icons.timelapse_outlined,
                      color: Colors.amber, size: 20),
                  const SizedBox(width: 3),
                  Text(
                    totalTime,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
