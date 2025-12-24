import 'package:catalago_colecionadores/src/core/database/isar_models/car_base_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

import 'grid_item.dart';

class NovidadesItemsList extends StatefulWidget {
  final double width;
  final double height;
  final double imgHeight;
  final bool isScrollable;

  const NovidadesItemsList({
    super.key,
    required this.width,
    required this.height,
    required this.imgHeight,
    this.isScrollable = false,
  });

  @override
  State<NovidadesItemsList> createState() => _NovidadesItemsListState();
}

class _NovidadesItemsListState extends State<NovidadesItemsList> {
  final IsarService _isarService = IsarService();
  List<CarBaseCollection>? _items;
  Set<int> _favoriteIds = {};
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final results = await Future.wait([
        _isarService.getAllCarsBase(),
        _isarService.getAllFavoriteIds(),
      ]);

      if (mounted) {
        setState(() {
          _items = results[0] as List<CarBaseCollection>;
          _favoriteIds = (results[1] as List<int>).toSet();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Erro ao carregar novidades';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _toggleFavorite(int carBaseId) async {
    // Optimistic update
    setState(() {
      if (_favoriteIds.contains(carBaseId)) {
        _favoriteIds.remove(carBaseId);
      } else {
        _favoriteIds.add(carBaseId);
      }
    });

    try {
      await _isarService.toggleFavorite(carBaseId);
    } catch (e) {
      // Revert on error
      if (mounted) {
        setState(() {
          if (_favoriteIds.contains(carBaseId)) {
            _favoriteIds.remove(carBaseId);
          } else {
            _favoriteIds.add(carBaseId);
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao atualizar favorito')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    if (_items == null || _items!.isEmpty) {
      return const SizedBox.shrink();
    }

    final gap = widget.isScrollable ? 8.0 : 16.0;

    Widget list = SizedBox(
      height: widget.height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _items!.length,
        separatorBuilder: (context, index) => SizedBox(width: gap),
        itemBuilder: (context, index) {
          final item = _items![index];
          final isFavorite = _favoriteIds.contains(item.id);

          return SizedBox(
            width: widget.width,
            child: GridItem(
              item: item,
              surface: CatalagoColecionadorTheme.bgCard,
              brandColor: CatalagoColecionadorTheme.whiteColor,
              modelColor: CatalagoColecionadorTheme.navBarBackkgroundColor,
              onTap: () {
                // Navigation or other action
              },
              isFavorite: isFavorite,
              onFavoriteToggle: () => _toggleFavorite(item.id),
            ),
          );
        },
      ),
    );

    if (widget.isScrollable) {
      return list;
    }

    return list;
  }
}
