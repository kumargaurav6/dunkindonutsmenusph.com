import 'package:flutter/material.dart';
import '../data/menu_data.dart';
import '../theme/app_theme.dart';
import '../widgets/item_card.dart';
import 'home_screen.dart';

/// Full menu with a scrollable category TabBar and item lists.
class MenuScreen extends StatefulWidget {
  final String? initialCategoryId;

  const MenuScreen({super.key, this.initialCategoryId});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    final initialIndex = widget.initialCategoryId == null
        ? 0
        : categories
            .indexWhere((c) => c.id == widget.initialCategoryId)
            .clamp(0, categories.length - 1);
    _tabController =
        TabController(length: categories.length, vsync: this, initialIndex: initialIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.of(context).canPop();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        automaticallyImplyLeading: canPop,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            for (final c in categories)
              Tab(text: c.name),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          for (final category in categories)
            _CategoryItemList(categoryId: category.id),
        ],
      ),
    );
  }
}

class _CategoryItemList extends StatelessWidget {
  final String categoryId;

  const _CategoryItemList({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final category = categoryById(categoryId);
    final list = itemsInCategory(categoryId);

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: list.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        if (i == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                const Icon(Icons.local_cafe, color: AppColors.orange, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    category.tagline,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  '${list.length} items',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        }
        final item = list[i - 1];
        return ItemCard(
          item: item,
          onTap: () => openItemDetail(context, item),
        );
      },
    );
  }
}
