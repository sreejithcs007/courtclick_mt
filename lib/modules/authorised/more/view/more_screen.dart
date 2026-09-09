import 'package:courtclick_mt/modules/unauthorised/login_screen/view/view.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  final String activeProfile;

  const MoreScreen({
    super.key,
    this.activeProfile = 'Emenalo',
  });

  static final List<Map<String, dynamic>> _profiles = [
    {'name': 'Emenalo', 'color': Colors.blue},
    {'name': 'Onyeka', 'color': Colors.amber},
    {'name': 'Thelma', 'color': Colors.red},
    {'name': 'Kids', 'color': Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profiles Row at top
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ..._profiles.map((p) {
                    final bool isActive = p['name'] == activeProfile;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: p['color'] as Color,
                            borderRadius: BorderRadius.circular(4),
                            border: isActive
                                ? Border.all(color: Colors.white, width: 2)
                                : null,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 12,
                                top: 12,
                                child: Container(
                                  width: 4,
                                  height: 4,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 12,
                                top: 12,
                                child: Container(
                                  width: 4,
                                  height: 4,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    '⌣',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          p['name'] as String,
                          style: TextStyle(
                            color: isActive ? Colors.white : Colors.grey,
                            fontSize: 12,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  }),

                  // Add Profile (+) button
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey[700]!, width: 1),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        '',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Manage Profiles Button
              Center(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, color: Colors.grey, size: 14),
                  label: const Text(
                    'Manage Profiles',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Referral / Share Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.chat_bubble_outline, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Tell friends about Netflix.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Share Netflix with your friends and family so they can watch their favorite movies and TV shows.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Copy Link bar
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 36,
                            color: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'https://www.netflix.com/referral/8291',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey, fontSize: 11),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: const Text(
                              'Copy Link',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Social Icons Row (WhatsApp, Facebook, Gmail, More)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _socialButton(
                          icon: Icons.chat,
                          color: const Color(0xFF25D366),
                          label: 'WhatsApp',
                        ),
                        _socialButton(
                          icon: Icons.facebook,
                          color: const Color(0xFF1877F2),
                          label: 'Facebook',
                        ),
                        _socialButton(
                          icon: Icons.email,
                          color: Colors.redAccent,
                          label: 'Gmail',
                        ),
                        _socialButton(
                          icon: Icons.more_horiz,
                          color: Colors.grey[700]!,
                          label: 'More',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Options Menu List
              _menuTile(
                icon: Icons.check,
                title: 'My List',
                onTap: () {},
              ),
              const Divider(color: Colors.grey, height: 1),
              _menuTile(
                title: 'App Settings',
                onTap: () {},
              ),
              _menuTile(
                title: 'Account',
                onTap: () {},
              ),
              _menuTile(
                title: 'Help',
                onTap: () {},
              ),
              _menuTile(
                title: 'Sign Out',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPageScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
      ],
    );
  }

  Widget _menuTile({
    IconData? icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      leading: icon != null ? Icon(icon, color: Colors.white, size: 20) : null,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
