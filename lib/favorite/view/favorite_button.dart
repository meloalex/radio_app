import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_station/core/radio_station.dart';
import 'package:radio_station/favorite/cubit/favorite_cubit.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.radioStation});

  final RadioStation radioStation;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _colorAnimation = ColorTween(
      begin: Theme.of(context).primaryColor,
      end: Theme.of(context).primaryColor,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit(widget.radioStation.uuid),
      child: Builder(
        builder: (context) {
          return BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              if (state.isFavorite) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }

              return ScaleTransition(
                scale: _scaleAnimation,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: IconButton(
                    key: ValueKey<bool>(state.isFavorite),
                    icon: Icon(
                      state.isFavorite ? Icons.star : Icons.star_outline,
                      color: _colorAnimation.value,
                      size: 28,
                    ),
                    onPressed: () => context.read<FavoriteCubit>().markAsFavorite(widget.radioStation.uuid),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
