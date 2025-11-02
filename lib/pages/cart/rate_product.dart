import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemUiOverlayStyle

class RateProductScreen extends StatefulWidget {
  const RateProductScreen({super.key});

  @override
  State<RateProductScreen> createState() => _RateProductScreenState();
}

class _RateProductScreenState extends State<RateProductScreen> {
  int _currentRating = 4; // Default rating
  final TextEditingController _reviewController = TextEditingController();
  final int _maxCharacters = 50; // Max characters for the text field

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This screen assumes it's built within a MaterialApp that provides
    // the dark theme defined in the previous example.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Product'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back navigation
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Submit your review card
            _buildPointsCard(),
            const SizedBox(height: 32),

            // 2. Star Rating
            _buildStarRating(),
            const SizedBox(height: 32),

            // 3. Review Text Field
            _buildReviewTextField(),
            const SizedBox(height: 24),

            // 4. Image Upload Placeholder Icons
            _buildImageUploadPlaceholders(),
            const SizedBox(height: 40), // More space before the button

            // 5. Submit Review Button
            SizedBox(
              width: double.infinity, // Make the button full width
              child: ElevatedButton(
                onPressed: () {
                  // Handle submit review logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Rating: $_currentRating stars. Review: "${_reviewController.text}"'),
                    ),
                  );
                },
                child: const Text('Submit Review'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF424242), // Dark grey background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.card_giftcard, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Submit your review to get 5 points',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _currentRating ? Icons.star : Icons.star_border,
            color: index < _currentRating ? Colors.teal[300] : Colors.grey[600],
            size: 40,
          ),
          onPressed: () {
            setState(() {
              _currentRating = index + 1;
            });
          },
        );
      }),
    );
  }

  Widget _buildReviewTextField() {
    return Card(
      // The Card widget provides the white background and rounded corners
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Padding inside the card
        child: Column(
          children: [
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                hintText:
                    'Would you like to write anything about this product?',
                border: InputBorder.none, // Remove default TextField border
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              maxLines: 5,
              maxLength: _maxCharacters, // Limit characters
              buildCounter: (context,
                  {required currentLength,
                  required isFocused,
                  maxLength}) {
                // Custom character counter at the bottom right
                return Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '$currentLength characters',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                );
              },
              onChanged: (text) {
                // Rebuild to update character counter if not using buildCounter
                // setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploadPlaceholders() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildImagePlaceholder(Icons.image_outlined),
        const SizedBox(width: 16),
        _buildImagePlaceholder(Icons.camera_alt_outlined),
      ],
    );
  }

  Widget _buildImagePlaceholder(IconData icon) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!), // Light grey border
      ),
      child: Icon(
        icon,
        color: Colors.grey[400], // Light grey icon
        size: 36,
      ),
    );
  }
}