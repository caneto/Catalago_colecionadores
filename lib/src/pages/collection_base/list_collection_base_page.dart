import 'dart:convert';

import 'package:catalago_colecionadores/src/core/database/isar_models/car_base_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/pages/collection_base/bloc/collection_base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ListCollectionBasePage extends StatefulWidget {
  const ListCollectionBasePage({super.key});

  @override
  State<ListCollectionBasePage> createState() => _ListCollectionBasePageState();
}

class _ListCollectionBasePageState extends State<ListCollectionBasePage> {
  late CollectionBaseBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CollectionBaseBloc(IsarService())..add(LoadCollectionBase());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _deleteItem(CarBaseCollection item) {
    _bloc.add(DeleteCollectionBase(item.id));
  }

  void _editItem(CarBaseCollection item) async {
    await context.push('/add_collection_base', extra: item);
    _bloc.add(LoadCollectionBase());
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
                        'Base de Colecionáveis',
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
                                  await context.push('/add_collection_base');
                                  _bloc.add(LoadCollectionBase());
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
                  child: BlocBuilder<CollectionBaseBloc, CollectionBaseState>(
                    builder: (context, state) {
                      if (state is CollectionBaseLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CollectionBaseError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      } else if (state is CollectionBaseLoaded) {
                        final list = state.collectionBaseList;
                        if (list.isEmpty) {
                          return const Center(
                            child: Text(
                              'Nenhum item cadastrado',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final item = list[index];
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
                                  key: ValueKey(item.id),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) => _editItem(item),
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                        label: 'Editar',
                                      ),
                                      SlidableAction(
                                        onPressed: (context) =>
                                            _deleteItem(item),
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
                                      leading: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: item.gallery.isNotEmpty
                                              ? Image.memory(
                                                  base64Decode(
                                                    item
                                                        .gallery
                                                        .first
                                                        .imageBase64,
                                                  ),
                                                  fit: BoxFit.cover,
                                                )
                                              : Container(
                                                  color: Colors.grey[400],
                                                  child: const Icon(
                                                    Icons.directions_car,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      title: Text(
                                        item.nomeMiniatura,
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
                                          Text(
                                            '${item.marca} - ${item.modelo}',
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
}
