import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;

  const ProfileCard({super.key, required this.name, this.onTap});

  Color _getProfileColor(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('emenalo') || lower.contains('user 1')) {
      return const Color(0xFF1E88E5); // Blue
    } else if (lower.contains('onyeka') || lower.contains('user 2')) {
      return const Color(0xFFFBC02D); // Yellow
    } else if (lower.contains('thelma') || lower.contains('user 3')) {
      return const Color(0xFFE53935); // Red
    }
    return const Color(0xFF1E88E5); // Fallback Blue
  }

  @override
  Widget build(BuildContext context) {
    final isKids = name.toLowerCase() == 'kids';
    final profileColor = _getProfileColor(name);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: isKids ? null : profileColor,
              gradient: isKids
                  ? const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xFF9C27B0),
                        Color(0xFF3F51B5),
                        Color(0xFF03A9F4),
                        Color(0xFF4CAF50),
                      ],
                    )
                  : null,
            ),
            child: isKids
                ? Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFFFEB3B), Color(0xFFFFC107)],
                      ).createShader(bounds),
                      child: const Text(
                        'kids',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      // Left Eye
                      Positioned(
                        left: 24,
                        top: 26,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Right Eye
                      Positioned(
                        right: 24,
                        top: 26,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Smooth Smile Arc
                      Positioned(
                        left: 25,
                        right: 25,
                        bottom: 28,
                        child: CustomPaint(
                          size: const Size(50, 16),
                          painter: SmilePainter(),
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class SmilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width / 2, size.height * 1.3, size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
