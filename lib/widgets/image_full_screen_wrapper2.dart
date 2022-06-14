import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageFullScreenWrapperWidget extends StatelessWidget {
  final String child;
  final bool dark;
  final double? height;
  final double? width;

  const ImageFullScreenWrapperWidget({
    Key? key,
    required this.child,
    this.dark = true,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              barrierColor: dark ? Colors.black : Colors.white,
              pageBuilder: (BuildContext context, _, __) {
                return FullScreenPage(
                  child: child,
                  dark: dark,
                );
              },
            ),
          );
        },
        child: Hero(
          tag: child,
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/no-image.jpg',
            image: child,
            height: height,
            width: width,
            imageCacheHeight: height!.toInt(),
            imageCacheWidth: width!.toInt(),
          ),
        )

        // Image.network(
        //   child,
        //   loadingBuilder: (BuildContext context, Widget child,
        //       ImageChunkEvent? loadingProgress) {
        //     if (loadingProgress == null) return child;
        //     return Center(
        //       child: CircularProgressIndicator(
        //         value: loadingProgress.expectedTotalBytes != null
        //             ? loadingProgress.cumulativeBytesLoaded /
        //                 loadingProgress.expectedTotalBytes!
        //             : null,
        //       ),
        //     );
        //   },
        //   cacheHeight: height!.toInt(),
        //   cacheWidth: width!.toInt(),
        //   height: height,
        //   width: width,
        // )

        // child: Hero(
        //   tag: child,
        //   child: CachedNetworkImage(

        //     errorWidget: (context, url, error) => const Icon(
        //       Icons.image,
        //       size: 40,
        //     ),
        //     memCacheHeight: height!.toInt(),
        //     memCacheWidth: width!.toInt(),
        //     height: height,
        //     width: width,
        //     imageUrl: child,
        //     placeholder: (context, url) =>
        //         const Center(child: CircularProgressIndicator()),
        //   ),
        // ),
        );
  }
}

class FullScreenPage extends StatefulWidget {
  const FullScreenPage({
    Key? key,
    required this.child,
    required this.dark,
    this.height,
    this.width,
  }) : super(key: key);

  final String child;
  final bool dark;
  final double? height;
  final double? width;

  @override
  _FullScreenPageState createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {
  @override
  void initState() {
    var brightness = widget.dark ? Brightness.light : Brightness.dark;
    var color = widget.dark ? Colors.black12 : Colors.white70;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: color,
      statusBarColor: color,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
      systemNavigationBarDividerColor: color,
      systemNavigationBarIconBrightness: brightness,
    ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // Restore your settings here...
        ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.dark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 333),
                curve: Curves.fastOutSlowIn,
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 4,
                  child: Hero(
                      tag: widget.child,
                      child: Image.network(
                        widget.child,
                        cacheHeight:
                            MediaQuery.of(context).size.height.toInt() * 2,
                        cacheWidth:
                            MediaQuery.of(context).size.width.toInt() * 2,
                        height: widget.height,
                        width: widget.width,
                      )

                      // CachedNetworkImage(

                      //   memCacheHeight:
                      //       MediaQuery.of(context).size.height.toInt() * 2,
                      //   memCacheWidth:
                      //       MediaQuery.of(context).size.width.toInt() * 2,
                      //   height: widget.height,
                      //   width: widget.width,
                      //   fit: BoxFit.contain,
                      //   imageUrl: widget.child,
                      //   placeholder: (context, url) =>
                      //       const Center(child: CircularProgressIndicator()),
                      // ),
                      ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: MaterialButton(
                padding: const EdgeInsets.all(15),
                elevation: 0,
                color: widget.dark ? Colors.black12 : Colors.white70,
                highlightElevation: 0,
                minWidth: double.minPositive,
                height: double.minPositive,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back,
                  color: widget.dark ? Colors.white : Colors.black,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
