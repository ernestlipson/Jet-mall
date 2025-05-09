import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cdc_mall/features/home/data/models/home_models.dart';
import 'package:cdc_mall/features/home/presentation/bloc/home_bloc.dart';
import 'package:cdc_mall/features/home/presentation/widgets/home_widgets.dart';
import 'package:cdc_mall/shared/widgets/search_bar_widget.dart';

/// The home page of the CDC Mall app
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _bannerController = PageController();
  int _currentBannerPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const LoadHomeData());
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('CDC Mall',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined,
                color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchBarWidget(),
                  const SizedBox(height: 16),
                  _buildPopularItemSection(state.promoBanners),
                  const SizedBox(height: 24),
                  _buildCategoriesSection(state.categories),
                  const SizedBox(height: 24),
                  _buildNewInSection(context, state.newProducts),
                ],
              ),
            );
          } else if (state is HomeError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  // Popular item section with carousel
  Widget _buildPopularItemSection(List<PromoBanner> banners) {
    return Column(
      children: [
        const SectionHeaderWidget(title: 'Popular Item'),
        const SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _bannerController,
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentBannerPage = index;
              });
            },
            itemBuilder: (context, index) {
              return PromoBannerWidget(banner: banners[index]);
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentBannerPage == index
                    ? const Color(0xFFF97316)
                    : Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Categories section with horizontal scrolling
  Widget _buildCategoriesSection(List<Category> categories) {
    return Column(
      children: [
        SectionHeaderWidget(
          title: 'Shop by category',
          onSeeAllTap: () {},
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 96,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 24),
                child: CategoryWidget(category: categories[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  // New products section
  Widget _buildNewInSection(BuildContext context, List<Product> products) {
    return Column(
      children: [
        SectionHeaderWidget(
          title: 'New In',
          onSeeAllTap: () {},
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to product detail page
                  },
                  child: Stack(
                    children: [
                      ProductCardWidget(product: product),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFFF97316),
                          radius: 16,
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Add to cart functionality
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
