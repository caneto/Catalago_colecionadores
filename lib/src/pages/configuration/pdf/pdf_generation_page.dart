import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:flutter/material.dart';

import 'widgets/header_section.dart';

class PdfGenerationPage extends StatefulWidget {
  const PdfGenerationPage({super.key});

  @override
  State<PdfGenerationPage> createState() => _PdfGenerationPageState();
}

class _PdfGenerationPageState extends State<PdfGenerationPage> {
  int copies = 1;
  String tipoDados = 'Carro Catalago';

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
                        padding: const EdgeInsets.fromLTRB(
                          20,
                          18,
                          20,
                          16,
                        ), // as per CSS
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
                        child: Stack(
                          children: [
                            // Floating Action Button (Top Right)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: FloatingActionButton(
                                mini: true,
                                backgroundColor:
                                    CatalagoColecionadorTheme.bgInputAccent,
                                onPressed: () {},
                                child: const Icon(
                                  Icons.save_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            // PDF Preview Mockup
                            Center(
                              child: InteractiveViewer(
                                minScale: 0.5,
                                maxScale: 3.0,
                                child: Container(
                                  width:
                                      350, // Approx width relative to A4 aspect ratio
                                  height: 500,
                                  margin: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      // Document Header
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/logo_carros_colecioandor.png',
                                              height: 40,
                                            ),
                                            const SizedBox(height: 5),
                                            const Text(
                                              'Coleção',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Info Box
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              child: SizedBox(
                                                height: 30, // Empty spacer cell
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              height: 30,
                                              color: Colors.black,
                                            ),
                                            const Expanded(
                                              child: Center(
                                                child: Text(
                                                  'Itens encontrados: 4',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 5),

                                      // Table Rows (Mocked)
                                      _buildMockRow(
                                        code: 'MGT00099',
                                        title:
                                            'Pandem Nissan GT-R (R35) Duck Tail ROCAF Malataw Fighter',
                                        subtitle: 'Pandem',
                                        imageColor: Colors.grey[200]!,
                                      ),
                                      _buildMockRow(
                                        code: 'J3247',
                                        title: 'Bone Shaker',
                                        subtitle: '2006 First Editions 6/38',
                                        imageColor: Colors.orange[100]!,
                                      ),
                                      _buildMockRow(
                                        code: 'K7613S',
                                        title: 'Nissan Skyline',
                                        subtitle:
                                            '2007 Super Treasure Hunt series 122/180',
                                        imageColor: Colors.blue[100]!,
                                      ),
                                      _buildMockRow(
                                        code: '97689',
                                        title:
                                            'Porsche 911 Turbo (New for USA)',
                                        subtitle: 'Family Wheels 4/5',
                                        imageColor: Colors.red[100]!,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                              '1/1',
                              style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                                color: CatalagoColecionadorTheme.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
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

  Widget _buildMockRow({
    required String code,
    required String title,
    required String subtitle,
    required Color imageColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      height: 70,
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(color: Colors.black),
          left: BorderSide(color: Colors.black),
          right: BorderSide(color: Colors.black),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    code,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(title, style: const TextStyle(fontSize: 8)),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 8, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Container(width: 1, color: Colors.black),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(4),
              color: imageColor,
              child: const Icon(
                Icons.directions_car,
                size: 30,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
