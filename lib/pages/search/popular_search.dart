import 'package:flutter/material.dart';
import '../product/product_card.dart'; // We import our new ProductCard widget

class PopularThisWeek extends StatelessWidget {
  const PopularThisWeek({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const Text(
              'Popular this week',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
           
          ],
        ),
        const SizedBox(height: 16),

  
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
            
              final items = [
                {
                  'image': 'assets/images/card1.png',
                  'title': 'Lihua Tunic White',
                  'price': '\$ 53.00'
                },
                {
                  'image': 'assets/images/card2.png',
                  'title': 'Skirt Dress',
                  'price': '\$ 34.00'
                },
                {
                  'image': 'assets/images/card4.png',
                  'title': 'Kimono Dress',
                  'price': '\$ 40.00'
                },
              ];
            
              return ProductCard(
                image: items[index]['image']!,
                title: items[index]['title']!,
                price: items[index]['price']!,
              );
            },
          ),
        ),
      ],
    );
  }
}