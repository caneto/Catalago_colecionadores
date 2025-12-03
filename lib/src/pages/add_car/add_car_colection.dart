import 'package:catalago_colecionadores/src/core/global/global_itens.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/miniaturas_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/database/isar_models/car_collection.dart';
import '../../core/database/isar_service.dart';
import 'widget/add_car_colection_form.dart';

class AddCarColection extends StatefulWidget {
  const AddCarColection({super.key});

  @override
  State<AddCarColection> createState() => _AddCarColectionState();
}

class _AddCarColectionState extends State<AddCarColection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeMiniaturaController =
      TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _anoFabricacaoController =
      TextEditingController();
  final TextEditingController _escalaController = TextEditingController();
  final TextEditingController _dataAquizicaoController =
      TextEditingController();
  final TextEditingController _precoPagoController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? _condition;
  String? _collectionCondition;
  final List<String> _images = [];

  final int _selectedNavIndex = 2; // Seta o select para o "Add"

  void _onSave() async {
    if (_formKey.currentState?.validate() != true) return;

    final car = CarCollection()
      ..nomeMiniatura = _nomeMiniaturaController.text
      ..categoria = _categoriaController.text
      ..marca = _marcaController.text
      ..modelo = _modeloController.text
      ..anoFabricacao = int.tryParse(_anoFabricacaoController.text)
      ..escala = _escalaController.text
      ..dataAquizicao =
          DateTime.tryParse(
            _dataAquizicaoController.text,
          ) // Assuming format is parsable or handled
      ..precoPago = double.tryParse(
        _precoPagoController.text.replaceAll(',', '.'),
      )
      ..notes = _notesController.text
      ..condition = _condition
      ..collectionCondition = _collectionCondition
      ..images = _images;

    final isarService = IsarService();
    await isarService.saveCar(car);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thumbnail saved!'),
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

  // Gallery image list

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
                        padding: const EdgeInsets.fromLTRB(
                          20,
                          18,
                          20,
                          16,
                        ), // as per CSS
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: CatalagoColecionadorTheme.barColor,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Semantics(
                              header: true,
                              child: Text(
                                'Adicionar Miniatura',
                                style: CatalagoColecionadorTheme.titleStyle
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      letterSpacing: -0.01,
                                      color:
                                          CatalagoColecionadorTheme.whiteColor,
                                    ),
                              ),
                            ),
                            Semantics(
                              label: 'Perfil',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),

                                child: InkWell(
                                  child: SvgPicture.asset(
                                    'assets/images/x.svg', // Path to your SVG asset
                                    height: 32,
                                    width: 32,
                                    colorFilter: ColorFilter.mode(
                                      CatalagoColecionadorTheme
                                          .navBarBackkgroundColor,
                                      BlendMode.srcIn,
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
                      // Header (não scrollável)
                      SizedBox(height: 16),
                      // Form Section (scrollável)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 60,
                              ), // espaço para navbar
                              constraints: BoxConstraints(
                                maxWidth: maxContentWidth,
                              ),
                              padding: EdgeInsets.only(top: 0),
                              child: Padding(
                                padding: horizontalPadding,
                                child: AddCarColectionForm(
                                  formKey: _formKey,
                                  nomeMiniaturaController:
                                      _nomeMiniaturaController,
                                  categoriaController: _categoriaController,
                                  modeloController: _modeloController,
                                  marcaController: _marcaController,
                                  escalaController: _escalaController,
                                  anoFabricacaoController:
                                      _anoFabricacaoController,
                                  dataAquizicaoController:
                                      _dataAquizicaoController,
                                  precoPagoController: _precoPagoController,
                                  notesController: _notesController,
                                  condition: _condition,
                                  onConditionChanged: (val) =>
                                      setState(() => _condition = val),
                                  collectionCondition: _collectionCondition,
                                  onCollectionConditionChanged: (val) =>
                                      setState(
                                        () => _collectionCondition = val,
                                      ),
                                  images: _images,
                                  onImageAdded: (val) =>
                                      setState(() => _images.add(val)),
                                  onSave: _onSave,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Footer Navigation (sticky)
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
