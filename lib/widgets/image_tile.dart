import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  final String imageSource;
  final int index;
  final double extent;
  final bool isFavorite;
  final bool isInLibrary;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onLibraryToggle;

  const ImageTile({
    super.key,
    required this.imageSource,
    required this.index,
    required this.extent,
    required this.isFavorite,
    required this.isInLibrary,
    required this.onFavoriteToggle,
    required this.onLibraryToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        showImageDetails(context,imageSource);
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
        height: extent,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(imageUrl: imageSource,fit: BoxFit.cover,),
            // Image.network(imageSource, fit: BoxFit.cover),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.7),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Art $index",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: onFavoriteToggle,
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: onLibraryToggle,
                          child: Icon(
                            isInLibrary ? Icons.bookmark : Icons.bookmark_border,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showImageDetails(BuildContext context, String imageSource) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder:(context) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: Column(
              children: [
                CachedNetworkImage(imageUrl: imageSource),
                Text("Image Title",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                ),
                MaterialButton(
                    onPressed: (){},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.black,
                  textColor: Colors.white,
                    child: Text(
                      "Get Wallpaper",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ),
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl: "https://picsum.phots.50/50",
                    height: 50,
                    width: 50,
                  ),

                )
              ],
            ),
          );
        },
    );
  }
}
