import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vyuh_core/vyuh_core.dart';
import 'package:vyuh_feature_system/vyuh_feature_system.dart';

class Carousel extends StatefulWidget {
  final Group content;

  final double viewportFraction;

  const Carousel(
      {super.key, required this.content, this.viewportFraction = 0.75});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: widget.viewportFraction);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 100, maxHeight: 200),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              padEnds: false,
              controller: _controller,
              pageSnapping: true,
              scrollDirection: Axis.horizontal,
              children: widget.content.items
                  .map((e) => vyuh.content.buildContent(context, e))
                  .toList(growable: false),
            ),
          ),
          const SizedBox(height: 8),
          SmoothPageIndicator(
            controller: _controller,
            onDotClicked: (index) => _controller.animateToPage(index,
                curve: Curves.easeInOutCubic,
                duration: const Duration(milliseconds: 300)),
            count: widget.content.items.length,
            effect: JumpingDotEffect(
              offset: 20,
              spacing: 8,
              dotHeight: 3,
              dotWidth: 12,
              dotColor: theme.colorScheme.inversePrimary,
              activeDotColor: theme.colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
