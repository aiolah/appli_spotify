import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchMenu extends StatelessWidget {
  /// Constructs a [SearchMenu]
  const SearchMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Search menu')),
        body: Center(
            child: Column(children: [
          ElevatedButton(
            onPressed: () => context.go('/b/searchalbums'),
            child: const Text('Search by albums'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/b/searchtracks'),
            child: const Text('Search by tracks'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/b/searchartists'),
            child: const Text('Search by artists'),
          )
        ])));
  }
}

// child: ElevatedButton(
    //   onPressed: () => context.go('/a/albumdetails'),
    //   child: const Text('Go to the Details screen'),
    // ),