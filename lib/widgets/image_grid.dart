import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style_gallery/models/models.dart';
import 'package:style_gallery/providers/providers.dart';
import 'package:style_gallery/widgets/widgets.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    if (ordersProvider.orderContents[ordersProvider.order]?.content == null) {
      return Container();
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount:
            ordersProvider.orderContents[ordersProvider.order]?.content.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (_, int index) => _ImageCard(
          content: ordersProvider
              .orderContents[ordersProvider.order]!.content[index],
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 275),
      );
    }
  }
}

class _ImageCard extends StatelessWidget {
  final Content content;
  const _ImageCard({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    String name = content.name;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 140,
      height: 100,
      child: Column(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Hero(
              tag: name,
              child: ImageFullScreenWrapperWidget(
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(ordersProvider.getfullImagePath(name)),
                  height: 250,
                  width: 150,
                  fit: BoxFit.contain,
                ),
                dark: false,
              ),
            )),
        const SizedBox(
          height: 5,
        ),
        Text(
          content.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
