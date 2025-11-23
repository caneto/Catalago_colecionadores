
// --------------------
// Helper Data Classes
// --------------------
class CollectionItemData {
  final String imageUrl;
  final String brand;
  final String model;

  const CollectionItemData({
    required this.imageUrl,
    required this.brand,
    required this.model,
  });
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
