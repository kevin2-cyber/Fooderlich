import 'package:flutter/material.dart';
import 'package:recipe_app/view/FooderlichTheme.dart';
import 'package:recipe_app/view/components/circle_immage.dart';

class AuthorCard extends StatefulWidget {
  const AuthorCard({
    Key? key,
    required this.authorName,
    required this.title,
    this.imageProvider,
  }) : super(key: key);

  final String authorName;
  final String title;
  final ImageProvider? imageProvider;

  @override
  State<AuthorCard> createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {

  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleImage(
                imageProvider: widget.imageProvider,
                imageRadius: 28,
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.authorName,
                    style: FooderlichTheme.lightTextTheme.headline1,
                  ),
                  Text(
                    widget.title,
                    style: FooderlichTheme.lightTextTheme.headline3,
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              _isFavorited ? Icons.favorite :
              Icons.favorite_border,
            ),
            iconSize: 30.0,
            color: Colors.red[400],
            onPressed: (){
              // snackBar = SnackBar(content: Text('Favorite Pressed'));
              //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
              setState(() {
                _isFavorited = !_isFavorited;
              });
            },
          ),
        ],
      ),
    );
  }
}
