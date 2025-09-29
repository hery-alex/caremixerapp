import 'package:caremixer_test/api_library/api_base/caremixer_api_base.dart';
import 'package:caremixer_test/part_2_api_integration/pokemon_api_view_model/pokemon_api_state.dart';
import 'package:caremixer_test/part_2_api_integration/pokemon_model/pokemon_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PokemonApiViewModel extends Bloc<PokemonListEvent, PokemonListState> {

   ApiPokemonListEndpoint pokemonListEndpoint = ApiPokemonListEndpoint();

   PokemonApiViewModel() : super(PokemonListState()) {
    on<LoadPokemons>((event, emit) async {
      emit(state.copyWith(isLoading : true));
      try {
       final result = await pokemonListEndpoint.getAllPokemoList();
      final List<PokemonModel> pokemonList = [];

        for (final element in result) {
          final pokemonImage =
              await pokemonListEndpoint.getPokemonImage(element["url"]);
          pokemonList.add(
            PokemonModel(
              pokemonName: element["name"],
              pokemonImage: pokemonImage,
            ),
          );
        }
      
        emit(state.copyWith(isLoading:false,pokemons :pokemonList));
      } catch (e) {
        emit(state.copyWith(isLoading:false,error: e.toString()));
      }
    });
    on<LoadNextPagePokemons>((event, emit) async {
      emit(state.copyWith(isLoadingMore :true));
       final result = await pokemonListEndpoint.getAllPokemoList();
      final List<PokemonModel> newBatch = [];
        for (final element in result) {
          final pokemonImage =
              await pokemonListEndpoint.getPokemonImage(element["url"]);
          newBatch.add(
            PokemonModel(
              pokemonName: element["name"],
              pokemonImage: pokemonImage,
            ),
          );
        }

        emit(state.copyWith(isLoading :false , pokemons:[...state.pokemons, ...newBatch]));
    });
  }
  
}