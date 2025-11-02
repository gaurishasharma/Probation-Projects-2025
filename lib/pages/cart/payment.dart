import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _paymentMethod = 0; // 0: Credit Card, 1: PayPal, 2: Apple Pay

  // Helper for a single payment option
  Widget _buildPaymentOption({
    required String title,
    required IconData icon,
    required int value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: RadioListTile<int>(
        value: value,
        groupValue: _paymentMethod,
        onChanged: (newValue) {
          setState(() {
            _paymentMethod = newValue!;
          });
        },
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        secondary: Icon(icon, color: Colors.white),
        activeColor: Colors.green,
        controlAffinity:
            ListTileControlAffinity.trailing, 
      ),
    );
  }

  void _processPayment() {
    
    String method = "Credit Card";
    if (_paymentMethod == 1) {
      method = "PayPal";
    } else if (_paymentMethod == 2) {
      method = "Apple Pay";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment processed with $method!'),
        backgroundColor: Colors.green,
      ),
    );


    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'STEP 2',
              style: TextStyle(
                color: const Color.fromARGB(255, 10, 10, 10),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Payment',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Payment method',
              style: TextStyle(
                color: Color.fromARGB(255, 1, 1, 1),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPaymentOption(
              title: 'Credit Card',
              icon: Icons.credit_card,
              value: 0,
            ),
            _buildPaymentOption(
              title: 'PayPal',
              icon: Icons.paypal, 
              value: 1,
            ),
            _buildPaymentOption(
              title: 'Apple Pay',
              icon: Icons.apple, 
              value: 2,
            ),

            const SizedBox(height: 24),

            if (_paymentMethod == 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Card Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Card Number *',
                      hintText: '0000 0000 0000 0000',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Expiry Date *',
                            hintText: 'MM/YY',
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'CVV *',
                            hintText: '123',
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
   
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0).copyWith(
          bottom: MediaQuery.of(context).padding.bottom + 20.0,
        ),
        child: ElevatedButton(
          onPressed: _processPayment,
       
          child: const Text('Pay Now'),
        ),
      ),
    );
  }
}