import 'dart:typed_data';

import 'package:catalago_colecionadores/src/core/database/isar_models/car_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'widgets/header_section.dart';

class PdfGenerationPage extends StatefulWidget {
  const PdfGenerationPage({super.key});

  @override
  State<PdfGenerationPage> createState() => _PdfGenerationPageState();
}

class _PdfGenerationPageState extends State<PdfGenerationPage> {
  int copies = 1;
  String tipoDados = 'Carro Catalago';
  final IsarService _isarService = IsarService();
  List<CarCollection> _cars = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final cars = await _isarService.getAllCars();
    setState(() {
      _cars = cars;
      _isLoading = false;
    });
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: format,
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Relatório de Coleção',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text('Data: ${DateTime.now().toString().split(' ')[0]}'),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              context: context,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.grey300,
              ),
              cellHeight: 30,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                2: pw.Alignment.center,
                3: pw.Alignment.center,
              },
              headers: <String>[
                'Nome Miniatura',
                'Marca',
                'Escala',
                'Ano Fab.',
              ],
              data: _cars.map((car) {
                return [
                  car.nomeMiniatura,
                  car.marca,
                  car.escala,
                  car.anoFabricacao?.toString() ?? '-',
                ];
              }).toList(),
            ),
            pw.Footer(
              margin: const pw.EdgeInsets.only(top: 20),
              title: pw.Text(
                'Total de itens: ${_cars.length}',
                style: const pw.TextStyle(fontSize: 12),
              ),
            ),
          ];
        },
      ),
    );

    return doc.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final sizeOf = MediaQuery.sizeOf(context);

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
                              color: CatalagoColecionadorTheme.blackClaroColor,
                              width: 1,
                            ),
                          ),
                        ),
                        child: HeaderSection(),
                      ),
                      // Header Options
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Tipo de conteudo: ',
                              style: CatalagoColecionadorTheme.titleStyleNormal
                                  .copyWith(
                                    color:
                                        CatalagoColecionadorTheme.yellowColor,
                                    fontSize: 16,
                                  ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              tipoDados,
                              style: const TextStyle(
                                color: CatalagoColecionadorTheme.whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: PdfPreview(
                                  build: (format) => _generatePdf(format),
                                  canDebug: false,
                                  canChangeOrientation: false,
                                  canChangePageFormat: false,
                                  allowPrinting: true,
                                  allowSharing: true,
                                  pdfFileName: 'colecao_carros.pdf',
                                  loadingWidget: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                      ),

                      // Bottom Bar
                      Container(
                        color: CatalagoColecionadorTheme.blackLightGround,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Spacer(),
                            Text(
                              '${_cars.length} itens',
                              style: CatalagoColecionadorTheme.titleStyleNormal
                                  .copyWith(
                                    color: CatalagoColecionadorTheme.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const Spacer(),
                            // Keeping the check icon as purely visual since PdfPreview handles actions
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: CatalagoColecionadorTheme.bgInputAccent,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          ],
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
    );
  }
}
