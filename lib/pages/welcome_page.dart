import 'package:flutter/material.dart'; 
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboard.dart'; 

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            const Image(
              image: AssetImage('assets/images/front.png'),
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
            
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  Text(
                    "Welcome to Vogue Vista!",
                    textAlign: TextAlign.center,
                  
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Text(
                    "The home for a fashionista",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontStyle: FontStyle.italic, 
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),

                
                  const Spacer(flex: 6),
                  
                
                  ElevatedButton(
                  
                    onPressed: () {
                    
                      Navigator.push(
                        context,
                        
                        MaterialPageRoute(
                        
                          builder: (context) => const OnboardingScreen(),
                        ),
                      );
                    },
                
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, 
                      foregroundColor: Colors.white,
                    
                      padding: const EdgeInsets.symmetric(
                        horizontal: 70,
                        vertical: 16,
                      ),
              
                      shape: RoundedRectangleBorder(
                      
                        borderRadius: BorderRadius.circular(30.0),
                  
                        side: const BorderSide(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                      elevation: 0,
                    ),
                  
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}