
import 'package:caremixer_test/part_2_api_integration/pokemon_model/pokemon_model.dart';


class PokemonListState {
  final List<PokemonModel> pokemons;
  final bool isLoading;
  final String? error;

  PokemonListState({
    this.pokemons = const [],
    this.isLoading = false,
    this.error,
  });

  // copyWith lets you update only the fields you want
  PokemonListState copyWith({
    List<PokemonModel>? pokemons,
    bool? isLoading,
    String? error,
  }) {
    return PokemonListState(
      pokemons: pokemons ?? this.pokemons,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

abstract class PokemonListEvent {}

class LoadPokemons extends PokemonListEvent {}

class LoadNextPagePokemons extends PokemonListEvent {}