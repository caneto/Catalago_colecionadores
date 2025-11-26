// --- FORM WIDGET ---
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:flutter/material.dart';

import 'collection_condition_card.dart';
import 'form_group.dart';

// ignore: must_be_immutable
class AddCarColectionForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeMiniaturaController;
  final TextEditingController marcaController;
  final TextEditingController modeloController;
  final TextEditingController anoFabricacaoController;
  final TextEditingController escalaController;
  final TextEditingController dataAquizicaoController;
  final TextEditingController precoPagoController;
  final String? condition;
  final ValueChanged<String?> onConditionChanged;
  final String? collectionCondition;
  final ValueChanged<String?> onCollectionConditionChanged;
  final TextEditingController notesController;
  String? imagePath;
  final VoidCallback onSave;

  AddCarColectionForm({
    super.key,
    required this.formKey,
    required this.nomeMiniaturaController,
    required this.marcaController,
    required this.modeloController,
    required this.anoFabricacaoController,
    required this.escalaController,
    required this.dataAquizicaoController,
    required this.precoPagoController,
    required this.condition,
    required this.onConditionChanged,
    required this.collectionCondition,
    required this.onCollectionConditionChanged,
    required this.notesController,
    required this.onSave, 
    String? imagePath,
  });

  @override
  State<AddCarColectionForm> createState() => _AddCarColectionFormState();
}

class _AddCarColectionFormState extends State<AddCarColectionForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () async {
              final filePath = await Navigator.of(
                context,
              ).pushNamed('/add_car/scan');
              if (filePath != null && filePath != '') {
                widget.imagePath = filePath as String;
                setState(() {});
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
                    "Adicionar miniatura",
                    style: CatalagoColecionadorTheme.subTitleSmallStyle
                        .copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Selecione o a imagem que deseja carregar",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
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
              validator: (v) => (v?.trim().isEmpty ?? true)
                  ? 'Nome da Miniatura exigido'
                  : null,
            ),
          ),
          // Marca e Modelo na mesma linha
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FormGroup(
                  label: 'Marca',
                  child: TextFormField(
                    controller: widget.marcaController,
                    style: CatalagoColecionadorTheme.textBold.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration:
                        CatalagoColecionadorTheme.inputDecorationAddCard(
                          hintText: 'Exemplo Hot Wheels',
                          colorSide: CatalagoColecionadorTheme.textMainAccent,
                        ),
                    validator: (v) =>
                        (v?.trim().isEmpty ?? true) ? 'Marca exigida' : null,
                  ),
                ),
              ),
              SizedBox(width: 12), // Espaço entre os campos
              Expanded(
                child: FormGroup(
                  label: 'Modelo',
                  child: TextFormField(
                    controller: widget.modeloController,
                    style: CatalagoColecionadorTheme.textBold.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration:
                        CatalagoColecionadorTheme.inputDecorationAddCard(
                          hintText: 'Exemplo Ford Mustang',
                          colorSide: CatalagoColecionadorTheme.textMainAccent,
                        ),
                    validator: (v) =>
                        (v?.trim().isEmpty ?? true) ? 'Modelo exigido' : null,
                  ),
                ),
              ),
            ],
          ),
          // Ano de Fabricação
          FormGroup(
            label: 'Ano de Fabricação',
            child: TextFormField(
              controller: widget.anoFabricacaoController,
              style: CatalagoColecionadorTheme.textBold.copyWith(
                color: CatalagoColecionadorTheme.blackClaroColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              decoration: CatalagoColecionadorTheme.inputDecorationAddCard(
                hintText: 'Exemplo 2008',
                colorSide: CatalagoColecionadorTheme.textMainAccent,
              ),
              keyboardType: TextInputType.number,
              validator: (v) =>
                  (v?.trim().isEmpty ?? true) ? 'Ano exigido' : null,
            ),
          ),

          SizedBox(height: 12),
          // Escala
          FormGroup(
            label: 'Escala',
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
              validator: (v) =>
                  (v?.trim().isEmpty ?? true) ? 'Scale required' : null,
            ),
          ),

          //Detalhes da Coleção
          SizedBox(height: 14),
          Text(
            "Detalhes da Coleção",
            style: CatalagoColecionadorTheme.subTitleSmallStyle.copyWith(
              color: CatalagoColecionadorTheme.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Condição",
            style: CatalagoColecionadorTheme.textBold.copyWith(
              color: CatalagoColecionadorTheme.whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              CollectionConditionCard(
                title: 'Na caixa',
                isSelected: widget.collectionCondition == 'Na caixa',
                onTap: () => widget.onCollectionConditionChanged('Na caixa'),
              ),
              SizedBox(width: 8),
              CollectionConditionCard(
                title: 'Novo',
                isSelected: widget.collectionCondition == 'Novo',
                onTap: () => widget.onCollectionConditionChanged('Novo'),
              ),
              SizedBox(width: 8),
              CollectionConditionCard(
                title: 'Usado',
                isSelected: widget.collectionCondition == 'Usado',
                onTap: () => widget.onCollectionConditionChanged('Usado'),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Data da Aquisição
          Row(
            children: [
              Expanded(
                child: FormGroup(
                  label: 'Data da Aquisição',
                  child: GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                        locale: const Locale("pt", "BR"),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: CatalagoColecionadorTheme.blueFaceBook,
                                onPrimary: Colors.white,
                                surface:
                                    CatalagoColecionadorTheme.cardCategyColor,
                                onSurface: CatalagoColecionadorTheme.whiteColor,
                              ),
                              datePickerTheme: DatePickerThemeData(
                                cancelButtonStyle: ButtonStyle(
                                  foregroundColor: WidgetStateProperty.all(
                                    CatalagoColecionadorTheme
                                        .navBarBackkgroundColor,
                                  ), // Cor do botão Cancelar
                                ),
                                confirmButtonStyle: ButtonStyle(
                                  foregroundColor: WidgetStateProperty.all(
                                    CatalagoColecionadorTheme.whiteColor,
                                  ), // Cor do botão Ok
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        widget.dataAquizicaoController.text =
                            '${picked.day}/${picked.month}/${picked.year}';
                      }
                    },
                    child: TextFormField(
                      controller: widget.dataAquizicaoController,
                      enabled: false,
                      style: CatalagoColecionadorTheme.textBold.copyWith(
                        color: CatalagoColecionadorTheme.blackClaroColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration:
                          CatalagoColecionadorTheme.inputDecorationAddCard(
                            hintText: 'dd/MM/aaaa',
                          ).copyWith(
                            suffixIcon: const Icon(
                              Icons.calendar_today,
                              color: CatalagoColecionadorTheme.bgInput,
                            ),
                          ),
                      validator: (v) =>
                          (v?.trim().isEmpty ?? true) ? 'Data exigida' : null,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12), // Espaço entre os campos
              Expanded(
                child: FormGroup(
                  label: 'Preço Pago',
                  child: TextFormField(
                    controller: widget.precoPagoController,
                    style: CatalagoColecionadorTheme.textBold.copyWith(
                      color: CatalagoColecionadorTheme.blackClaroColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration:
                        CatalagoColecionadorTheme.inputDecorationAddCard(
                          hintText: 'Exemplo R\$ 19,99',
                          colorSide: CatalagoColecionadorTheme.textMainAccent,
                        ),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        (v?.trim().isEmpty ?? true) ? 'Ano exigido' : null,
                  ),
                ),
              ),
            ],
          ),
          // Notes
          SizedBox(height: 20),
          FormGroup(
            label: 'Notes',
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
          // Save Button
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: double
                      .infinity, // <-- Mude aqui de 192 para double.infinity
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CatalagoColecionadorTheme.bgInputAccent,
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
                    child: const Text('Salvar Miniatura'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
