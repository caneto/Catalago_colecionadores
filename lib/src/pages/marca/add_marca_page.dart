import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/pages/marca/bloc/marca_bloc.dart';
import 'package:catalago_colecionadores/src/pages/marca/bloc/marca_event.dart';
import 'package:catalago_colecionadores/src/pages/marca/bloc/marca_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/database/isar_models/marca_collection.dart';
import '../../core/database/isar_service.dart';
import 'widgets/add_marca_form.dart';

class AddMarcaPage extends StatefulWidget {
  final MarcaCollection? marca;
  const AddMarcaPage({super.key, this.marca});

  @override
  State<AddMarcaPage> createState() => _AddMarcaPageState();
}

class _AddMarcaPageState extends State<AddMarcaPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  String? _logoPath;

  String textAddOption = 'Adicionar Marca';
  String textButtonOption = 'Salvar Marca';

  late MarcaBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MarcaBloc(IsarService());
    if (widget.marca != null) {
      _nameController.text = widget.marca!.nome;
      _descriptionController.text = widget.marca!.descricao ?? '';
      _quantidadeController.text = widget.marca!.quantidade?.toString() ?? '';
      _logoPath = widget.marca!.logo;
      textAddOption = "Editar Marca";
      textButtonOption = "Editar Marca";
    }
  }

  @override
  void dispose() {
    _bloc.close();
    _nameController.dispose();
    _descriptionController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() != true) return;

    final marca = widget.marca ?? MarcaCollection();
    marca
      ..nome = _nameController.text
      ..descricao = _descriptionController.text
      ..quantidade = int.tryParse(_quantidadeController.text)
      ..logo = _logoPath;

    _bloc.add(AddMarca(marca));
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
      child: BlocListener<MarcaBloc, MarcaState>(
        listener: (context, state) {
          if (state is MarcaOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: CatalagoColecionadorTheme.bgInputAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pop(context);
          } else if (state is MarcaError) {
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
                                    child: BlocBuilder<MarcaBloc, MarcaState>(
                                      builder: (context, state) {
                                        if (state is MarcaLoading) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return AddMarcaForm(
                                          formKey: _formKey,
                                          nameController: _nameController,
                                          descriptionController:
                                              _descriptionController,
                                          quantidadeController:
                                              _quantidadeController,
                                          logoPath: _logoPath,
                                          onLogoChanged: (val) =>
                                              setState(() => _logoPath = val),
                                          textButtonOption: textButtonOption,
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
