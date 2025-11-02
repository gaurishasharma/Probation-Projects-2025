import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // State variables
  RangeValues _selectedPriceRange = const RangeValues(10, 80);
  Color? _selectedColor;
  int? _selectedRating = 5;
  String? _selectedCategory = 'Crop Tops';
  Set<String> _selectedDiscounts = {'50% off', '40% off', '30% off', '25% off'};

  final List<String> _categories = ['Crop Tops', 'T-Shirts', 'Dresses', 'Jeans'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'Filter',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price Section
                    _buildSectionTitle('Price'),
                    const SizedBox(height: 8),
                    RangeSlider(
                      values: _selectedPriceRange,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      labels: RangeLabels(
                        '\$${_selectedPriceRange.start.round()}',
                        '\$${_selectedPriceRange.end.round()}',
                      ),
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey[400],
                      onChanged: (RangeValues newValues) {
                        setState(() => _selectedPriceRange = newValues);
                      },
                    ),
                    const SizedBox(height: 24),

                    // Color Section
                    _buildSectionTitle('Color'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      children: [
                        _buildColorSwatch(const Color(0xFFFF8C42)),
                        _buildColorSwatch(const Color(0xFFE34343)),
                        _buildColorSwatch(const Color(0xFF2C2C2C)),
                        _buildColorSwatch(const Color(0xFF4A5568)),
                        _buildColorSwatch(const Color(0xFFFFFFFF)),
                        _buildColorSwatch(const Color(0xFFD4A574)),
                        _buildColorSwatch(const Color(0xFFE8B4B8)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Star Rating Section
                    _buildSectionTitle('Star Rating'),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStarChip(1),
                        _buildStarChip(2),
                        _buildStarChip(3),
                        _buildStarChip(4),
                        _buildStarChip(5),
                      ],
                    ),
                    const SizedBox(height: 24),

                    
                    _buildSectionTitle('Category'),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        icon: const Icon(Icons.arrow_drop_down),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.storefront_outlined, color: Colors.black54),
                          border: InputBorder.none,
                        ),
                        items: _categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() => _selectedCategory = newValue);
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Discount Section
                    _buildSectionTitle('Discount'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12.0,
                      runSpacing: 12.0,
                      children: [
                        _buildDiscountChip('50% off'),
                        _buildDiscountChip('40% off'),
                        _buildDiscountChip('30% off'),
                        _buildDiscountChip('25% off'),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),

          
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetFilters,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.grey[400]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildColorSwatch(Color color) {
    final bool isSelected = _selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = isSelected ? null : color;
        });
      },
      child: Container(
        height: 44,
        width: 44,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 2.5,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: color == const Color(0xFFFFFFFF) 
                  ? Colors.grey[300]! 
                  : Colors.transparent,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStarChip(int rating) {
    final bool isSelected = _selectedRating == rating;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRating = isSelected ? null : rating;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              color: isSelected ? Colors.white : Colors.black54,
              size: 18,
            ),
            const SizedBox(width: 4),
            Text(
              '$rating',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountChip(String label) {
    final bool isSelected = _selectedDiscounts.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedDiscounts.remove(label);
          } else {
            _selectedDiscounts.add(label);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      _selectedPriceRange = const RangeValues(0, 100);
      _selectedColor = null;
      _selectedRating = null;
      _selectedCategory = null;
      _selectedDiscounts.clear();
    });
  }
}

