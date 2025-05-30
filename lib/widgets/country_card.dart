import 'package:flutter/material.dart';
import 'package:my_sports_app/models/sport.dart';

class CountryCard extends StatelessWidget {
  final Country country;
  final String? flagUrl;
  final VoidCallback onTap;

  const CountryCard({
    super.key,
    required this.country,
    required this.onTap, 
    this.flagUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: flagUrl != null && flagUrl!.isNotEmpty
              ? Image.network(
                  flagUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint('Image load failed: $error');
                    return const Icon(Icons.flag, size: 20);
                  },
                )
              : const Icon(Icons.flag, size: 20),
        ),

        title: Text(
          country.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}