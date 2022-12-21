import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  final Function(int) selectedIndex;
  const RatingWidget(this.selectedIndex, {Key key}) : super(key: key);

  @override
  createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int currentIndex = 0;

  Widget _buildStar(int index) {
    if (index < currentIndex) {
      return const Icon(Icons.star, color: Colors.amber);
    }
    return const Icon(Icons.star_border_outlined);
  }

  Widget _buildBody() {
    final stars = List<Widget>.generate(5, (index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            currentIndex = index + 1;
          });
          widget.selectedIndex(currentIndex);
        },
        child: _buildStar(index),
      );
    });
    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
