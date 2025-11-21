
import 'package:catalago_colecionadores/src/ui/core/widgets/miniaturas_nav_bar.dart';
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

// Asset URLs
const String _logoUrl =
    'https://app.codigma.io/api/uploads/assets/1df592e2-c193-463c-9fc1-cb273cb526cd.svg';


const _navItems = [
    {'iconLogo': 'home.svg', 'label': 'Home'},
    {'iconLogo': 'minhacolecao.svg', 'label': 'Minha Coleção'},
    {'iconLogo': 'estrela.svg', 'label': 'Adicionar'},
    {'iconLogo': 'engrenagem.svg', 'label': 'Configuração'},
  ];

int _selectedNavIndex = 0;


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

  int _currentNavIndex = 2; // "Add" is the third icon

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
    // Place navigation logic here
    // Example: Navigator.push(context, ...), or any other route
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

  void _onNavTap(int index) {
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
    final brightness = Theme.of(context).brightness;
    final double maxContentWidth = 390.0;
    return Material(
      color: _bgMain,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizontalPadding = _mainHorizontalPadding(context, constraints);
          return SafeArea(
            bottom: false,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: _bgMain,
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Header
                          Padding(
                            padding: EdgeInsets.only(
                              top: 36,
                              bottom: 16,
                            ),
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
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Semantics(
                                        label: 'Logo',
                                        child: Image.network(
                                          _logoUrl,
                                          width: 48,
                                          height: 48,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Flexible(
                                      child: Text(
                                        'Add Thumbnail',
                                        style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: _textMain,
                                          height: 1.3,
                                          letterSpacing: -0.2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Form Section
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              constraints: BoxConstraints(
                                maxWidth: maxContentWidth,
                              ),
                              padding: EdgeInsets.only(top: 0), // To align top to header
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
                        ],
                      ),
                    ),
                  ),
                  // Footer Navigation (sticky)
                  MiniaturasNavBar(
                    items: _navItems,
                    selectedIndex: _selectedNavIndex,
                    onItemTap: _onNavTapped,
                    navHeight: constraints.maxWidth < 600 ? 67 : 80,
                    iconSize: constraints.maxWidth < 600 ? 22 : 27,
                    labelFontSize: constraints.maxWidth < 600 ? 10.6 : 12.2,
                    navItemWidth: constraints.maxWidth < 600 ? 76 : 80,
                  ),
              /*     Container(
                    width: double.infinity,
                    color: _footerBg,
                    padding: EdgeInsets.only(
                      top: 0,
                      bottom: MediaQuery.of(context).padding.bottom,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: _borderFooter, width: 1),
                        ),
                        color: _footerBg,
                      ),
                      child: Center(
                        child: Container(
                          width: maxContentWidth,
                          constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth,
                          ),
                          padding: horizontalPadding.add(const EdgeInsets.only(
                            left: 0,
                            right: 0,
                            top: 10,
                            bottom: 14,
                          )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(_navigationItems.length, (i) {
                              final item = _navigationItems[i];
                              final isActive = i == _currentNavIndex;
                              return Expanded(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () => _onNavTap(i),
                                  splashColor: _accent.withOpacity(0.18),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Semantics(
                                        label: item['label'],
                                        selected: isActive,
                                        child: Image.network(
                                          item['icon']!,
                                          width: 24,
                                          height: 24,
                                          color:
                                              isActive ? _accent : _textPlaceholder,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        item['label']!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: isActive
                                              ? _accent
                                              : _textPlaceholder,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ), */
                ],
              ),
            ),
          );
        },
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

  InputDecoration _inputDecoration({String? hintText, bool isTextArea = false}) {
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
          color: _bgForm,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              offset: const Offset(0, 4),
              blurRadius: 16,
            )
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Brand
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
                icon: const Icon(Icons.arrow_drop_down, color: _textPlaceholder),
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
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Condition required' : null,
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
                decoration:
                    _inputDecoration(hintText: 'Write any notes...', isTextArea: true),
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

  const _FormGroup({
    required this.label,
    required this.child,
  });

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