import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style_gallery/models/models.dart';
import 'package:style_gallery/providers/sublimation_provider.dart';

class SublimationSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search Style';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  Widget _emptyContainer() {
    return const Center(
        child: Icon(
      Icons.style_rounded,
      color: Colors.black38,
      size: 130,
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final sublimationProvider =
        Provider.of<SublimationProvider>(context, listen: false);
    sublimationProvider.getStylesByQuery(query);

    return StreamBuilder(
      builder: (_, AsyncSnapshot<List<Content>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();
        final content = snapshot.data!;

        return ListView.builder(
            itemCount: content.length,
            itemBuilder: (_, int index) => _StyleItem(
                  content: content[index],
                ));
      },
      stream: sublimationProvider.suggestionStream,
    );
  }
}

class _StyleItem extends StatelessWidget {
  final Content content;

  const _StyleItem({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const FadeInImage(
        placeholder: AssetImage('assets/no-image.jpg'),
        image: NetworkImage(''), //content.fullPosterImg),
        width: 50,
        fit: BoxFit.contain,
      ),
      //title: Text(content.title),
      //subtitle: Text(content.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: content);
      },
    );
  }
}
