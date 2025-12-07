import 'package:catalago_colecionadores/src/core/database/isar_models/serie_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/pages/serie/bloc/serie_bloc.dart';
import 'package:catalago_colecionadores/src/pages/serie/bloc/serie_event.dart';
import 'package:catalago_colecionadores/src/pages/serie/bloc/serie_state.dart';
import 'package:catalago_colecionadores/src/pages/serie/widgets/add_serie_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AddSeriePage extends StatefulWidget {
  final SerieCollection? serie;
  const AddSeriePage({super.key, this.serie});

  @override
  State<AddSeriePage> createState() => _AddSeriePageState();
}

class _AddSeriePageState extends State<AddSeriePage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _numeroController = TextEditingController();
  final _descricaoController = TextEditingController();
  String? _selectedMarca;

  String textAddOption = 'Adicionar Serie';
  String textButtonOption = 'Salvar Serie';
  late SerieBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SerieBloc(IsarService());
    if (widget.serie != null) {
      _nomeController.text = widget.serie!.nome;
      _numeroController.text = widget.serie!.numero;
      _descricaoController.text = widget.serie!.descricao ?? '';
      _selectedMarca = widget.serie!.marca;
      textAddOption = "Editar Serie";
      textButtonOption = "Editar Serie";
    }
  }

  @override
  void dispose() {
    _bloc.close();
    _nomeController.dispose();
    _numeroController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      final serie = widget.serie ?? SerieCollection();
      serie.nome = _nomeController.text;
      serie.numero = _numeroController.text;
      serie.marca = _selectedMarca!;
      serie.descricao = _descricaoController.text;

      _bloc.add(AddSerie(serie));
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

    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<SerieBloc, SerieState>(
        listener: (context, state) {
          if (state is SerieOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: CatalagoColecionadorTheme.bgInputAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
            context.pop();
          } else if (state is SerieError) {
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
                                    child: BlocBuilder<SerieBloc, SerieState>(
                                      builder: (context, state) {
                                        if (state is SerieLoading) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return AddSerieForm(
                                          formKey: _formKey,
                                          nomeController: _nomeController,
                                          numeroController: _numeroController,
                                          descricaoController:
                                              _descricaoController,
                                          onSave: _save,
                                          textButtonOption: textButtonOption,
                                          initialMarca: _selectedMarca,
                                          onMarcaChanged: (val) {
                                            _selectedMarca = val;
                                          },
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
