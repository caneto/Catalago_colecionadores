import 'dart:io';

import 'package:catalago_colecionadores/src/core/database/isar_models/marca_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/pages/marca/bloc/marca_bloc.dart';
import 'package:catalago_colecionadores/src/pages/marca/bloc/marca_event.dart';
import 'package:catalago_colecionadores/src/pages/marca/bloc/marca_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ListMarcaPage extends StatefulWidget {
  const ListMarcaPage({super.key});

  @override
  State<ListMarcaPage> createState() => _ListMarcaPageState();
}

class _ListMarcaPageState extends State<ListMarcaPage> {
  late MarcaBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MarcaBloc(IsarService())..add(LoadMarcas());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _deleteMarca(MarcaCollection marca) {
    _bloc.add(DeleteMarca(marca.id));
  }

  void _editMarca(MarcaCollection marca) async {
    await context.push('/add_marca_page', extra: marca);
    _bloc.add(LoadMarcas());
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
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
                        onTap: () => context.pop(),
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
                                  await context.push('/add_marca_page');
                                  _bloc.add(LoadMarcas());
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
                  child: BlocBuilder<MarcaBloc, MarcaState>(
                    builder: (context, state) {
                      if (state is MarcaLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is MarcaError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      } else if (state is MarcaLoaded) {
                        final marcas = state.marcas;
                        if (marcas.isEmpty) {
                          return const Center(
                            child: Text(
                              'Nenhuma marca cadastrada',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: marcas.length,
                          itemBuilder: (context, index) {
                            final marca = marcas[index];
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
                                        onPressed: (context) =>
                                            _editMarca(marca),
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                        label: 'Editar',
                                      ),
                                      SlidableAction(
                                        onPressed: (context) =>
                                            _deleteMarca(marca),
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Excluir',
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    child: ListTile(
                                      leading: marca.logo != null
                                          ? CircleAvatar(
                                              backgroundImage:
                                                  _getImageProvider(
                                                    marca.logo!,
                                                  ),
                                            )
                                          : const CircleAvatar(
                                              child: Icon(
                                                Icons.branding_watermark,
                                              ),
                                            ),
                                      title: Text(
                                        marca.nome,
                                        style: CatalagoColecionadorTheme
                                            .titleSmallStyle
                                            .copyWith(
                                              color: CatalagoColecionadorTheme
                                                  .whiteColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22,
                                            ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
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
