import 'package:flutter/material.dart';
import 'package:style_gallery/theme/app_theme.dart';
import 'package:style_gallery/widgets/widgets.dart';

class SublimationScreen extends StatelessWidget {
  const SublimationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sublimation Visual Help'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back),
              tooltip: 'return'),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home_outlined),
              tooltip: 'refresh'),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.refresh_rounded),
              tooltip: 'refresh'),
          IconButton(
              onPressed: () {},
              //onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: const Icon(Icons.search_rounded),
              tooltip: 'search'),
        ],
      ),
      drawer: const SideMenu(),
      body: const NavigationCards(),
    );
  }
}

class NavigationCards extends StatelessWidget {
  const NavigationCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        itemCount: 50,
        itemBuilder: (ctx, i) {
          return Card(
            color: Colors.white,
            child: Container(
              height: 140,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.folder,
                          size: 120,
                          color: AppTheme.primary.withOpacity(0.9),
                        ),
                      ),
                      const Text(
                        'Titulo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5,
          mainAxisExtent: 160,
        ),
      ),
    );
  }
}
