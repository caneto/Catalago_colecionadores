import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/image_gallery.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../add_car/widget/form_group.dart';

class AddCategoryForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final List<String> images;
  final ValueChanged<String>? onImageAdded;
  final VoidCallback onSave;
  final String textButtonOption;

  const AddCategoryForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
    required this.images,
    this.onImageAdded,
    required this.onSave,
    required this.textButtonOption,
  });

  @override
  State<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  int? _selectedImageIndex;

  void _deleteSelectedImage() {
    if (_selectedImageIndex != null) {
      if (widget.images.length <= 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('É necessário ter pelo menos uma imagem.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      setState(() {
        widget.images.removeAt(_selectedImageIndex!);
        _selectedImageIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () async {
              // Reusing the scan page from add_car flow
              final filePath = await context.push('/add_car/scan');
              if (filePath != null && filePath != '') {
                widget.onImageAdded?.call(filePath as String);
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
                    "Adicionar Imagem da Categoria",
                    style: CatalagoColecionadorTheme.subTitleSmallStyle
                        .copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Adicione fotos da categoria",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
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
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          SizedBox(height: 16),
          Text(
            "Detalhes da Categoria",
            style: CatalagoColecionadorTheme.subTitleSmallStyle.copyWith(
              color: CatalagoColecionadorTheme.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          FormGroup(
            label: 'Nome da Categoria',
            child: TextFormField(
              controller: widget.nameController,
              style: CatalagoColecionadorTheme.textBold.copyWith(
                color: CatalagoColecionadorTheme.blackClaroColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              decoration: CatalagoColecionadorTheme.inputDecorationAddCard(
                hintText: 'Ex: Esportivos',
                colorSide: CatalagoColecionadorTheme.textMainAccent,
              ),
              validator: (v) => (v?.trim().isEmpty ?? true)
                  ? 'Nome da Categoria exigido'
                  : null,
            ),
          ),
          SizedBox(height: 12),
          FormGroup(
            label: 'Descrição',
            child: TextFormField(
              controller: widget.descriptionController,
              minLines: 2,
              maxLines: 5,
              style: CatalagoColecionadorTheme.textBold.copyWith(
                color: CatalagoColecionadorTheme.blackClaroColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              decoration: CatalagoColecionadorTheme.inputDecorationAddCard(
                hintText: 'Descrição da categoria...',
                isTextArea: true,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 24, bottom: 8),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CatalagoColecionadorTheme.bgInputAccent,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  textStyle: CatalagoColecionadorTheme.textBold.copyWith(
                    color: CatalagoColecionadorTheme.textDescriptColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: widget.onSave,
                child: Text(widget.textButtonOption),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
