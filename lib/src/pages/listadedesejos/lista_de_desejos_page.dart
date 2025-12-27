import 'package:catalago_colecionadores/src/core/database/isar_models/car_base_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/header_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/grid_item.dart';

class ListaDeDesejosPage extends StatefulWidget {
  const ListaDeDesejosPage({super.key});

  @override
  State<ListaDeDesejosPage> createState() => _ListaDeDesejosPageState();
}

class _ListaDeDesejosPageState extends State<ListaDeDesejosPage> {
  final IsarService _isarService = IsarService();
  List<CarBaseCollection> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final cars = await _isarService.getFavoriteBaseCars();
    if (mounted) {
      setState(() {
        _items = cars.whereType<CarBaseCollection>().toList();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              constraints: BoxConstraints(minHeight: sizeOf.height),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(R.ASSETS_IMAGES_CAPA_START_PNG),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(
                          20,
                          18,
                          20,
                          16,
                        ), // as per CSS
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: CatalagoColecionadorTheme.blackClaroColor,
                              width: 1,
                            ),
                          ),
                        ),
                        child: HeaderSectionWidget(
                          textHeader: 'Lista de Desejos',
                          funcReturn: true,
                          onTap: () async {
                            if (context.canPop()) {
                              context.pop();
                            }
                          },
                        ),
                      ),
                      const Divider(color: CatalagoColecionadorTheme.whiteColor, thickness: 0.6),
                      const SizedBox(height: 12),
                      // Search Bar
                      _buildSearchBar(),
                      const SizedBox(height: 8),
                      Text(
                        'Itens na Lista de Desejos',
                        style: CatalagoColecionadorTheme.textBold.copyWith(
                          color: CatalagoColecionadorTheme.whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.25,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Filters Row
                      Expanded(
                        child: _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : _items.isEmpty
                            ? const Center(
                                child: Text(
                                  'Sua lista de desejos está vazia',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      childAspectRatio:
                                          0.65, // Adjust based on card content
                                    ),
                                itemCount: _items.length,
                                itemBuilder: (context, index) {
                                  return GridItem(item: _items[index]);
                                },
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329), // Darker search background
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2C323B)),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Pesquisar na lista...',
          hintStyle: TextStyle(color: Color(0xFF7A8391)),
          prefixIcon: Icon(Icons.search, color: Color(0xFF7A8391)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildFilterButton({required IconData icon, required String label}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
