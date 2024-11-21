import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:panelsapp/widgets/CollectionTile.dart';
import 'package:panelsapp/widgets/image_tile.dart';

class HomePage extends StatefulWidget {
  final Function(bool) afterScrollResult;
  const HomePage({super.key, required this.afterScrollResult});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVisible = true;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener((){
      if(_scrollController.position.userScrollDirection == ScrollDirection.reverse){
          if(_isVisible){
            _isVisible= false;
            widget.afterScrollResult(_isVisible);
          }
      }
      if(_scrollController.position.userScrollDirection == ScrollDirection.forward){
        if(!_isVisible){
          _isVisible= true;
          widget.afterScrollResult(_isVisible);
        }
      }
    });
    super.initState();
  }
  // List to manage the favorite status for each tile
  final List<bool> _favorites = List.generate(200, (_) => false); // 200 items for example
  // List to manage the library status for each tile
  final List<bool> _library = List.generate(200, (_) => false); // 200 items for example

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Center(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              bottom: TabBar(
                tabs: const [
                  Tab(text: "Suggested"),
                  Tab(text: "Liked"),
                  Tab(text: "Library"),
                ],
                indicatorColor: Colors.red,
                indicatorWeight: 4,
              ),
            )
          ],
          body: TabBarView(
            children: [
              // Tab 1: Suggested
              MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                padding: const EdgeInsets.all(12),
                itemCount: _favorites.length,
                itemBuilder: (context, index) {
                  return (index % 2) == 0 ? ImageTile(
                    index: index,
                    extent:  300,
                    imageSource: 'https://picsum.photos/500/500?random=$index',
                    isFavorite: _favorites[index],
                    onFavoriteToggle: () {
                      setState(() {
                        _favorites[index] = !_favorites[index];
                      });
                    },
                    isInLibrary: _library[index],
                    onLibraryToggle: () {
                      setState(() {
                        _library[index] = !_library[index];
                      });
                    },
                  ) : Collection_tile(index: index, extend: 150);
                },
              ),
              // Tab 2: Liked
              MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                padding: const EdgeInsets.all(12),
                itemCount: _favorites.where((favorite) => favorite).length,
                itemBuilder: (context, index) {
                  final likedIndices = _favorites.asMap().entries
                      .where((entry) => entry.value)
                      .map((entry) => entry.key)
                      .toList();
                  final likedIndex = likedIndices[index];

                  return ImageTile(
                    index: likedIndex,
                    extent: (likedIndex % 2) == 0 ? 300 : 150,
                    imageSource: 'https://picsum.photos/500/500?random=$likedIndex',
                    isFavorite: true,
                    onFavoriteToggle: () {
                      setState(() {
                        _favorites[likedIndex] = false;
                      });
                    },
                    isInLibrary: _library[likedIndex],
                    onLibraryToggle: () {
                      setState(() {
                        _library[likedIndex] = !_library[likedIndex];
                      });
                    },
                  );
                },
              ),
              // Tab 3: Library
              MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                padding: const EdgeInsets.all(12),
                itemCount: _library.where((lib) => lib).length,
                itemBuilder: (context, index) {
                  final libraryIndices = _library.asMap().entries
                      .where((entry) => entry.value)
                      .map((entry) => entry.key)
                      .toList();
                  final libraryIndex = libraryIndices[index];

                  return ImageTile(
                    index: libraryIndex,
                    extent: (libraryIndex % 2) == 0 ? 300 : 150,
                    imageSource: 'https://picsum.photos/500/500?random=$libraryIndex',
                    isFavorite: _favorites[libraryIndex],
                    onFavoriteToggle: () {
                      setState(() {
                        _favorites[libraryIndex] = !_favorites[libraryIndex];
                      });
                    },
                    isInLibrary: true,
                    onLibraryToggle: () {
                      setState(() {
                        _library[libraryIndex] = false;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
