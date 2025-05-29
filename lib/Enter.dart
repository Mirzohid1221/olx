import 'package:flutter/material.dart';
import 'package:olx/Login.dart';
import 'signUp.dart';
import 'home_page.dart';

class Enter extends StatelessWidget {
  const Enter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF002f34),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                  );
                },
                child: Text(
                  'Пропустить',
                  style: TextStyle(
                    color: Color(0xFF24e5db),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Image.asset('olx.png', height: 100),
          SizedBox(height: 24),
          Text(
            'Находите, покупайте\nили продавайте\nпрактически все, что угодно',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF24e5db),
              fontSize: 20,
              height: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Умный выбор для вас, вашего кошелька и планеты',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF24e5db).withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          Expanded(child: SizedBox()),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Color(0xFF24e5db),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                'Войти',
                style: TextStyle(
                  color: Color(0xFF002f34),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SignUp()),
              );
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF24e5db)),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                'Зарегистрироваться',
                style: TextStyle(
                  color: Color(0xFF24e5db),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
