import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:marketplace/widgets/section_header.dart';
import 'package:marketplace/widgets/category_item.dart';
import 'package:marketplace/widgets/cart_button.dart';
import 'package:marketplace/widgets/product_card.dart';
import 'package:marketplace/widgets/promo_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: (theme.appBarTheme.backgroundColor ?? colorScheme.surface)
                .withValues(alpha: 0.8),
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.transparent),
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search products...",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                      ),
                      fillColor: Colors.white.withValues(alpha: 0.05),
                      filled: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const CartButton(),
              ],
            ),
          ),

          // --- CATEGORIES ---
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: "Categories", action: "View All"),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: const [
                      CategoryItem(
                        icon: Icons.bolt,
                        label: "Tech",
                        active: true,
                      ),
                      CategoryItem(
                        icon: Icons.checkroom,
                        label: "Fashion",
                      ),
                      CategoryItem(
                        icon: Icons.chair,
                        label: "Home",
                      ),
                      CategoryItem(
                        icon: Icons.fitness_center,
                        label: "Sports",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- BANNER ---
          const SliverToBoxAdapter(child: PromoBanner()),

          // --- TRENDING GRID ---
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: const SliverToBoxAdapter(
              child: SectionHeader(title: "Trending Now", action: ""),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                mainAxisExtent: 260,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => const ProductCard(),
                childCount: 4,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
