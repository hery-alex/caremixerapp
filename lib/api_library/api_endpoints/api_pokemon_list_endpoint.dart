part of 'package:caremixer_test/api_library/api_base/caremixer_api_base.dart';

class ApiPokemonListEndpoint extends CaremixerApiBase{
   

    ApiPokemonListEndpoint();
     Uri? pokemonListNext;
     bool end = false;

    void resetPagination() {
      pokemonListNext = null;
      end = false;
    }

    Future<List<dynamic>> getAllPokemoList () async{
      if(!end){
        final uri =  pokemonListNext ?? Uri.https(_baseUrl, '/api/v2/pokemon',  {
            'limit': '30',   // fetch 30
            'offset': '0',   // start from beginning
          }
          );
          final response = await _get(uri);
          if(response["next"] != null){
            pokemonListNext = Uri.parse(response["next"]);
          }

          if(response["next"] == null && pokemonListNext != null){
            pokemonListNext = null;
            end = true;
          }

          return response["results"];
      }
      return [];
   }


   Future<String> getPokemonImage (String url) async{
     final uri = Uri.parse(url);
     final response = await _get(uri);
     return response["sprites"]["front_default"];
   }
}