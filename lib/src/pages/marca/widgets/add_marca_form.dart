import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:flutter/material.dart';

import '../../add_car/widget/form_group.dart';

class AddMarcaForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController quantidadeController;
  final String? logoPath;
  final ValueChanged<String?>? onLogoChanged;
  final VoidCallback onSave;
  final String textButtonOption;

  const AddMarcaForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
    required this.quantidadeController,
    this.logoPath,
    this.onLogoChanged,
    required this.onSave,
    required this.textButtonOption,
  });

  @override
  State<AddMarcaForm> createState() => _AddMarcaFormState();
}

class _AddMarcaFormState extends State<AddMarcaForm> {
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
              final filePath = await Navigator.of(
                context,
              ).pushNamed('/add_car/scan');
              if (filePath != null && filePath != '') {
                widget.onLogoChanged?.call(filePath as String);
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
                  widget.logoPath != null
                      ? Image.asset(
                          R.ASSETS_IMAGES_FOLDER_PNG,
                        ) // Placeholder, ideally show the image
                      : Image.asset(R.ASSETS_IMAGES_FOLDER_PNG),
                  SizedBox(height: 12),
                  Text(
                    "Adicionar Logo da Marca",
                    style: CatalagoColecionadorTheme.subTitleSmallStyle
                        .copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  Text(
                    widget.logoPath != null
                        ? "Logo selecionada"
                        : "Selecione a logo",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Detalhes da Marca",
            style: CatalagoColecionadorTheme.subTitleSmallStyle.copyWith(
              color: CatalagoColecionadorTheme.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          FormGroup(
            label: 'Nome da Marca',
            child: TextFormField(
              controller: widget.nameController,
              style: CatalagoColecionadorTheme.textBold.copyWith(
                color: CatalagoColecionadorTheme.blackClaroColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              decoration: CatalagoColecionadorTheme.inputDecorationAddCard(
                hintText: 'Ex: Hot Wheels',
                colorSide: CatalagoColecionadorTheme.textMainAccent,
              ),
              validator: (v) =>
                  (v?.trim().isEmpty ?? true) ? 'Nome da Marca exigido' : null,
            ),
          ),
          SizedBox(height: 12),
          FormGroup(
            label: 'Quantidade',
            child: TextFormField(
              controller: widget.quantidadeController,
              keyboardType: TextInputType.number,
              style: CatalagoColecionadorTheme.textBold.copyWith(
                color: CatalagoColecionadorTheme.blackClaroColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              decoration: CatalagoColecionadorTheme.inputDecorationAddCard(
                hintText: 'Ex: 10',
                colorSide: CatalagoColecionadorTheme.textMainAccent,
              ),
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
                hintText: 'Descrição da marca...',
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
