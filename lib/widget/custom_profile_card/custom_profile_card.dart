import 'dart:math';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;

  const ProfileCard({super.key, required this.name, this.onTap});

  Color _randomColor() {
    final random = Random();

    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = _randomColor();

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Stack(
              children: [
                Positioned(left: 22, top: 22, child: _eye()),
                Positioned(right: 22, top: 22, child: _eye()),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      '⌣',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _eye() {
    return Container(
      width: 7,
      height: 7,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
