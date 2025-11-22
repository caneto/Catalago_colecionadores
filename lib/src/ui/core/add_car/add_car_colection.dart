import 'package:catalago_colecionadores/src/ui/core/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/ui/core/theme/resource.dart';
import 'package:catalago_colecionadores/src/ui/core/widgets/miniaturas_nav_bar.dart';
import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';

// Colors (adapted from CSS variables)
const Color _bgMain = Color(0xFF211212);
const Color _bgForm = Color(0xFF331A1C);
const Color _bgInput = Color(0xFF472426);
const Color _borderFooter = Color(0xFF472426);
const Color _textPlaceholder = Color(0xFFC99194);
const Color _footerBg = Color(0xFF331A1C);

const _navItems = [
  {'iconLogo': 'home.svg', 'label': 'Home'},
  {'iconLogo': 'minhacolecao.svg', 'label': 'Minha Coleção'},
  {'iconLogo': 'estrela.svg', 'label': 'Adicionar'},
  {'iconLogo': 'engrenagem.svg', 'label': 'Configuração'},
];

int _selectedNavIndex = 2; // "Add" é este ícone

class AddCarColection extends StatefulWidget {
  const AddCarColection({super.key});

  @override
  State<AddCarColection> createState() => _AddCarColectionState();
}

class _AddCarColectionState extends State<AddCarColection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeMiniaturaController =
      TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _anoFabricacaoController =
      TextEditingController();
  final TextEditingController _escalaController = TextEditingController();
  final TextEditingController _dataAquizicaoController =
      TextEditingController();
  final TextEditingController _precoPagoController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? _condition;
  String? _collectionCondition; // <-- Nova variável

  //final int _currentNavIndex = 2; // "Add" is the third icon

  void _onNavTapped(int idx) {
    if (idx == _selectedNavIndex) return;
    setState(() {
      _selectedNavIndex = idx;
      Navigator.of(context).pushReplacementNamed(
        idx == 0
            ? '/home'
            : idx == 1
            ? '/collection'
            : idx == 2
            ? '/add_car'
            : '/settings',
      );
    });
  }

  static const List<String> _conditions = [
    'New',
    'Used - Like New',
    'Used - Good',
    'Damage/Parts',
  ];

  @override
  void dispose() {
    _nomeMiniaturaController.dispose();
    _modeloController.dispose();
    _marcaController.dispose();
    _escalaController.dispose();
    _anoFabricacaoController.dispose();
    _dataAquizicaoController.dispose();
    _precoPagoController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() != true) return;
    // Saving logic here...
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thumbnail saved!'),
        backgroundColor: CatalagoColecionadorTheme.bgInputAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  EdgeInsets _mainHorizontalPadding(BuildContext context, BoxConstraints c) {
    final w = c.maxWidth;
    if (w <= 370) return EdgeInsets.zero;
    if (w <= 390) return EdgeInsets.symmetric(horizontal: w * .03);
    if (w <= 480) return const EdgeInsets.symmetric(horizontal: 10);
    return EdgeInsets.zero;
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    _selectedNavIndex = 2; // Seta o select para o "Add"

    //final brightness = Theme.of(context).brightness;
    final double maxContentWidth = 390.0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = _mainHorizontalPadding(
              context,
              constraints,
            );
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
                      // Header (não scrollável)
                      Padding(
                        padding: EdgeInsets.only(top: 36, bottom: 16),
                        child: Center(
                          child: Container(
                            width: maxContentWidth,
                            constraints: BoxConstraints(
                              maxWidth: constraints.maxWidth,
                            ),
                            padding: horizontalPadding,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          color: CatalagoColecionadorTheme
                                              .blackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Adicionar Miniatura  ',
                                            style: CatalagoColecionadorTheme
                                                .titleStyleNormal
                                                .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  height: 1.3,
                                                  letterSpacing: -0.2,
                                                ),
                                          ),
                                          TextSpan(
                                            text: 'Cancelar',
                                            style: const TextStyle(
                                              color: CatalagoColecionadorTheme
                                                  .orangeColor,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Form Section (scrollável)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 60,
                              ), // espaço para navbar
                              constraints: BoxConstraints(
                                maxWidth: maxContentWidth,
                              ),
                              padding: EdgeInsets.only(top: 0),
                              child: Padding(
                                padding: horizontalPadding,
                                child: _AddCarColectionForm(
                                  formKey: _formKey,
                                  nomeMiniaturaController:
                                      _nomeMiniaturaController,
                                  modeloController: _modeloController,
                                  marcaController: _marcaController,
                                  escalaController: _escalaController,
                                  anoFabricacaoController:
                                      _anoFabricacaoController,
                                  dataAquizicaoController:
                                      _dataAquizicaoController,
                                  precoPagoController: _precoPagoController,
                                  notesController: _notesController,
                                  condition: _condition,
                                  onConditionChanged: (val) =>
                                      setState(() => _condition = val),
                                  collectionCondition: _collectionCondition,
                                  onCollectionConditionChanged: (val) =>
                                      setState(
                                        () => _collectionCondition = val,
                                      ),
                                  onSave: _onSave,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Footer Navigation (sticky)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: MiniaturasNavBar(
                      items: _navItems,
                      selectedIndex: _selectedNavIndex,
                      onItemTap: _onNavTapped,
                      navHeight: constraints.maxWidth < 600 ? 67 : 80,
                      iconSize: constraints.maxWidth < 600 ? 22 : 27,
                      labelFontSize: constraints.maxWidth < 600 ? 10.6 : 12.2,
                      navItemWidth: constraints.maxWidth < 600 ? 76 : 80,
                    ),
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

// --- FORM WIDGET ---
class _AddCarColectionForm extends StatelessWidget {
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
  final VoidCallback onSave;

  const _AddCarColectionForm({
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
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 25),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.lightBlue.shade500, width: 0.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(R.ASSETS_IMAGES_FOLDER_PNG),
                SizedBox(height: 12),
                Text(
                  "Adicionar miniatura",
                  style: CatalagoColecionadorTheme.subTitleSmallStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Selecione o a imagem que deseja carregar",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
          // Nome da Miniatura
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
          _FormGroup(
            label: 'Nome da Miniatura',
            child: TextFormField(
              controller: nomeMiniaturaController,
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
                child: _FormGroup(
                  label: 'Marca',
                  child: TextFormField(
                    controller: marcaController,
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
                child: _FormGroup(
                  label: 'Modelo',
                  child: TextFormField(
                    controller: modeloController,
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
          _FormGroup(
            label: 'Ano de Fabricação',
            child: TextFormField(
              controller: anoFabricacaoController,
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
          _FormGroup(
            label: 'Escala',
            child: TextFormField(
              controller: escalaController,
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
              _CollectionConditionCard(
                title: 'Na caixa',
                isSelected: collectionCondition == 'Na caixa',
                onTap: () => onCollectionConditionChanged('Na caixa'),
              ),
              SizedBox(width: 8),
              _CollectionConditionCard(
                title: 'Novo',
                isSelected: collectionCondition == 'Novo',
                onTap: () => onCollectionConditionChanged('Novo'),
              ),
              SizedBox(width: 8),
              _CollectionConditionCard(
                title: 'Usado',
                isSelected: collectionCondition == 'Usado',
                onTap: () => onCollectionConditionChanged('Usado'),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Data da Aquisição
          Row(
            children: [
              Expanded(
                child: _FormGroup(
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
                                    CatalagoColecionadorTheme.navBarBackkgroundColor,
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
                        dataAquizicaoController.text =
                            '${picked.day}/${picked.month}/${picked.year}';
                      }
                    },
                    child: TextFormField(
                      controller: dataAquizicaoController,
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
                child: _FormGroup(
                  label: 'Preço Pago',
                  child: TextFormField(
                    controller: precoPagoController,
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
          _FormGroup(
            label: 'Notes',
            child: TextFormField(
              controller: notesController,
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
                    onPressed: onSave,
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

// Wigets auxiliares
class _CollectionConditionCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _CollectionConditionCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? CatalagoColecionadorTheme.bgInputAccent
                : CatalagoColecionadorTheme.bgInput,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? CatalagoColecionadorTheme.bgInputAccent
                  : _borderFooter,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: CatalagoColecionadorTheme.textBold.copyWith(
                color: CatalagoColecionadorTheme.textDescriptColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget para agrupar label e campo do formulário
class _FormGroup extends StatelessWidget {
  final String label;
  final Widget child;

  const _FormGroup({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: label,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6, left: 2),
              child: Text(
                label,
                style: CatalagoColecionadorTheme.textBold.copyWith(
                  color: CatalagoColecionadorTheme.textDescriptColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
