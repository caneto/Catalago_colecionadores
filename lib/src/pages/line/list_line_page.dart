import 'package:catalago_colecionadores/src/core/database/isar_models/line_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/pages/line/bloc/line_bloc.dart';
import 'package:catalago_colecionadores/src/pages/line/bloc/line_event.dart';
import 'package:catalago_colecionadores/src/pages/line/bloc/line_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ListLinePage extends StatefulWidget {
  const ListLinePage({super.key});

  @override
  State<ListLinePage> createState() => _ListLinePageState();
}

class _ListLinePageState extends State<ListLinePage> {
  late LineBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = LineBloc(IsarService())..add(LoadLines());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _deleteLine(LineCollection line) {
    _bloc.add(DeleteLine(line.id));
  }

  void _editLine(LineCollection line) async {
    await context.push('/add_line_page', extra: line);
    _bloc.add(LoadLines());
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
                        'Linhas',
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
                                  await context.push('/add_line_page');
                                  _bloc.add(LoadLines());
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
                  child: BlocBuilder<LineBloc, LineState>(
                    builder: (context, state) {
                      if (state is LineLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is LineError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      } else if (state is LineLoaded) {
                        final lines = state.lines;
                        if (lines.isEmpty) {
                          return const Center(
                            child: Text(
                              'Nenhuma linha cadastrada',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: lines.length,
                          itemBuilder: (context, index) {
                            final line = lines[index];
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
                                  key: ValueKey(line.id),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) => _editLine(line),
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                        label: 'Editar',
                                      ),
                                      SlidableAction(
                                        onPressed: (context) =>
                                            _deleteLine(line),
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
                                      leading: const CircleAvatar(
                                        child: Icon(Icons.list),
                                      ),
                                      title: Text(
                                        line.linha,
                                        style: CatalagoColecionadorTheme
                                            .titleSmallStyle
                                            .copyWith(
                                              color: CatalagoColecionadorTheme
                                                  .whiteColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22,
                                            ),
                                      ),
                                      subtitle: line.descricao != null
                                          ? Text(
                                              line.descricao!,
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
}
