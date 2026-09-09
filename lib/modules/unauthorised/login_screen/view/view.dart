import 'package:courtclick_mt/core/constanst/assets_constants/assets_contant.dart';
import 'package:courtclick_mt/core/navigation/custom_page_route.dart';
import 'package:courtclick_mt/modules/authorised/home/view/home_screen.dart';
import 'package:courtclick_mt/widget/custom_profile_card/custom_profile_card.dart';
import 'package:flutter/material.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final profiles = ['User 1', 'User 2', 'User 3', 'Kids'];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Centered Netflix Logo & Right Edit Pen Icon
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Centered Netflix Logo
                  Image.asset(
                    AppImages.splashLogo,
                    height: 36,
                    fit: BoxFit.contain,
                  ),
                  // Top Right Edit Pen Icon
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        _isEditing ? Icons.check : Icons.edit,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () {
                        setState(() {
                          _isEditing = !_isEditing;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Profiles Grid & Add Profile CTA
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 2x2 Profiles Grid
                      SizedBox(
                        width: 260,
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.78,
                          physics: const NeverScrollableScrollPhysics(),
                          children: profiles.map((name) {
                            return ProfileCard(
                              name: name,
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  SmoothPageRoute(
                                    page: HomeScreen(profileName: name),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 36),

                      // Add Profile Button
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Add Profile tapped'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 38,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Add Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
