import 'package:cached_network_image/cached_network_image.dart';
import 'package:caremixer_test/config/layout_config/layout_config.dart';
import 'package:caremixer_test/part_2_api_integration/pokemon_api_view_model/pokemon_api_state.dart';
import 'package:caremixer_test/part_2_api_integration/pokemon_api_view_model/pokemon_api_view_model.dart';
import 'package:caremixer_test/utils/utils_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonApiView extends StatefulWidget {
  const PokemonApiView({super.key});

  @override
  State<PokemonApiView> createState() => _PokemonApiViewState();
}

class _PokemonApiViewState extends State<PokemonApiView> {

  final ScrollController _scrollController = ScrollController();
  bool _isFetchingMore = false;

    @override
  void initState() {
    super.initState();
   _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100 
      && !_isFetchingMore) {
        _isFetchingMore = true;
     context.read<PokemonApiViewModel>().add(LoadNextPagePokemons());
     Future.delayed(const Duration(milliseconds: 500), () {
        _isFetchingMore = false;
      });
    }
  }

  @override
  void dispose() {
     _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  LayoutConfig(
          appBarTitle: 'Pokemon Api',
          currentIndex: 1,
          child:BlocBuilder<PokemonApiViewModel, PokemonListState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (!state.isLoading) {
                return  RefreshIndicator(
                  onRefresh: () async {
                    context.read<PokemonApiViewModel>().add(ResetPaginationPokemons());
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                        SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        sliver: SliverGrid(
                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,      // 2 per row
                          mainAxisSpacing: 15.0,   // vertical spacing
                          crossAxisSpacing: 15.0,  // horizontal spacing
                          childAspectRatio: 1.0,  // width/height ratio
                        ),
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.pokemons.length,
                          (context, index) {
                  
                            return Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                boxShadow: [
                                  BoxShadow(
                                    color:Theme.of(context).colorScheme.onPrimary
                                        .withAlpha((255 * 0.24).round()),
                                    blurRadius: 10,
                                  ),
                                  BoxShadow(
                                    color:Theme.of(context).colorScheme.onPrimary
                                        .withAlpha((255 * 0.08).round()),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      UtilsFunctions.capitalizeFirstLetter(state.pokemons[index].pokemonName),
                                      style:Theme.of(context).primaryTextTheme.headlineSmall,
                                    ),
                                     Center(
                                      child: CachedNetworkImage(
                                        imageUrl: state.pokemons[index].pokemonImage,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => Icon(Icons.error, size: 50, color: Theme.of(context).colorScheme.error),
                                      ),
                                    ),
                                  ],
                                ),
                            );
                          
                       })),),
                        SliverToBoxAdapter(
                        child: state.isLoadingMore && state.pokemons.isNotEmpty
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(child: CircularProgressIndicator()),
                              )
                            : const SizedBox.shrink(),
                      ),
                   ],
                  ),
                );
              } else if (state.error != null) {
                return Center(child: Text(state.error!));
              }
              return const SizedBox();
            },
          ),
    );
  }
}