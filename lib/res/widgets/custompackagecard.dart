import 'package:flutter/material.dart';
import 'package:mychoice/res/constants/colors.dart';

class PackageCard extends StatelessWidget {
  final String title;
  final double rating;
  final int reviewCount;
  final int price;
  final String duration;
  final List<String> services;
  final Color borderColor;
  final VoidCallback ontap;

  const PackageCard({
    required this.title,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.duration,
    required this.services,
    this.borderColor = Appcolor.primarycolor,
    required this.ontap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 8),
              blurRadius: 24,
              color: Color(0x1A000000),
            ),
          ],
          border: Border.all(color: const Color(0x11000000)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: BoxDecoration(
                color: borderColor.withOpacity(0.15),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: borderColor, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.check_circle,
                      color: borderColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title, // your title
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: borderColor.darken(0.4),
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₹$price • $duration',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Appcolor.blackcolor,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        '$rating (${reviewCount.toString()} reviews)',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Appcolor.blackcolor.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  ...services.map(
                    (s) => Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: TextStyle(height: 1.3)),
                          Expanded(
                            child: Text(
                              s,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Appcolor.blackcolor.withOpacity(0.85),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton(
                      onPressed: ontap,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Appcolor.blackcolor.withOpacity(0.15),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        backgroundColor: const Color(0xFFF7F7F8),
                      ),
                      child: Text(
                        'Edit your package',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Appcolor.blackcolor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension _ColorX on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
