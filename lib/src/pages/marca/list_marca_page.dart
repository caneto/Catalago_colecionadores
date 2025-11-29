import 'dart:io';

import 'package:catalago_colecionadores/src/core/database/isar_models/marca_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/pages/marca/add_marca_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class ListMarcaPage extends StatefulWidget {
  const ListMarcaPage({super.key});

  @override
  State<ListMarcaPage> createState() => _ListMarcaPageState();
}

class _ListMarcaPageState extends State<ListMarcaPage> {
  final IsarService _isarService = IsarService();
  List<MarcaCollection> _marcas = [];

  @override
  void initState() {
    super.initState();
    _loadMarcas();
  }

  Future<void> _loadMarcas() async {
    final marcas = await _isarService.getAllMarcas();
    setState(() {
      _marcas = marcas;
    });
  }

  Future<void> _deleteMarca(MarcaCollection marca) async {
    await _isarService.deleteMarca(marca.id);
    _loadMarcas();
  }

  void _editMarca(MarcaCollection marca) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddMarcaPage(marca: marca)),
    );
    _loadMarcas();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(minHeight: sizeOf.height),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(R.ASSETS_IMAGES_CAPA_START_PNG),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CatalagoColecionadorTheme.barColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child: SvgPicture.asset(
                        'assets/images/seta_esquerda.svg',
                        height: 28,
                        width: 28,
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Marcas',
                      style: CatalagoColecionadorTheme.titleStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: -0.01,
                        color: CatalagoColecionadorTheme.whiteColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Align(
                        alignment: AlignmentGeometry.centerRight,
                        child: Semantics(
                          label: 'Adicionar',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              child: SvgPicture.asset(
                                'assets/images/estrela.svg',
                                height: 32,
                                width: 32,
                                colorFilter: ColorFilter.mode(
                                  CatalagoColecionadorTheme.whiteColor,
                                  BlendMode.srcATop,
                                ),
                                semanticsLabel: 'X',
                              ),
                              onTap: () async {
                                await Navigator.of(
                                  context,
                                ).pushNamed('/add_marca_page');
                                _loadMarcas();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _marcas.length,
                  itemBuilder: (context, index) {
                    final marca = _marcas[index];
                    final isEven = index % 2 == 0;
                    final backgroundColor = isEven
                        ? CatalagoColecionadorTheme.bgInput
                        : CatalagoColecionadorTheme.bgInput.withValues(
                            alpha: 0.7,
                          );

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Slidable(
                          key: ValueKey(marca.id),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) => _editMarca(marca),
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Editar',
                              ),
                              SlidableAction(
                                onPressed: (context) => _deleteMarca(marca),
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Excluir',
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(color: backgroundColor),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: ListTile(
                              leading: marca.logo != null
                                  ? CircleAvatar(
                                      backgroundImage: _getImageProvider(
                                        marca.logo!,
                                      ),
                                    )
                                  : const CircleAvatar(
                                      child: Icon(Icons.branding_watermark),
                                    ),
                              title: Text(
                                marca.nome,
                                style: CatalagoColecionadorTheme.titleSmallStyle
                                    .copyWith(
                                      color:
                                          CatalagoColecionadorTheme.whiteColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                    ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (marca.descricao != null)
                                    Text(
                                      marca.descricao!,
                                      style: CatalagoColecionadorTheme
                                          .titleSmallStyle
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: CatalagoColecionadorTheme
                                                .navBarBackkgroundColor,
                                          ),
                                    ),
                                  if (marca.quantidade != null)
                                    Text(
                                      'Quantidade: ${marca.quantidade}',
                                      style: CatalagoColecionadorTheme
                                          .titleSmallStyle
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: CatalagoColecionadorTheme
                                                .navBarBackkgroundColor,
                                          ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para detectar e carregar a imagem corretamente
  ImageProvider _getImageProvider(String imagePath) {
    // Se começa com '/' ou contém '/data/', é um arquivo do filesystem
    if (imagePath.startsWith('/') || imagePath.contains('/data/')) {
      return FileImage(File(imagePath));
    }
    // Senão, trata como asset
    return AssetImage(imagePath);
  }
}
