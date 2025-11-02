import 'package:flutter/material.dart';
import '../cart/payment.dart';
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  
  final _formKey = GlobalKey<FormState>();

  
  final _firstNameController = TextEditingController(text: "RAM"); // Pre-filled
  final _lastNameController = TextEditingController();
  final _streetNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _couponController = TextEditingController();

  
  String? _selectedCountry;
  int _shippingMethod = 0; 
  bool _copyAddress = false;

  final List<String> _countries = [
    'Country *',
    'USA',
    'Canada',
    'Mexico',
    'United Kingdom',
    'Germany',
    'India',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCountry = _countries[0];
  }

  @override
  void dispose() {
    
    _firstNameController.dispose();
    _lastNameController.dispose();
    _streetNameController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _phoneController.dispose();
    _couponController.dispose();
    super.dispose();
  }

  void _submitForm() {
 
    if (_formKey.currentState!.validate()) {
 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing to Payment...'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1), 
        ),
      );
      
    
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PaymentScreen()),
      );
      

    } else {
     
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the errors in the form.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isRequired = true,
    TextInputType keyboardType = TextInputType.text,
  }) {

    final bool hasGreenStar = (label == "Street name" ||
        label == "Phone number" ||
        label == "Zip-code" ||
        label == "City");

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: hasGreenStar
                ? Colors.greenAccent[400]
                : (isRequired ? Colors.grey[400] : Colors.grey[600]),
          ),
          hintText: hint,
          floatingLabelBehavior:
              FloatingLabelBehavior.always, 
        ),
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return '$label is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildRequiredLabel(
    String label, {
    bool isRed = false,
    bool isGreen = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: label,
         
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 12),
          children: [
            TextSpan(
              text: ' *',
              style: TextStyle(
                color: isRed
                    ? Colors.redAccent
                    : (isGreen ? Colors.greenAccent[400] : Colors.grey[400]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Check out'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              _buildStepIndicator(),
              const SizedBox(height: 24),

              
              Text(
                'STEP 1',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Shipping',
                style: TextStyle(
                
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

        
              _buildShippingForm(),

              const SizedBox(height: 24),

              _buildShippingMethod(),

              const SizedBox(height: 24),

              _buildCouponCode(),

              const SizedBox(height: 24),

              _buildBillingAddress(),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
  
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Continue to payment'),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStepIcon(Icons.check_circle, Colors.green, true),
        _buildStepLine(),
       
        _buildStepIcon(Icons.radio_button_checked, const Color.fromARGB(255, 0, 0, 0), true),
        _buildStepLine(),
        
        _buildStepIcon(Icons.radio_button_unchecked, const Color.fromARGB(255, 0, 0, 0), false),
        _buildStepLine(),
      
        _buildStepIcon(Icons.radio_button_unchecked, const Color.fromARGB(255, 0, 0, 0), false),
        _buildStepLine(),
      
        _buildStepIcon(Icons.radio_button_checked, const Color.fromARGB(255, 0, 0, 0), true),
      ],
    );
  }

  Widget _buildStepIcon(IconData icon, Color color, bool isFilled) {
    return Icon(icon, color: color, size: isFilled ? 18 : 16);
  }

  Widget _buildStepLine() {
    return Expanded(
      child: Container(
        height: 1.5,
        color: Colors.grey[700],
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
      ),
    );
  }

 
  Widget _buildShippingForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          _buildRequiredLabel('First name'),
          TextFormField(
            controller: _firstNameController,
            decoration: const InputDecoration(
              hintText: 'Enter your first name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'First name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          
          _buildRequiredLabel('Last name', isRed: true),
          TextFormField(
            controller: _lastNameController,
            decoration: const InputDecoration(hintText: 'Enter your last name'),
     
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field is required'; 
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

  
          _buildRequiredLabel('Country', isGreen: true),
          DropdownButtonFormField<String>(
            value: _selectedCountry,
            items: _countries.map((String country) {
              return DropdownMenuItem<String>(
                value: country,
                child: Text(
                  country,
                  style: TextStyle(
                  
                    color: country == _countries[0]
                        ? const Color.fromARGB(255, 0, 0, 0)
                        : const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedCountry = newValue;
              });
            },
            decoration: const InputDecoration(
                
                ),
            validator: (value) {
              if (value == null || value == _countries[0]) {
                return 'Please select a country';
              }
              return null;
            },
        
            dropdownColor: const Color.fromARGB(255, 255, 249, 249),
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _streetNameController,
            label: 'Street name *',
            hint: 'Enter your street name',
            isRequired: true,
          ),
          _buildTextField(
            controller: _cityController,
            label: 'City *',
            hint: 'Enter your city',
            isRequired: true,
          ),
          _buildTextField(
            controller: _stateController,
            label: 'State',
            hint: 'Enter your state',
            isRequired: false,
          ),
          _buildTextField(
            controller: _zipCodeController,
            label: 'Zip-code *',
            hint: 'Enter your zip-code',
            isRequired: true,
            keyboardType: TextInputType.number,
          ),
          _buildTextField(
            controller: _phoneController,
            label: 'Phone number *',
            hint: 'Enter your phone number',
            isRequired: true,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildShippingMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping method',
          style: TextStyle(
          
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildShippingOption(
          title: 'Free',
          subtitle: 'Delivery from 5 to 7 business days',
          price: 'Free',
          value: 0,
        ),
        _buildShippingOption(
          title: 'Delivery to home',
          subtitle: 'Delivery from 4 to 6 business days',
          price: r'$ 9.90',
          value: 1,
        ),
        _buildShippingOption(
          title: 'Fast Delivery',
          subtitle: 'Delivery from 2 to 3 business days',
          price: r'$ 9.90',
          value: 2,
        ),
      ],
    );
  }


  Widget _buildShippingOption({
    required String title,
    required String subtitle,
    required String price,
    required int value,
  }) {

    bool isFree = (title == 'Free');

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: RadioListTile<int>(
        value: value,
        groupValue: _shippingMethod,
        onChanged: (newValue) {
          setState(() {
            _shippingMethod = newValue!;
          });
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isFree ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              price,
              style: TextStyle(
                color: isFree ? Colors.greenAccent[400] : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[400])),
        activeColor: Colors.green, 
        controlAffinity:
            ListTileControlAffinity.leading, 
      ),
    );
  }

  Widget _buildCouponCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Coupon Code',
          style: TextStyle(
           
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _couponController,
          decoration: InputDecoration(
            hintText: 'Have a code? type it here...',
            suffixIcon: TextButton(
              onPressed: () {
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Validating coupon: ${_couponController.text}',
                    ),
                  ),
                );
              },
              child: const Text('Validate'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBillingAddress() {
    return CheckboxListTile(
      value: _copyAddress,
      onChanged: (newValue) {
        setState(() {
          _copyAddress = newValue!;
        });
      },
      title: const Text(
        'Billing Address',
        style: TextStyle(
          
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'Copy address data from shipping',
    
        style: TextStyle(color: Colors.grey[400]),
      ),
      controlAffinity: ListTileControlAffinity.leading, // Checkbox on the left
      contentPadding: EdgeInsets.zero,
    
      activeColor: const Color.fromARGB(255, 37, 184, 7),
    );
  }
}