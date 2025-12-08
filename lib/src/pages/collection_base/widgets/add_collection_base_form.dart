import 'package:catalago_colecionadores/src/core/database/isar_models/category_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_models/marca_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/widgets/image_gallery.dart';
import '../../add_car/widget/form_group.dart';

class AddCollectionBaseForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeMiniaturaController;
  final TextEditingController categoriaController;
  final TextEditingController marcaController;
  final TextEditingController modeloController;
  final TextEditingController anoFabricacaoController;
  final TextEditingController escalaController;
  final TextEditingController notesController;
  final List<String> images;
  final VoidCallback onSave;
  final ValueChanged<String> onImageAdded;
  final String navTitle;

  const AddCollectionBaseForm({
    super.key,
    required this.formKey,
    required this.nomeMiniaturaController,
    required this.categoriaController,
    required this.marcaController,
    required this.modeloController,
    required this.anoFabricacaoController,
    required this.escalaController,
    required this.notesController,
    required this.images,
    required this.onSave,
    required this.onImageAdded,
    this.navTitle = 'Salvar Item',
  });

  @override
  State<AddCollectionBaseForm> createState() => _AddCollectionBaseFormState();
}

class _AddCollectionBaseFormState extends State<AddCollectionBaseForm> {
  final IsarService service = IsarService();
  List<CategoryCollection> categories = [];
  List<MarcaCollection> marcas = [];
  String? _selectedCategory;
  String? _selectedMarca;
  int? _selectedImageIndex;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _deleteSelectedImage() {
    if (_selectedImageIndex != null) {
      setState(() {
        widget.images.removeAt(_selectedImageIndex!);
        _selectedImageIndex = null;
      });
    }
  }

  Future<void> _loadData() async {
    final cats = await service.getAllCategories();
    final brands = await service.getAllMarcas();
    setState(() {
      categories = cats;
      marcas = brands;
      if (widget.categoriaController.text.isNotEmpty) {
        if (categories.any((c) => c.name == widget.categoriaController.text)) {
          _selectedCategory = widget.categoriaController.text;
        }
      }
      if (widget.marcaController.text.isNotEmpty) {
        if (marcas.any((m) => m.nome == widget.marcaController.text)) {
          _selectedMarca = widget.marcaController.text;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.all(12),
      constraints: BoxConstraints(maxWidth: sizeOf.width * 0.99),
      decoration: const BoxDecoration(
        color: CatalagoColecionadorTheme.blackLightGround,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () async {
                if (widget.images.length >= 5) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Limite de imagens atingida'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                final filePath = await context.push('/add_car/scan');
                if (filePath != null && filePath != '') {
                  widget.onImageAdded(filePath as String);
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 25),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.lightBlue.shade500,
                    width: 0.5,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(R.ASSETS_IMAGES_FOLDER_PNG),
                    SizedBox(height: 12),
                    Text(
                      "Adicionar imagem",
                      style: CatalagoColecionadorTheme.subTitleSmallStyle
                          .copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Quantidade de Imagens: ${widget.images.length}",
              style: CatalagoColecionadorTheme.subTitleSmallStyle.copyWith(
                color: CatalagoColecionadorTheme.whiteColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 12),
            ImageGallery(
              images: widget.images,
              selectedIndex: _selectedImageIndex,
              onImageSelected: (index) {
                setState(() {
                  _selectedImageIndex = index;
                });
              },
            ),
            if (_selectedImageIndex != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _deleteSelectedImage,
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text(
                      'Excluir Imagem',
                      style: TextStyle(
                        color: CatalagoColecionadorTheme.yellowColor,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 8),
            Text(
              "Detalhes Principais",
              style: CatalagoColecionadorTheme.subTitleSmallStyle.copyWith(
                color: CatalagoColecionadorTheme.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            FormGroup(
              label: 'Nome da Miniatura',
              colorLabel: CatalagoColecionadorTheme.labelColor,
              child: TextFormField(
                controller: widget.nomeMiniaturaController,
                style: CatalagoColecionadorTheme.textBold.copyWith(
                  color: CatalagoColecionadorTheme.blackClaroColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                decoration: CatalagoColecionadorTheme.inputDecorationAddCard(
                  hintText: 'Exemplo Ford Mustang',
                  colorSide: CatalagoColecionadorTheme.textMainAccent,
                ),
                validator: Validatorless.required('Nome da Miniatura exigido'),
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FormGroup(
                    label: 'Categoria',
                    colorLabel: CatalagoColecionadorTheme.labelColor,
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedCategory,
                      items: categories.map((CategoryCollection category) {
                        return DropdownMenuItem<String>(
                          value: category.name,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                          widget.categoriaController.text = newValue ?? '';
                        });
                      },
                      style: CatalagoColecionadorTheme.textBold.copyWith(
                        color: CatalagoColecionadorTheme.blackClaroColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration:
                          CatalagoColecionadorTheme.inputDecorationAddCard(
                            hintText: 'Selecione',
                            colorSide: CatalagoColecionadorTheme.textMainAccent,
                          ),
                      validator: Validatorless.required('Categoria exigida'),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: FormGroup(
                    label: 'Marca',
                    colorLabel: CatalagoColecionadorTheme.labelColor,
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedMarca,
                      items: marcas.map((MarcaCollection marca) {
                        return DropdownMenuItem<String>(
                          value: marca.nome,
                          child: Text(marca.nome),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedMarca = newValue;
                          widget.marcaController.text = newValue ?? '';
                        });
                      },
                      style: CatalagoColecionadorTheme.textBold.copyWith(
                        color: CatalagoColecionadorTheme.blackClaroColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration:
                          CatalagoColecionadorTheme.inputDecorationAddCard(
                            hintText: 'Selecione',
                            colorSide: CatalagoColecionadorTheme.textMainAccent,
                          ),
                      validator: Validatorless.required('Marca exigida'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FormGroup(
                    label: 'Modelo',
                    colorLabel: CatalagoColecionadorTheme.labelColor,
                    child: TextFormField(
                      controller: widget.modeloController,
                      style: CatalagoColecionadorTheme.textBold.copyWith(
                        color: CatalagoColecionadorTheme.blackClaroColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration:
                          CatalagoColecionadorTheme.inputDecorationAddCard(
                            hintText: 'Ex Ford Mustang',
                            colorSide: CatalagoColecionadorTheme.textMainAccent,
                          ),
                      validator: Validatorless.required('Modelo exigida'),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: FormGroup(
                    label: 'Ano de Fabricação',
                    colorLabel: CatalagoColecionadorTheme.labelColor,
                    child: TextFormField(
                      controller: widget.anoFabricacaoController,
                      style: CatalagoColecionadorTheme.textBold.copyWith(
                        color: CatalagoColecionadorTheme.blackClaroColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration:
                          CatalagoColecionadorTheme.inputDecorationAddCard(
                            hintText: 'Exemplo 2008',
                            colorSide: CatalagoColecionadorTheme.textMainAccent,
                          ),
                      keyboardType: TextInputType.number,
                      validator: Validatorless.required('Ano exigida'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            FormGroup(
              label: 'Escala',
              colorLabel: CatalagoColecionadorTheme.labelColor,
              child: TextFormField(
                controller: widget.escalaController,
                style: CatalagoColecionadorTheme.textBold.copyWith(
                  color: CatalagoColecionadorTheme.blackClaroColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                decoration: CatalagoColecionadorTheme.inputDecorationAddCard(
                  hintText: 'Exemplo 1:64',
                  colorSide: CatalagoColecionadorTheme.textMainAccent,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9:]')),
                  LengthLimitingTextInputFormatter(5),
                ],
                validator: Validatorless.multiple([
                  Validatorless.required('Escala obrigatoria'),
                  Validatorless.regex(
                    RegExp(r'^\d:\d{1,3}$'),
                    'Formato inválido ex: 1:18',
                  ),
                ]),
              ),
            ),
            SizedBox(height: 20),
            FormGroup(
              label: 'Notes',
              colorLabel: CatalagoColecionadorTheme.labelColor,
              child: TextFormField(
                controller: widget.notesController,
                minLines: 2,
                maxLines: 5,
                style: CatalagoColecionadorTheme.textBold.copyWith(
                  color: CatalagoColecionadorTheme.blackClaroColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                decoration: CatalagoColecionadorTheme.inputDecorationAddCard(
                  hintText: 'Escreva as anotas caso precise...',
                  isTextArea: true,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            CatalagoColecionadorTheme.bgInputAccent,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        shadowColor: CatalagoColecionadorTheme.blueColor
                            .withAlpha((0.13 * 255).round()),
                        textStyle: CatalagoColecionadorTheme.textBold.copyWith(
                          color: CatalagoColecionadorTheme.textDescriptColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: widget.onSave,
                      child: Text(widget.navTitle),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
