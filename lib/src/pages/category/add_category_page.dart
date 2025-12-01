import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/pages/category/bloc/category_bloc.dart';
import 'package:catalago_colecionadores/src/pages/category/bloc/category_event.dart';
import 'package:catalago_colecionadores/src/pages/category/bloc/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/database/isar_models/category_collection.dart';
import '../../core/database/isar_service.dart';
import 'widgets/add_category_form.dart';

class AddCategoryPage extends StatefulWidget {
  final CategoryCollection? category;
  const AddCategoryPage({super.key, this.category});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _imagePath;

  String textAddOption = 'Adicionar Categoria';
  String textButtonOption = 'Salvar Categoria';

  late CategoryBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CategoryBloc(IsarService());
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
      _descriptionController.text = widget.category!.description ?? '';
      _imagePath = widget.category!.imagePath;
      textAddOption = "Editar Categoria";
      textButtonOption = "Editar Categoria";
    }
  }

  @override
  void dispose() {
    _bloc.close();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() != true) return;

    final category = widget.category ?? CategoryCollection();
    category
      ..name = _nameController.text
      ..description = _descriptionController.text
      ..imagePath = _imagePath;

    _bloc.add(AddCategory(category));
  }

  EdgeInsets _mainHorizontalPadding(BuildContext context, BoxConstraints c) {
    final w = c.maxWidth;
    if (w <= 370) return EdgeInsets.zero;
    if (w <= 390) return EdgeInsets.symmetric(horizontal: w * .03);
    if (w <= 480) return const EdgeInsets.symmetric(horizontal: 10);
    return EdgeInsets.zero;
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    final double maxContentWidth = 390.0;
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: CatalagoColecionadorTheme.bgInputAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pop(context);
          } else if (state is CategoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final horizontalPadding = _mainHorizontalPadding(
                  context,
                  constraints,
                );
                return Container(
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
                                  textAddOption,
                                  style: CatalagoColecionadorTheme.titleStyle
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        letterSpacing: -0.01,
                                        color: CatalagoColecionadorTheme
                                            .whiteColor,
                                      ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentGeometry.centerRight,
                                    child: InkWell(
                                      child: SvgPicture.asset(
                                        'assets/images/x.svg',
                                        height: 32,
                                        width: 32,
                                        colorFilter: ColorFilter.mode(
                                          CatalagoColecionadorTheme.whiteColor,
                                          BlendMode.srcATop,
                                        ),
                                        semanticsLabel: 'X',
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 60),
                                  constraints: BoxConstraints(
                                    maxWidth: maxContentWidth,
                                  ),
                                  padding: EdgeInsets.only(top: 0),
                                  child: Padding(
                                    padding: horizontalPadding,
                                    child:
                                        BlocBuilder<
                                          CategoryBloc,
                                          CategoryState
                                        >(
                                          builder: (context, state) {
                                            if (state is CategoryLoading) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            return AddCategoryForm(
                                              formKey: _formKey,
                                              nameController: _nameController,
                                              descriptionController:
                                                  _descriptionController,
                                              imagePath: _imagePath,
                                              onImageChanged: (val) => setState(
                                                () => _imagePath = val,
                                              ),
                                              textButtonOption:
                                                  textButtonOption,
                                              onSave: _onSave,
                                            );
                                          },
                                        ),
                                  ),
                                ),
                              ),
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
        ),
      ),
    );
  }
}
