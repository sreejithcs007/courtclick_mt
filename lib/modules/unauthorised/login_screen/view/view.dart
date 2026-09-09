import 'package:courtclick_mt/modules/authorised/home/view/home_screen.dart';
import 'package:courtclick_mt/widget/custom_profile_card/custom_profile_card.dart';
import 'package:flutter/material.dart';

class LoginPageScreen extends StatelessWidget {
  const LoginPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profiles = ['Emenalo', 'Onyeka', 'Thelma', 'Kids'];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: 260,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.8,
            physics: const NeverScrollableScrollPhysics(),
            children: profiles.map((name) {
              return ProfileCard(
                name: name,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(profileName: name),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
