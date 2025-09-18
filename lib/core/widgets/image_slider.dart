import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';

class ImageSliderWidget extends StatefulWidget {
  // List of image URLs or asset paths
  final List<String> imageUrls;

  // Height of the slider, defaults to 200.0 if not provided
  final double height;

  // Duration for auto-play, defaults to 3 seconds. Set to null for no auto-play.
  final Duration? autoPlayDuration;

  final bool? isNetworkImage;

  const ImageSliderWidget({
    super.key,
    required this.imageUrls,
    this.height = 200.0,
    this.autoPlayDuration = const Duration(seconds: 3),
    this.isNetworkImage,
  });

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  // Controller for the PageView to manage page changes
  late PageController _pageController;

  // Current index of the displayed image
  int _currentPage = 0;

  // Timer for auto-play functionality
  // Timer? _timer; // Uncomment if you want to implement auto-play

  @override
  void initState() {
    super.initState();
    // Initialize PageController with the initial page
    _pageController = PageController(initialPage: _currentPage);

    // Add a listener to update the current page when the user scrolls
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });

    // Start auto-play if duration is provided
    // _startAutoPlay(); // Uncomment if you want to implement auto-play
  }

  // Method to start auto-play
  // void _startAutoPlay() {
  //   if (widget.autoPlayDuration != null && widget.imageUrls.isNotEmpty) {
  //     _timer = Timer.periodic(widget.autoPlayDuration!, (timer) {
  //       if (_pageController.hasClients) {
  //         int nextPage = (_currentPage + 1) % widget.imageUrls.length;
  //         _pageController.animateToPage(
  //           nextPage,
  //           duration: const Duration(milliseconds: 400),
  //           curve: Curves.easeIn,
  //         );
  //       }
  //     });
  //   }
  // }

  @override
  void dispose() {
    // Dispose the PageController to prevent memory leaks
    _pageController.dispose();
    // _timer?.cancel(); // Uncomment if you want to implement auto-play
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // PageView to display the images
        Container(
          decoration:  BoxDecoration(
          color:  AppColors.greyLight.withOpacity(.2),
            borderRadius: BorderRadius.circular(12)
          ),
          height:  widget.height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              final imageUrl = widget.imageUrls[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: (widget.isNetworkImage ?? true)
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                        )
                      : Image.asset(
                          imageUrl,
                          fit: BoxFit.contain,
                        ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 21.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.imageUrls.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.symmetric(horizontal: 4.0,),
              height: 4.0,
              width: _currentPage == index ? 12.0 : 12.0,
              decoration: BoxDecoration(
                color: _currentPage == index ? AppColors.primaryColor : AppColors.grey,
                borderRadius: BorderRadius.circular(4.0),
              ),
            );
          }),
        ),
      ],
    );
  }
}

