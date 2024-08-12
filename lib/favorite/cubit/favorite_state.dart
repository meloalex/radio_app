part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  const FavoriteState({this.isFavorite = false});

  final bool isFavorite;

  FavoriteState copyWith({
    bool? isFavorite,
  }) {
    return FavoriteState(
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object> get props => [isFavorite];
}
