import 'dart:io';

import 'package:catalago_colecionadores/src/core/database/isar_models/category_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/pages/category/add_category_page.dart';
import 'package:catalago_colecionadores/src/pages/category/bloc/category_bloc.dart';
import 'package:catalago_colecionadores/src/pages/category/bloc/category_event.dart';
import 'package:catalago_colecionadores/src/pages/category/bloc/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class ListCategoryPage extends StatefulWidget {
  const ListCategoryPage({super.key});

  @override
  State<ListCategoryPage> createState() => _ListCategoryPageState();
}

class _ListCategoryPageState extends State<ListCategoryPage> {
  late CategoryBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CategoryBloc(IsarService())..add(LoadCategories());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _deleteCategory(CategoryCollection category) {
    _bloc.add(DeleteCategory(category.id));
  }

  void _editCategory(CategoryCollection category) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCategoryPage(category: category),
      ),
    );
    _bloc.add(LoadCategories());
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
                        onTap: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Categorias',
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
                            label: 'Perfil',
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
                                  ).pushNamed('/add_category_page');
                                  _bloc.add(LoadCategories());
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
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CategoryError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      } else if (state is CategoryLoaded) {
                        final categories = state.categories;
                        if (categories.isEmpty) {
                          return const Center(
                            child: Text(
                              'Nenhuma categoria cadastrada',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
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
                                  key: ValueKey(category.id),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) =>
                                            _editCategory(category),
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                        label: 'Editar',
                                      ),
                                      SlidableAction(
                                        onPressed: (context) =>
                                            _deleteCategory(category),
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
                                      leading: category.imagePath != null
                                          ? CircleAvatar(
                                              backgroundImage:
                                                  _getImageProvider(
                                                    category.imagePath!,
                                                  ),
                                            )
                                          : const CircleAvatar(
                                              child: Icon(Icons.category),
                                            ),
                                      title: Text(
                                        category.name,
                                        style: CatalagoColecionadorTheme
                                            .titleSmallStyle
                                            .copyWith(
                                              color: CatalagoColecionadorTheme
                                                  .whiteColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22,
                                            ),
                                      ),
                                      subtitle: category.description != null
                                          ? Text(
                                              category.description!,
                                              style: CatalagoColecionadorTheme
                                                  .titleSmallStyle
                                                  .copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: CatalagoColecionadorTheme
                                                        .navBarBackkgroundColor,
                                                  ),
                                            )
                                          : null,
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
