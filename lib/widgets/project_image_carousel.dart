import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectImageCarousel extends StatefulWidget {
  final List<String> images;
  final bool showPreviewGrid; // Show max 3 images in grid

  const ProjectImageCarousel({
    super.key,
    required this.images,
    this.showPreviewGrid = false,
  });

  @override
  State<ProjectImageCarousel> createState() => _ProjectImageCarouselState();
}

class _ProjectImageCarouselState extends State<ProjectImageCarousel> {
  void _openCarousel(int initialIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) =>
          _CarouselModal(images: widget.images, initialIndex: initialIndex),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return _buildPlaceholder(context);
    }

    // Show preview grid of max 3 images
    if (widget.showPreviewGrid && widget.images.length > 1) {
      return _buildImageGrid(context);
    }

    // Show single main image with carousel
    return _buildMainImage(context);
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        Icons.image_outlined,
        size: 60,
        color: Theme.of(context).primaryColor.withOpacity(0.3),
      ),
    );
  }

  Widget _buildImageGrid(BuildContext context) {
    final imagesToShow = widget.images.take(3).toList();

    return GestureDetector(
      onTap: () => _openCarousel(0),
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Color(0xFF1A1A1A),
        ),
        child: Row(
          children: imagesToShow.asMap().entries.map((entry) {
            int index = entry.key;
            String imagePath = entry.value;
            return Expanded(
              child: Padding(
                padding: index < imagesToShow.length - 1
                    ? const EdgeInsets.only(right: 0)
                    : EdgeInsets.zero,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[800],
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey[400],
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMainImage(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _openCarousel(0),
      child: Container(
        // height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          image: DecorationImage(
            image: AssetImage(widget.images[0]),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {
              // Handle error if image not found
            },
          ),
        ),
        // child: ClipRRect(
        //   borderRadius: BorderRadius.circular(16),

        //   child: Image.asset(
        //     widget.images.first,
        //     fit: BoxFit.contain,
        //     errorBuilder: (context, error, stackTrace) {
        //       return Container(
        //         color: Colors.grey[800],
        //         child: Icon(
        //           Icons.broken_image,
        //           color: Colors.grey[400],
        //           size: 40,
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ),
    );
  }
}

class _CarouselModal extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _CarouselModal({required this.images, required this.initialIndex});

  @override
  State<_CarouselModal> createState() => _CarouselModalState();
}

class _CarouselModalState extends State<_CarouselModal> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.95)),
        child: Stack(
          children: [
            // Close button
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
                onPressed: () {
                  Get.back();
                },
              ),
            ),

            // Image counter
            Positioned(
              top: 48,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_currentIndex + 1} / ${widget.images.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Carousel
            Center(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: InteractiveViewer(
                        minScale: 0.5,
                        maxScale: 3.0,
                        child: Image.asset(
                          widget.images[index],
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.white54,
                                  size: 60,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Navigation dots (bottom)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.images.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      width: _currentIndex == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Left and right navigation
            if (widget.images.length > 1) ...[
              Positioned(
                left: 20,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _currentIndex > 0
                      ? IconButton(
                          icon: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        )
                      : const SizedBox(),
                ),
              ),
              Positioned(
                right: 20,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _currentIndex < widget.images.length - 1
                      ? IconButton(
                          icon: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        )
                      : const SizedBox(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
