import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class Collection_tile extends StatelessWidget {
  final int index;
  final double extend;
  const Collection_tile({super.key, required this.index, required this.extend});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: extend,
      child: Stack(
        children: [
          Positioned(

            left: 25,
              right: 25,
              bottom: 0,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.black,
                      blurRadius: 8,
                        spreadRadius: -7,
                        offset: Offset(0,10),
                      )
                    ]
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(imageUrl: "https://picsum.photos/500/500?img_1=$index"))),
          Positioned(
            left: 15,
              right: 15,
              bottom: 15,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black,
                          blurRadius: 8,
                          spreadRadius: -6,
                          offset: Offset(0,10),
                        )
                      ]
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(imageUrl: "https://picsum.photos/500/500?img_2=$index"))),
          Positioned(

              bottom: 30,
              right: 0,
              left: 0,
              top: 0,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black,
                          blurRadius: 8,
                          spreadRadius: -6,
                          offset: Offset(0,10),
                        )
                      ]
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(imageUrl: "https://picsum.photos/500/500?img_3=$index",
                  fit: BoxFit.cover,
                  )
              )
          ),
          Positioned(child: Icon(Icons.star,color: Colors.white),
            bottom: 35,
            right: 5,

          )
        ],
      ),
    );
  }
}
