import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

import '../../add_car/widget/form_group.dart';

class AddLineForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final String textButtonOption;
  final VoidCallback onSave;

  const AddLineForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
    required this.textButtonOption,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          FormGroup(
            label: 'Nome da Linha',
            colorLabel: CatalagoColecionadorTheme.labelColor,
            child: TextFormField(
              controller: nameController,
              style: CatalagoColecionadorTheme.textBold.copyWith(
                color: CatalagoColecionadorTheme.blackClaroColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              decoration: CatalagoColecionadorTheme.inputDecorationAddCard(
                hintText: 'Ex: Mainline',
                colorSide: CatalagoColecionadorTheme.textMainAccent,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome da linha';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          FormGroup(
            label: 'Descrição',
            colorLabel: CatalagoColecionadorTheme.labelColor,
            child: TextFormField(
              controller: descriptionController,
              minLines: 2,
              maxLines: 5,
              style: CatalagoColecionadorTheme.textBold.copyWith(
                color: CatalagoColecionadorTheme.blackClaroColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              decoration: CatalagoColecionadorTheme.inputDecorationAddCard(
                hintText: 'Descrição da linha...',
                isTextArea: true,
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: CatalagoColecionadorTheme.bgInputAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: CatalagoColecionadorTheme.textBold.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: Text(textButtonOption),
            ),
          ),
        ],
      ),
    );
  }
}
