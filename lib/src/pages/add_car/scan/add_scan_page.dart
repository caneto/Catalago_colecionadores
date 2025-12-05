import 'package:camera/camera.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/app_default_especial_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class AddScanPage extends StatefulWidget {
  const AddScanPage({super.key});

  @override
  State<AddScanPage> createState() => _AddScanPageState();
}

class _AddScanPageState extends State<AddScanPage> {
  late CameraController cameraController;
  late XFile? imageFile;
  String? foto;

  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Solicitar permissão de câmera
    final status = await Permission.camera.request();

    if (!status.isGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permissão de câmera negada')),
        );
      }
      return;
    }

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nenhuma câmera encontrada')),
          );
        }
        return;
      }

      cameraController = CameraController(cameras[0], ResolutionPreset.high);

      await cameraController.initialize();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      if (e is CameraException) {
        debugPrint('Erro da câmera: ${e.code}: ${e.description}');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao inicializar câmera: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(32),
            margin: const EdgeInsets.only(top: 48),
            constraints: BoxConstraints(maxWidth: sizeOf.width * .85),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: CatalagoColecionadorTheme.blueColor),
            ),
            child: Column(
              children: [
                // Mostrar câmera ou loading
                if (!_isCameraInitialized)
                  const Center(child: CircularProgressIndicator.adaptive())
                else if (cameraController.value.isInitialized)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: sizeOf.width * .65,
                      height: sizeOf.width * .65,
                      child: CameraPreview(
                        cameraController,
                        child: DottedBorder(
                          options: RoundedRectDottedBorderOptions(
                            dashPattern: const [1, 10, 1, 3],
                            strokeWidth: 4,
                            padding: const EdgeInsets.all(16),
                            radius: const Radius.circular(16),
                            color: CatalagoColecionadorTheme.blueFaceBook,
                            strokeCap: StrokeCap.square,
                          ),
                          child: const SizedBox.expand(),
                        ),
                      ),
                    ),
                  )
                else
                  const Center(child: Text('Erro ao carregar câmera')),
                const SizedBox(height: 30),
                AppDefaultEspecialButton(
                  sizeBoxOn: true,
                  width: sizeOf.width * .8,
                  height: 48,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CatalagoColecionadorTheme.blueColor,
                    fixedSize: const Size.fromHeight(48),
                  ),
                  onPressed: _isCameraInitialized
                      ? () async {
                          try {
                            imageFile = await cameraController.takePicture();
                            setState(() {
                              foto = imageFile?.path;
                            });
                            if (mounted) {
                              // ignore: use_build_context_synchronously
                              context.pop(foto);
                            }
                          } catch (e) {
                            if (mounted) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Erro ao tirar foto: $e'),
                                ),
                              );
                            }
                          }
                        }
                      : null,
                  label: 'TIRAR FOTO',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
