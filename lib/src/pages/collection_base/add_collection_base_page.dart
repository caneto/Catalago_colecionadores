import 'dart:convert';
import 'dart:io';

import 'package:catalago_colecionadores/src/core/database/isar_models/car_base_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/pages/collection_base/bloc/collection_base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'widgets/add_collection_base_form.dart';

class AddCollectionBasePage extends StatefulWidget {
  final CarBaseCollection? item;
  const AddCollectionBasePage({super.key, this.item});

  @override
  State<AddCollectionBasePage> createState() => _AddCollectionBasePageState();
}

class _AddCollectionBasePageState extends State<AddCollectionBasePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeMiniaturaController =
      TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _anoFabricacaoController =
      TextEditingController();
  final TextEditingController _escalaController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _linhaController = TextEditingController();
  final TextEditingController _serieController = TextEditingController();
  final TextEditingController _numeroSerieController = TextEditingController();

  final List<String> _images = [];

  String textAddOption = 'Adicionar Item';
  String textButtonOption = 'Salvar Item';

  late CollectionBaseBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CollectionBaseBloc(IsarService());
    if (widget.item != null) {
      _nomeMiniaturaController.text = widget.item!.nomeMiniatura;
      _categoriaController.text = widget.item!.categoria;
      _marcaController.text = widget.item!.marca;
      _modeloController.text = widget.item!.modelo;
      _linhaController.text = widget.item!.linha;
      _serieController.text = widget.item!.serie ?? '';
      _numeroSerieController.text = widget.item!.numeroNaSerie ?? '';
      _anoFabricacaoController.text =
          widget.item!.anoFabricacao?.toString() ?? '';
      _escalaController.text = widget.item!.escala;
      _notesController.text = widget.item!.notes ?? '';

      if (widget.item!.gallery.isNotEmpty) {
        _images.addAll(widget.item!.gallery.map((e) => e.imageBase64));
      }
      textAddOption = "Editar Item";
      textButtonOption = "Editar Item";
    }
  }

  @override
  void dispose() {
    _bloc.close();
    _nomeMiniaturaController.dispose();
    _categoriaController.dispose();
    _marcaController.dispose();
    _modeloController.dispose();
    _anoFabricacaoController.dispose();
    _escalaController.dispose();
    _notesController.dispose();
    _linhaController.dispose();
    _serieController.dispose();
    _numeroSerieController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (_formKey.currentState?.validate() != true) return;

    final item = widget.item ?? CarBaseCollection();
    item
      ..nomeMiniatura = _nomeMiniaturaController.text
      ..categoria = _categoriaController.text
      ..marca = _marcaController.text
      ..modelo = _modeloController.text
      ..linha = _linhaController.text
      ..serie = _serieController.text
      ..numeroNaSerie = _numeroSerieController.text
      ..anoFabricacao = int.tryParse(_anoFabricacaoController.text)
      ..escala = _escalaController.text
      ..notes = _notesController.text;

    List<String> finalImages = [];
    for (var img in _images) {
      if (img.startsWith('/') && File(img).existsSync()) {
        final bytes = await File(img).readAsBytes();
        finalImages.add(base64Encode(bytes));
      } else {
        finalImages.add(img);
      }
    }

    _bloc.add(AddCollectionBase(item, images: finalImages));
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
      child: BlocListener<CollectionBaseBloc, CollectionBaseState>(
        listener: (context, state) {
          if (state is CollectionBaseOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: CatalagoColecionadorTheme.bgInputAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
            context.pop();
          } else if (state is CollectionBaseError) {
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
                                  onTap: () => context.pop(),
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
                                        context.pop();
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
                                          CollectionBaseBloc,
                                          CollectionBaseState
                                        >(
                                          builder: (context, state) {
                                            if (state
                                                is CollectionBaseLoading) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            return AddCollectionBaseForm(
                                              formKey: _formKey,
                                              nomeMiniaturaController:
                                                  _nomeMiniaturaController,
                                              categoriaController:
                                                  _categoriaController,
                                              marcaController: _marcaController,
                                              modeloController:
                                                  _modeloController,
                                              linhaController: _linhaController,
                                              serieController: _serieController,
                                              numeroSerieController:
                                                  _numeroSerieController,
                                              anoFabricacaoController:
                                                  _anoFabricacaoController,
                                              escalaController:
                                                  _escalaController,
                                              notesController: _notesController,
                                              images: _images,
                                              onImageAdded: (val) => setState(
                                                () => _images.add(val),
                                              ),
                                              navTitle: textButtonOption,
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
