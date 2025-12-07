import 'package:catalago_colecionadores/src/core/database/isar_models/serie_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/pages/serie/bloc/serie_bloc.dart';
import 'package:catalago_colecionadores/src/pages/serie/bloc/serie_event.dart';
import 'package:catalago_colecionadores/src/pages/serie/bloc/serie_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ListSeriePage extends StatefulWidget {
  const ListSeriePage({super.key});

  @override
  State<ListSeriePage> createState() => _ListSeriePageState();
}

class _ListSeriePageState extends State<ListSeriePage> {
  late SerieBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SerieBloc(IsarService())..add(LoadSeries());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _deleteSerie(SerieCollection serie) {
    _bloc.add(DeleteSerie(serie.id));
  }

  void _editSerie(SerieCollection serie) async {
    await context.push('/add_serie_page', extra: serie);
    _bloc.add(LoadSeries());
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
                        'Series',
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
                                  await context.push('/add_serie_page');
                                  _bloc.add(LoadSeries());
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
                  child: BlocBuilder<SerieBloc, SerieState>(
                    builder: (context, state) {
                      if (state is SerieLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SerieError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      } else if (state is SerieLoaded) {
                        final series = state.series;
                        if (series.isEmpty) {
                          return const Center(
                            child: Text(
                              'Nenhuma serie cadastrada',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: series.length,
                          itemBuilder: (context, index) {
                            final serie = series[index];
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
                                  key: ValueKey(serie.id),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) =>
                                            _editSerie(serie),
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                        label: 'Editar',
                                      ),
                                      SlidableAction(
                                        onPressed: (context) =>
                                            _deleteSerie(serie),
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
                                      title: Text(
                                        serie.nome,
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
                                            "Marca: ${serie.marca} - Nº: ${serie.numero}",
                                            style: CatalagoColecionadorTheme
                                                .titleSmallStyle
                                                .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: CatalagoColecionadorTheme
                                                      .navBarBackkgroundColor,
                                                ),
                                          ),
                                          if (serie.descricao != null)
                                            Text(
                                              serie.descricao!,
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
