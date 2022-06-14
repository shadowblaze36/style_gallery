import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style_gallery/providers/sublimation_provider.dart';
import 'package:style_gallery/theme/app_theme.dart';
import 'package:style_gallery/widgets/widgets.dart';

import '../models/models.dart';

class SublimationScreen extends StatelessWidget {
  const SublimationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sublimationProvider = Provider.of<SublimationProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back),
        onPressed: () {
          sublimationProvider.generatePreviousRoute();
        },
      ),
      appBar: AppBar(
        title: const Text('Sublimation Visual Help'),
        actions: [
          IconButton(
              onPressed: () {
                sublimationProvider.generatePreviousRoute();
              },
              icon: const Icon(Icons.arrow_back),
              tooltip: 'return'),
          IconButton(
              onPressed: () {
                sublimationProvider.path = 'home';
              },
              icon: const Icon(Icons.home_outlined),
              tooltip: 'home'),
          IconButton(
              onPressed: () {
                sublimationProvider.refresh();
              },
              icon: const Icon(Icons.refresh_rounded),
              tooltip: 'refresh'),
          // IconButton(
          //     onPressed: () {},
          //     //onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
          //     icon: const Icon(Icons.search_rounded),
          //     tooltip: 'search'),
        ],
      ),
      drawer: const SideMenu(),
      body: NavigationCards(sublimationProvider: sublimationProvider),
    );
  }
}

class NavigationCards extends StatefulWidget {
  const NavigationCards({
    Key? key,
    required this.sublimationProvider,
  }) : super(key: key);

  final SublimationProvider sublimationProvider;

  @override
  State<NavigationCards> createState() => _NavigationCardsState();
}

class _NavigationCardsState extends State<NavigationCards> {
  @override
  Widget build(BuildContext context) {
    SublimationProvider provider = widget.sublimationProvider;
    List<Content> content =
        provider.pathContents[widget.sublimationProvider.path]?.content ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        provider.path == 'home' ? const Icon(Icons.home) : Text(provider.path),
        widget.sublimationProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : content.isEmpty
                ? const Center(child: Text('Empty'))
                : Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      itemCount: content.length,
                      itemBuilder: (_, i) {
                        return Card(
                          color: Colors.white10,
                          elevation: 0,
                          child: GestureDetector(
                            onTap: () {
                              print(content[i].type);
                              if (content[i].type == 'dir') {
                                provider.generateNextRoute(content[i].name);
                              }
                              //  else if (content[i].type == '.png') {
                              //   displayDialog(context,
                              //       provider.getfullImagePath(content[i].name));
                              // }
                            },
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      content[i].type == 'dir'
                                          ? Expanded(
                                              child: Icon(Icons.folder,
                                                  size: 100,
                                                  color:
                                                      Colors.yellowAccent[700]))
                                          : (content[i].type == '.png' ||
                                                  content[i].type == '.jpg')
                                              // ? CachedNetworkImage(
                                              //     memCacheHeight: 100,
                                              //     memCacheWidth: 100,
                                              //     imageUrl:
                                              //         provider.getfullImagePath(
                                              //             content[i].name),
                                              //     placeholder: (context, url) =>
                                              //         const Center(
                                              //             child:
                                              //                 CircularProgressIndicator()),
                                              //   )
                                              ? ImageFullScreenWrapperWidget(
                                                  dark: false,
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    placeholderErrorBuilder:
                                                        (context, error,
                                                            stackTrace) {
                                                      return InkWell(
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    32.0),
                                                            child: Text(
                                                                "ERROR OCCURRED, Tap to retry !"),
                                                          ),
                                                          onTap: () =>
                                                              setState(() {}));
                                                    },
                                                    placeholder:
                                                        'assets/loadingRed.gif',
                                                    image: provider
                                                        .getfullImagePath(
                                                            content[i].name,
                                                            content[i].type),
                                                    height: 90,
                                                    width: 80,
                                                    imageCacheHeight:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height
                                                                .toInt() *
                                                            2,
                                                    imageCacheWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width
                                                                .toInt() *
                                                            2,
                                                  ),
                                                )

                                              // Image.network(
                                              //     provider.getfullImagePath(
                                              //         content[i].name,
                                              //         content[i].type),
                                              //     cacheHeight: 90,
                                              //     cacheWidth: 80,
                                              //     height: 90,
                                              //     width: 80,
                                              //   )

                                              // Image(
                                              //     height: 90,
                                              //     width: 80,
                                              //     image:
                                              //         ExtendedNetworkImageProvider(
                                              //             provider
                                              //                 .getfullImagePath(
                                              //                     content[i]
                                              //                         .name),
                                              //             cache: true,
                                              //             retries: 3,
                                              //             timeRetry:
                                              //                 const Duration(
                                              //                     milliseconds:
                                              //                         100),
                                              //             printError: true),
                                              //   )
                                              // FadeInImage(
                                              //   placeholder: const AssetImage(
                                              //       'assets/no-image.jpg'),
                                              //   image: NetworkImage(
                                              //       provider.getfullImagePath(
                                              //           content[i].name)),
                                              //   height: 100,
                                              //   width: 80,
                                              //   fit: BoxFit.contain,
                                              // ))
                                              : Expanded(
                                                  child: Icon(
                                                      Icons.no_sim_outlined,
                                                      size: 100,
                                                      color: AppTheme.primary
                                                          .withOpacity(0.9))),
                                      Text(
                                        content[i].name,
                                        maxLines: 2,
                                        overflow: TextOverflow.visible,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 4 : 2,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5,
                        mainAxisExtent: 150,
                      ),
                    ),
                  )
      ],
    );
  }
}

void displayDialog(BuildContext context, String imagePath) {
  showDialog(
      barrierDismissible: true,
      context: context,
      useSafeArea: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(10)),
          elevation: 5,
          content: FadeInImage(
            image: NetworkImage(imagePath),
            placeholder: const AssetImage('assets/noimage.jpg'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Regresar'),
            ),
          ],
        );
      });
}
