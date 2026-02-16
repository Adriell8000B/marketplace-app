import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:marketplace/widgets/section_header.dart';
import 'package:marketplace/widgets/product_card.dart';

const _accent = Color(0xFF25AFF4);
const _cardBg = Color(0xFF1A282F);

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: const Color(0xFF101C22).withValues(alpha: 0.8),
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.transparent),
              ),
            ),
            title: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Discover brands, products...",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: const Icon(Icons.search_rounded, color: Colors.grey),
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

          // --- QUICK FILTERS ---
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  _FilterChip(label: "All", active: true),
                  _FilterChip(label: "Tech"),
                  _FilterChip(label: "Fashion"),
                  _FilterChip(label: "Home"),
                  _FilterChip(label: "Sports"),
                  _FilterChip(label: "Deals"),
                ],
              ),
            ),
          ),

          // --- COLLECTIONS ---
          const SliverToBoxAdapter(
            child: SectionHeader(title: "Collections", action: "See All"),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _CollectionCard(
                    title: "Audio",
                    subtitle: "Headphones & speakers",
                    imageUrl: "https://picsum.photos/400/200?random=1",
                  ),
                  _CollectionCard(
                    title: "Gaming",
                    subtitle: "Gear & accessories",
                    imageUrl: "https://picsum.photos/400/200?random=2",
                  ),
                  _CollectionCard(
                    title: "Office",
                    subtitle: "Desk setup",
                    imageUrl: "https://picsum.photos/400/200?random=3",
                  ),
                ],
              ),
            ),
          ),

          // --- POPULAR THIS WEEK ---
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: const SliverToBoxAdapter(
              child: SectionHeader(title: "Popular This Week", action: "View All"),
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
                (context, index) => _PopularProductCard(index: index),
                childCount: 6,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool active;

  const _FilterChip({required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: FilterChip(
        label: Text(label),
        selected: active,
        onSelected: (_) {},
        backgroundColor: _cardBg,
        selectedColor: _accent,
        labelStyle: TextStyle(
          color: active ? Colors.white : Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        side: BorderSide.none,
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const _CollectionCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PopularProductCard extends StatelessWidget {
  final int index;

  const _PopularProductCard({required this.index});

  static const _products = [
    ("Wireless Earbuds Pro", "Audio", "\$129.00"),
    ("Minimal Backpack", "Fashion", "\$79.00"),
    ("Desk Lamp LED", "Home", "\$45.00"),
    ("Running Shoes", "Sports", "\$120.00"),
    ("Mechanical Keyboard", "Tech", "\$99.00"),
    ("Smart Watch", "Tech", "\$199.00"),
  ];

  @override
  Widget build(BuildContext context) {
    final product = _products[index % _products.length];
    return ProductCard(
      title: product.$1,
      subtitle: product.$2,
      price: product.$3,
      imageUrl: "https://picsum.photos/200?random=$index",
    );
  }
}
