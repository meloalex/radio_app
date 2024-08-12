import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagsList extends StatefulWidget {
  final List<String> tags;
  final int initialVisibleCount;
  final String showMoreText;
  final String showLessText;
  final Duration animationDuration;

  const TagsList({
    super.key,
    required this.tags,
    this.initialVisibleCount = 3, // Show 3 tags initially
    this.showMoreText = "Show more",
    this.showLessText = "Show less",
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<TagsList> createState() => _TagsListState();
}

class _TagsListState extends State<TagsList> with SingleTickerProviderStateMixin {
  bool _showAllTags = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<double>(
      begin: 10.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _toggleShowAllTags() {
    setState(() {
      _showAllTags = !_showAllTags;
      if (_showAllTags) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialTags = widget.tags.take(widget.initialVisibleCount).toList();
    final additionalTags = widget.tags.skip(widget.initialVisibleCount).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the initial tags without animation
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: initialTags.map((tag) {
            return Chip(
              label: Text(
                tag,
                style: GoogleFonts.openSans(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14.0,
                ),
              ),
              backgroundColor: Theme.of(context).cardColor,
            );
          }).toList(),
        ),
        // Display additional tags with animation if showAllTags is true
        AnimatedSize(
          duration: widget.animationDuration,
          curve: Curves.easeInOut,
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: _showAllTags
                ? additionalTags.map((tag) {
                    return AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation.value,
                          child: Transform.translate(
                            offset: Offset(0, _slideAnimation.value),
                            child: child,
                          ),
                        );
                      },
                      child: Chip(
                        label: Text(
                          tag,
                          style: GoogleFonts.openSans(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14.0,
                          ),
                        ),
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                    );
                  }).toList()
                : [],
          ),
        ),
        // Show/Hide Button
        if (widget.tags.length > widget.initialVisibleCount)
          TextButton(
            onPressed: _toggleShowAllTags,
            child: Text(
              _showAllTags ? widget.showLessText : widget.showMoreText,
              style: GoogleFonts.openSans(
                color: Theme.of(context).primaryColor,
                fontSize: 14.0,
              ),
            ),
          ),
      ],
    );
  }
}
