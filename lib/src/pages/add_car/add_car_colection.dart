import 'package:catalago_colecionadores/src/core/global/global_itens.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/miniaturas_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/database/isar_models/car_collection.dart';
import '../../core/database/isar_service.dart';
import 'widget/add_car_colection_form.dart';

class AddCarColection extends StatefulWidget {
  final int? id;
  const AddCarColection({super.key, this.id});

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
  final TextEditingController _serieController = TextEditingController();
  final TextEditingController _numeroNaSerieController =
      TextEditingController();
  final TextEditingController _escalaController = TextEditingController();
  final TextEditingController _dataAquizicaoController =
      TextEditingController();
  final TextEditingController _precoPagoController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? _condition;
  String? _collectionCondition;
  final List<String> _images = [];

  int? _carId;

  final int _selectedNavIndex = 2; // Seta o select para o "Add"

  @override
  void initState() {
    super.initState();
    _processArguments();
  }

  void _processArguments() {
    // Ideally we check if extra is int (edit) or Map (duplicate)
    // But widget.id is typed as int?.
    // The previous code used `extra: _car!.id` which means `widget.id` was receiving that int?
    // Wait, `AddCarColection` constructor takes `this.id`.
    // In `miniatura_details`, `context.push('/add_car', extra: ...)`
    // The router definition likely maps `extra` to `id` if it's an int, but if I pass a map, I need to check how the router handles it.
    // Assuming I need to modify the router or `AddCarColection` to accept the map.
    // However, looking at the file `AddCarColection`, it takes `final int? id`.
    // I should probably check how `go_router` is set up.
    // But for now, let's assume I can get the extra object via `GoRouterState` or similar if I changed the route.
    // OR, I can just modify `AddCarColection` to handle the logic.
    // Let's rely on `ModalRoute.of(context)!.settings.arguments` if `widget.id` is null or isn't sufficient,
    // BUT `widget.id` is passed from the router builder.
    // Let's look at `initState`.

    // Actually, I can't easily see the router config.
    // If I change the push to pass a Map, the `id` param in `AddCarColection` might be null or invalid if the router expects an int.
    // Let's assumes I can access the extra data.

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final extra = GoRouterState.of(context).extra;
      if (extra is int) {
        _carId = extra;
        _loadCarData(_carId!);
      } else if (extra is Map && extra['action'] == 'duplicate') {
        _loadCarDataForDuplication(extra['id']);
      } else if (widget.id != null) {
        _carId = widget.id;
        _loadCarData(_carId!);
      }
    });
  }

  Future<void> _loadCarData(int id) async {
    final isarService = IsarService();
    final car = await isarService.getCarById(id);
    if (car != null) {
      setState(() {
        _nomeMiniaturaController.text = car.nomeMiniatura;
        _serieController.text = car.serie ?? '';
        _numeroNaSerieController.text = car.numeroNaSerie ?? '';
        _categoriaController.text = car.categoria;
        _marcaController.text = car.marca;
        _modeloController.text = car.modelo;
        _anoFabricacaoController.text = car.anoFabricacao?.toString() ?? '';
        _escalaController.text = car.escala;
        _dataAquizicaoController.text = car.dataAquizicao != null
            ? '${car.dataAquizicao!.day.toString().padLeft(2, '0')}/${car.dataAquizicao!.month.toString().padLeft(2, '0')}/${car.dataAquizicao!.year}'
            : '';
        _precoPagoController.text =
            car.precoPago?.toStringAsFixed(2).replaceAll('.', ',') ?? '';
        _notesController.text = car.notes ?? '';
        _condition = car.condition;
        _collectionCondition = car.collectionCondition;
        if (car.images != null) {
          _images.addAll(car.images!);
        } else if (car.imagePath != null) {
          _images.add(car.imagePath!);
        }
        // _numeroCopiasController.text removed
      });
    }
  }

  Future<void> _loadCarDataForDuplication(int originalId) async {
    final isarService = IsarService();
    final car = await isarService.getCarById(originalId);
    if (car != null) {
      setState(() {
        _nomeMiniaturaController.text = car.nomeMiniatura;
        _serieController.text = car.serie ?? '';
        _numeroNaSerieController.text = car.numeroNaSerie ?? '';
        _categoriaController.text = car.categoria;
        _marcaController.text = car.marca;
        _modeloController.text = car.modelo;
        _anoFabricacaoController.text = car.anoFabricacao?.toString() ?? '';
        _escalaController.text = car.escala;
        // Fields to EXCLUDE/RESET:
        // images, condition, collectionCondition, dataAquizicao, precoPago
        _notesController.text = car.notes ?? '';

        // Ensure it's treated as a new record
        _carId = null;
      });
    }
  }

  void _onSave() async {
    if (_formKey.currentState?.validate() != true) return;

    FocusScope.of(context).unfocus();

    DateTime? dataAquizicao;
    if (_dataAquizicaoController.text.isNotEmpty) {
      final parts = _dataAquizicaoController.text.split('/');
      if (parts.length == 3) {
        dataAquizicao = DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
      }
    }

    final car = CarCollection()
      ..nomeMiniatura = _nomeMiniaturaController.text
      ..categoria = _categoriaController.text
      ..marca = _marcaController.text
      ..serie = _serieController.text
      ..numeroNaSerie = _numeroNaSerieController.text
      ..modelo = _modeloController.text
      ..anoFabricacao = int.tryParse(_anoFabricacaoController.text)
      ..escala = _escalaController.text
      ..dataAquizicao = dataAquizicao
      ..precoPago = double.tryParse(
        _precoPagoController.text.replaceAll(',', '.'),
      )
      ..notes = _notesController.text
      ..condition = _condition
      ..collectionCondition = _collectionCondition
      ..images = _images;
    // ..numeroCopias removed

    if (_carId != null) {
      car.id = _carId!;
    }

    final isarService = IsarService();
    await isarService.saveCar(car);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item gravado com Sucesso!'),
          backgroundColor: CatalagoColecionadorTheme.bgInputAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      context.pop();
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

    final double maxContentWidth = 420.0;
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
                                _carId != null
                                    ? 'Editar Miniatura'
                                    : 'Adicionar Miniatura',
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
                                    if (context.canPop()) {
                                      context.pop();
                                    } else {
                                      context.go('/home');
                                    }
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
                                  serieController: _serieController,
                                  numeroNaSerieController:
                                      _numeroNaSerieController,
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
