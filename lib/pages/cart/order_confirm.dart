import 'package:flutter/material.dart';

// Main function to run this screen standalone
void main() {
  runApp(const MyApp());
}

// MyApp: The root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Completed Screen',
      theme: ThemeData(
        // COPYING THE EXACT THEME from previous screens for consistency
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E), // Dark background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        // Define text field theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2A2A2A), // Darker input field
          hintStyle: TextStyle(color: Colors.grey[600]),
          labelStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none, // No border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
          ),
        ),
        // Define elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF333333), // Button color
            foregroundColor: Colors.white, // Text color
            minimumSize: const Size(double.infinity, 56), // Full width, 56 height
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const OrderCompletedScreen(), // This screen is the home
      debugShowCheckedModeBanner: false,
    );
  }
}

// OrderCompletedScreen: The final step of the checkout
class OrderCompletedScreen extends StatelessWidget {
  const OrderCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        title: const Text('Check out'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Custom Stepper/Progress Indicator from image "check out-3"
            _buildStepIndicator(),
            
            const Spacer(flex: 2),

            // Success Icon
            _buildSuccessIcon(context),
            const SizedBox(height: 32),

            // Order Completed Title
            Text(
              'Order Completed',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif', // Replicates the serif font in the image
              ),
            ),
            const SizedBox(height: 16),

            // Body Text
            Text(
              'Thank you for your purchase.\nYou can view your order in \'My Orders\' section.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
                height: 1.5, // Line spacing
              ),
            ),
            
            const Spacer(flex: 3),

            // Continue Shopping Button
            ElevatedButton(
              onPressed: () {
                // Logic to continue shopping
                // e.g., Navigator.of(context).popUntil((route) => route.isFirst);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Navigating to shopping...'),
                  ),
                );
              },
              child: const Text('Continue shopping'),
            ),
            const SizedBox(height: 20), // Bottom padding
          ],
        ),
      ),
    );
  }

  // Widget for the custom 3-step indicator
  Widget _buildStepIndicator() {
    // This matches the 3-step indicator in "check out-3"
    // Using Icons.payment as a logical replacement for the menu icon.
    return Row(
      children: [
        const Icon(Icons.location_on, color: Colors.white, size: 20),
        _buildStepDottedLine(),
        const Icon(Icons.payment, color: Colors.white, size: 20),
        _buildStepDottedLine(),
        const Icon(Icons.check_circle, color: Colors.white, size: 20),
      ],
    );
  }

  // Helper for the dotted line
  Widget _buildStepDottedLine() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        // Use LayoutBuilder to dynamically create dots to fill the space
        child: LayoutBuilder(
          builder: (context, constraints) {
            final dotWidth = 4.0;
            final dotSpace = 4.0;
            final dotCount = (constraints.maxWidth / (dotWidth + dotSpace)).floor();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(dotCount, (_) {
                return Container(
                  width: dotWidth,
                  height: dotWidth,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    shape: BoxShape.circle,
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }

  // Widget for the stacked success icon
  Widget _buildSuccessIcon(BuildContext context) {
    return SizedBox(
      width: 130, // Container size
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The main shopping bag
          Icon(
            Icons.shopping_bag_outlined, // Matches the outlined bag in the image
            size: 120,
            color: Colors.white.withOpacity(0.9),
          ),
          // The checkmark circle, positioned
          Positioned(
            right: 0,
            bottom: 5,
            child: Container(
              padding: const EdgeInsets.all(4),
              // Use theme color to "punch out" the background
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                size: 40,
                color: Colors.green, // Using a standard green
              ),
            ),
          ),
        ],
      ),
    );
  }
}