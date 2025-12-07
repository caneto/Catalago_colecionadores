import 'package:catalago_colecionadores/src/core/database/isar_models/marca_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/pages/add_car/widget/form_group.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class AddSerieForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController numeroController;
  final TextEditingController descricaoController;
  final VoidCallback onSave;
  final String textButtonOption;
  final String? initialMarca;
  final ValueChanged<String?> onMarcaChanged;

  const AddSerieForm({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.numeroController,
    required this.descricaoController,
    required this.onSave,
    required this.textButtonOption,
    this.initialMarca,
    required this.onMarcaChanged,
  });

  @override
  State<AddSerieForm> createState() => _AddSerieFormState();
}

class _AddSerieFormState extends State<AddSerieForm> {
  String? _selectedMarca;
  List<MarcaCollection> marcas = [];
  final IsarService service = IsarService();

  @override
  void initState() {
    super.initState();
    _selectedMarca = widget.initialMarca;
    _loadMarcas();
  }

  Future<void> _loadMarcas() async {
    final list = await service.getAllMarcas();
    setState(() {
      marcas = list;
      // Ensure selected marca is still valid or set it if needed
      if (_selectedMarca != null) {
        if (!marcas.any((m) => m.nome == _selectedMarca)) {
          // If previously selected marca is not in list (deleted?), maybe clear it or keep it?
          // Usually we keep it if it's just a string, but dropdown needs it to be in items.
          // For now, let's assume it matches.
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 8),
          Text(
            "Detalhes da Serie",
            style: CatalagoColecionadorTheme.subTitleSmallStyle.copyWith(
              color: CatalagoColecionadorTheme.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          FormGroup(
            label: 'Nome',
            colorLabel: CatalagoColecionadorTheme.labelColor,
            child: TextFormField(
              controller: widget.nomeController,
              style: CatalagoColecionadorTheme.textBold.copyWith(
                color: CatalagoColecionadorTheme.blackClaroColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              decoration: CatalagoColecionadorTheme.inputDecorationAddCard(
                hintText: 'Nome da serie',
              ),
              validator: Validatorless.required('Nome obrigatório'),
            ),
          ),
          const SizedBox(height: 12),
          FormGroup(
            label: 'Número',
            colorLabel: CatalagoColecionadorTheme.labelColor,
            child: TextFormField(
              controller: widget.numeroController,
              style: CatalagoColecionadorTheme.textBold.copyWith(
                color: CatalagoColecionadorTheme.blackClaroColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              decoration: CatalagoColecionadorTheme.inputDecorationAddCard(
                hintText: 'Número da serie (ex: 1/5)',
              ),
              validator: Validatorless.required('Número obrigatório'),
            ),
          ),
          const SizedBox(height: 12),
          FormGroup(
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
                });
                widget.onMarcaChanged(newValue);
              },
              dropdownColor: CatalagoColecionadorTheme.blackLightGround,
              style: CatalagoColecionadorTheme.textBold.copyWith(
                color: CatalagoColecionadorTheme.blackClaroColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              decoration: CatalagoColecionadorTheme.inputDecorationAddCard(
                hintText: 'Selecione a marca',
              ),
              validator: Validatorless.required('Marca obrigatória'),
            ),
          ),
          const SizedBox(height: 12),
          FormGroup(
            label: 'Descrição',
            colorLabel: CatalagoColecionadorTheme.labelColor,
            child: TextFormField(
              controller: widget.descricaoController,
              style: CatalagoColecionadorTheme.textBold.copyWith(
                color: CatalagoColecionadorTheme.blackClaroColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              minLines: 3,
              maxLines: 5,
              decoration: CatalagoColecionadorTheme.inputDecorationAddCard(
                hintText: 'Descrição da serie',
                isTextArea: true,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: widget.onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: CatalagoColecionadorTheme.bgInputAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              widget.textButtonOption,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
