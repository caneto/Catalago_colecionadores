import 'package:catalago_colecionadores/src/core/global/global_itens.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/miniaturas_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/database/isar_models/category_collection.dart';
import '../../core/database/isar_service.dart';
import 'widget/add_category_form.dart';

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

  final int _selectedNavIndex = 2; // Mantendo o index do Add

  String textAddOption = 'Adicionar Categoria';
  String textButtonOption = 'Salvar Categoria';

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
      _descriptionController.text = widget.category!.description ?? '';
      _imagePath = widget.category!.imagePath;
      textAddOption = "Editar Categoria";
      textButtonOption = "Editar Categoria";
    }
  }

  void _onSave() async {
    if (_formKey.currentState?.validate() != true) return;

    final category = widget.category ?? CategoryCollection();
    category
      ..name = _nameController.text
      ..description = _descriptionController.text
      ..imagePath = _imagePath;

    final isarService = IsarService();
    await isarService.saveCategory(category);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Categoria salva com sucesso!'),
          backgroundColor: CatalagoColecionadorTheme.bgInputAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    }
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
    return Scaffold(
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
                                    color: CatalagoColecionadorTheme.whiteColor,
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
                                child: AddCategoryForm(
                                  formKey: _formKey,
                                  nameController: _nameController,
                                  descriptionController: _descriptionController,
                                  imagePath: _imagePath,
                                  onImageChanged: (val) =>
                                      setState(() => _imagePath = val),
                                  textButtonOption: textButtonOption,
                                  onSave: _onSave,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: MiniaturasNavBar(
                      items: GlobalItens.navItems,
                      selectedIndex: _selectedNavIndex,
                      navHeight: constraints.maxWidth < 600 ? 67 : 80,
                      iconSize: constraints.maxWidth < 600 ? 22 : 27,
                      labelFontSize: constraints.maxWidth < 600 ? 10.6 : 12.2,
                      navItemWidth: constraints.maxWidth < 600 ? 76 : 80,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
