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
const Color _accent = Color(0xFFED121F);
const Color _textMain = Colors.white;
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
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _scaleController = TextEditingController();
  String? _condition;
  final TextEditingController _notesController = TextEditingController();

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
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _scaleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() != true) return;
    // Saving logic here...
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thumbnail saved!'),
        backgroundColor: _accent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /* void _onNavTap(int index) {
    if (index == _currentNavIndex) return;
    setState(() => _currentNavIndex = index);
    // Navigation logic using Navigator 1.0
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed('/collection');
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed('/add');
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed('/settings');
        break;
    }
  } */

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
                              margin: EdgeInsets.only(bottom: 60), // espaço para navbar
                              constraints: BoxConstraints(
                                maxWidth: maxContentWidth,
                              ),
                              padding: EdgeInsets.only(top: 0),
                              child: Padding(
                                padding: horizontalPadding,
                                child: _AddCarColectionForm(
                                  formKey: _formKey,
                                  brandController: _brandController,
                                  modelController: _modelController,
                                  yearController: _yearController,
                                  scaleController: _scaleController,
                                  condition: _condition,
                                  onConditionChanged: (val) =>
                                      setState(() => _condition = val),
                                  notesController: _notesController,
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
  final TextEditingController brandController;
  final TextEditingController modelController;
  final TextEditingController yearController;
  final TextEditingController scaleController;
  final String? condition;
  final ValueChanged<String?> onConditionChanged;
  final TextEditingController notesController;
  final VoidCallback onSave;

  const _AddCarColectionForm({
    required this.formKey,
    required this.brandController,
    required this.modelController,
    required this.yearController,
    required this.scaleController,
    required this.condition,
    required this.onConditionChanged,
    required this.notesController,
    required this.onSave,
  });

  InputDecoration _inputDecoration({
    String? hintText,
    bool isTextArea = false,
  }) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: _bgInput,
      hintStyle: const TextStyle(
        color: _textPlaceholder,
        fontWeight: FontWeight.w500,
        fontSize: 15,
        fontFamily: 'Plus Jakarta Sans',
      ),
      contentPadding: isTextArea
          ? const EdgeInsets.fromLTRB(14, 15, 14, 40)
          : const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _accent, width: 2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              offset: const Offset(0, 4),
              blurRadius: 16,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
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
            // Brand
            SizedBox(height: 12),
            _FormGroup(
              label: 'Brand',
              child: TextFormField(
                controller: brandController,
                style: const TextStyle(
                  color: _textMain,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Plus Jakarta Sans',
                ),
                decoration: _inputDecoration(hintText: 'e.g. Hot Wheels'),
                validator: (v) =>
                    (v?.trim().isEmpty ?? true) ? 'Brand required' : null,
              ),
            ),
            // Model
            _FormGroup(
              label: 'Model',
              child: TextFormField(
                controller: modelController,
                style: const TextStyle(
                  color: _textMain,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Plus Jakarta Sans',
                ),
                decoration: _inputDecoration(hintText: 'e.g. Ford Mustang'),
                validator: (v) =>
                    (v?.trim().isEmpty ?? true) ? 'Model required' : null,
              ),
            ),
            // Year
            _FormGroup(
              label: 'Year',
              child: TextFormField(
                controller: yearController,
                style: const TextStyle(
                  color: _textMain,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Plus Jakarta Sans',
                ),
                decoration: _inputDecoration(hintText: 'e.g. 1967'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    (v?.trim().isEmpty ?? true) ? 'Year required' : null,
              ),
            ),
            // Scale
            _FormGroup(
              label: 'Scale',
              child: TextFormField(
                controller: scaleController,
                style: const TextStyle(
                  color: _textMain,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Plus Jakarta Sans',
                ),
                decoration: _inputDecoration(hintText: 'e.g. 1:64'),
                validator: (v) =>
                    (v?.trim().isEmpty ?? true) ? 'Scale required' : null,
              ),
            ),
            // Condition
            _FormGroup(
              label: 'Condition',
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                dropdownColor: _bgInput,
                focusColor: _bgInput,
                initialValue: condition,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: _textPlaceholder,
                ),
                style: const TextStyle(
                  color: _textMain,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Plus Jakarta Sans',
                ),
                decoration: _inputDecoration(hintText: 'Select'),
                items: _AddCarColectionState._conditions
                    .map(
                      (c) => DropdownMenuItem<String>(
                        value: c,
                        child: Text(
                          c,
                          style: const TextStyle(
                            color: _textMain,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Plus Jakarta Sans',
                          ),
                        ),
                      ),
                    )
                    .toList(),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Condition required'
                    : null,
                onChanged: onConditionChanged,
              ),
            ),
            // Notes
            _FormGroup(
              label: 'Notes',
              child: TextFormField(
                controller: notesController,
                minLines: 2,
                maxLines: 5,
                style: const TextStyle(
                  color: _textMain,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Plus Jakarta Sans',
                ),
                decoration: _inputDecoration(
                  hintText: 'Write any notes...',
                  isTextArea: true,
                ),
              ),
            ),
            // Save Button
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 192,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accent,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        shadowColor: _accent.withOpacity(0.13),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          fontFamily: 'Plus Jakarta Sans',
                        ),
                      ),
                      onPressed: onSave,
                      child: const Text('Save'),
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

// --- FORM GROUP (for accessible labeling and spacing) ---
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
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6, left: 2),
              child: Text(
                label,
                style: const TextStyle(
                  color: _textMain,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: 'Plus Jakarta Sans',
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
