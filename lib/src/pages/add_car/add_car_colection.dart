import 'package:catalago_colecionadores/src/core/global/global_itens.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/miniaturas_nav_bar.dart';
import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'widget/add_car_colection_form.dart';

// Colors (adapted from CSS variables)
//const Color _bgMain = Color(0xFF211212);
//const Color _bgForm = Color(0xFF331A1C);
//const Color _bgInput = Color(0xFF472426);
//const Color _textPlaceholder = Color(0xFFC99194);
//const Color _footerBg = Color(0xFF331A1C);

class AddCarColection extends StatefulWidget {
  const AddCarColection({super.key});

  @override
  State<AddCarColection> createState() => _AddCarColectionState();
}

class _AddCarColectionState extends State<AddCarColection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeMiniaturaController =
      TextEditingController();
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
  String? _collectionCondition; // <-- Nova variável

  final int _selectedNavIndex = 2; // Seta o select para o "Add"

  void _onSave() {
    if (_formKey.currentState?.validate() != true) return;
    // Saving logic here...
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thumbnail saved!'),
        backgroundColor: CatalagoColecionadorTheme.bgInputAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
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

    //final brightness = Theme.of(context).brightness;
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
                                      BlendMode.srcIn),
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
                      Padding(
                        padding: EdgeInsets.only(top: 36, bottom: 16),
                        child: Center(
                          child: Container(
                            width: maxContentWidth,
                            constraints: BoxConstraints(
                              maxWidth: constraints.maxWidth,
                            ),
                            padding: horizontalPadding,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          color: CatalagoColecionadorTheme
                                              .blackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Adicionar Miniatura  ',
                                            style: CatalagoColecionadorTheme
                                                .titleStyleNormal
                                                .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  height: 1.3,
                                                  letterSpacing: -0.2,
                                                ),
                                          ),
                                          TextSpan(
                                            text: 'Cancelar',
                                            style: const TextStyle(
                                              color: CatalagoColecionadorTheme
                                                  .orangeColor,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
