import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radio_station/core/radio_station.dart';
import 'package:radio_station/favorite/view/favorite_button.dart';
import 'package:radio_station/player/views/player_page.dart';
import 'package:shimmer/shimmer.dart';

class RadioStationTile extends StatelessWidget {
  const RadioStationTile({super.key, required this.station, required this.index});

  final RadioStation station;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(PlayerPage.route(station)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image section with shimmer effect
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        station.favicon != null && station.favicon!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: _ShimmerImageLoader(
                                  imageUrl: station.favicon!,
                                ),
                              )
                            : Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.grey.withOpacity(0.3), // Placeholder color if image is null
                                ),
                                child: const Icon(Icons.visibility_off_outlined),
                              ),
                        FavoriteButton(radioStation: station),
                      ],
                    ),

                    const SizedBox(width: 12.0),

                    // Text section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            station.name,
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 18.0,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.language, color: Theme.of(context).primaryColor, size: 22.0),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: Text(
                                  station.language == null || station.language!.isEmpty ? 'Unknown' : station.language!,
                                  style: GoogleFonts.openSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.arrow_upward_rounded, color: Theme.of(context).primaryColor, size: 22.0),
                              const SizedBox(width: 4.0),
                              Text(
                                "${station.votes ?? 0}",
                                style: GoogleFonts.openSans(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.label, color: Theme.of(context).primaryColor, size: 22.0),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: Text(
                                  station.tags == null || station.tags!.isEmpty ? 'No tags available' : station.tags!,
                                  style: GoogleFonts.openSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShimmerImageLoader extends StatefulWidget {
  final String imageUrl;

  const _ShimmerImageLoader({required this.imageUrl});

  @override
  State<_ShimmerImageLoader> createState() => __ShimmerImageLoaderState();
}

class __ShimmerImageLoaderState extends State<_ShimmerImageLoader> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          enabled: _isLoading,
          child: Container(
            width: 100.0,
            height: 100.0,
            color: Colors.white,
          ),
        ),
        Image.network(
          widget.imageUrl,
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              // Image fully loaded, stop the shimmer effect
              _isLoading = false;
              return child;
            } else {
              // Image is still loading, keep showing the shimmer
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
