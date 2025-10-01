import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'my_profile_page.dart';

class Item {
  final String title;
  final int imageSeed; // used with picsum
  final List<String> tags;

  Item({required this.title, required this.imageSeed, required this.tags});
}

class HomePage extends StatelessWidget {
  // Example data - replace with your real data later
  final List<Item> items = [
    Item(
      title: 'Build a Flutter App',
      imageSeed: 10,
      tags: ['flutter', 'dart', 'mobile', 'ui', 'clean-arch'],
    ),
    Item(
      title: 'Design Good UX',
      imageSeed: 21,
      tags: ['ux', 'design', 'user-first'],
    ),
    Item(
      title: 'Write Tests',
      imageSeed: 33,
      tags: ['testing', 'unit-test', 'bloc', 'integration', 'ci'],
    ),
    Item(
      title: 'Deploy to Play Store',
      imageSeed: 44,
      tags: ['deploy', 'play-store'],
    ),
    Item(
      title: 'Use Firebase',
      imageSeed: 55,
      tags: ['firebase', 'auth', 'firestore', 'storage', 'functions'],
    ),
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('How Can I Make'),
        centerTitle: true,
        // Profile icon on the right
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'My Profile',
            onPressed: () {
              context.go('/Profile');
            },
          ),
          const SizedBox(width: 8), // small padding to the edge
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        // We'll use StatefulBuilder to manage the search text locally
        child: StatefulBuilder(builder: (context, setState) {
          String query = ''; // local search query
          final TextEditingController controller = TextEditingController();

          // Filter function (case-insensitive) using controller.text
          List<Item> filtered() {
            final q = controller.text.trim().toLowerCase();
            if (q.isEmpty) return items;
            return items.where((it) {
              final inTitle = it.title.toLowerCase().contains(q);
              final inTags = it.tags.any((t) => t.toLowerCase().contains(q));
              return inTitle || inTags;
            }).toList();
          }

          // Note: we add a listener to controller to call setState when text changes.
          // Because StatefulBuilder is recreated during the build, ensure we don't add multiple listeners.
          controller.addListener(() {
            // only rebuild the StatefulBuilder's content
            setState(() {});
          });

          final list = filtered();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search field
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Search title or tags...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: controller.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();
                      setState(() {});
                    },
                  )
                      : null,
                  filled: true,
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // List of cards
              Expanded(
                child: list.isEmpty
                    ? Center(child: Text('No results for "${controller.text}"'))
                    : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    // Use picsum.photos as free image source; seed makes stable images
                    final imageUrl =
                        'https://picsum.photos/seed/${item.imageSeed}/600/260';

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: AspectRatio(
                              aspectRatio: 600 / 260,
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    color: colorScheme.surfaceVariant.withOpacity(0.1),
                                    child: const Center(
                                        child: CircularProgressIndicator()),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: colorScheme.surfaceVariant,
                                    height: 140,
                                    child: const Center(
                                        child: Icon(Icons.broken_image)),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                // Hashtags (max 5)
                                Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: item.tags
                                      .take(5)
                                      .map((tag) => Chip(
                                    label: Text('#$tag',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall),
                                    backgroundColor:
                                    colorScheme.surfaceContainerHighest,
                                    visualDensity:
                                    VisualDensity.compact,
                                  ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
