
import 'package:caremixer_test/part_2_api_integration/pokemon_model/pokemon_model.dart';


class PokemonListState {
  final List<PokemonModel> pokemons;
  final List<PokemonModel> filteredPokemons;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;

  PokemonListState({
    this.pokemons = const [],
    this.filteredPokemons = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  });

  // copyWith lets you update only the fields you want
  PokemonListState copyWith({
    List<PokemonModel>? pokemons,
    List<PokemonModel>? filteredPokemons,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
  }) {
    return PokemonListState(
      pokemons: pokemons ?? this.pokemons,
      filteredPokemons: filteredPokemons ?? this.filteredPokemons,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

abstract class PokemonListEvent {}

class LoadPokemons extends PokemonListEvent {}

class LoadNextPagePokemons extends PokemonListEvent {}

class ResetPaginationPokemons extends PokemonListEvent {}

class SearchPokemons extends PokemonListEvent {
  final String query;
  SearchPokemons(this.query);
}