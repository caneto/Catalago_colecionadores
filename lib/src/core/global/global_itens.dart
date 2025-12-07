
final class GlobalItens {
  
  static const categoriesItens = [
    'Carros',
    'Motos',
    'Aviões',
    'Caminhoes',
    'Barcos',
    'Outros',
  ];

  static const navItems = [
    {'iconLogo': 'home.svg', 'label': 'Home'},
    {'iconLogo': 'minhacolecao.svg', 'label': 'Minha Coleção'},
    {'iconLogo': 'estrela.svg', 'label': 'Adicionar'},
    {'iconLogo': 'lupa.svg', 'label': 'Buscar'},
    {'iconLogo': 'engrenagem.svg', 'label': 'Configuração'},
  ];

  // Filter options
  static const List<FilterItemData> filters = [
    FilterItemData(
      label: 'Marca',
      iconUrl: 'seta_filter.svg',
      hasDropdown: true,
    ),
    FilterItemData(
      label: 'Modelo',
      iconUrl: 'seta_filter.svg',
      hasDropdown: true,
    ),
    FilterItemData(label: 'Ano', iconUrl: 'seta_filter.svg', hasDropdown: true),
    FilterItemData(
      label: 'Escala',
      iconUrl: 'seta_filter.svg',
      hasDropdown: true,
    ),
    FilterItemData(
      label: 'Condição',
      iconUrl: 'seta_filter.svg',
      hasDropdown: true,
    ),
    FilterItemData(
      label: 'Categoria',
      iconUrl: 'seta_filter.svg',
      hasDropdown: true,
    ),
  ];
}

class FilterItemData {
  final String label;
  final String? iconUrl;
  final bool hasDropdown;

  const FilterItemData({
    required this.label,
    this.iconUrl,
    this.hasDropdown = false,
  });
}
