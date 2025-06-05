import 'package:cached_network_image/cached_network_image.dart';
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
          child: _buildCountryAvatar(context),
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

  Widget _buildCountryAvatar(BuildContext context) {
    final hasLogo = country.flagUrl != null && country.flagUrl!.isNotEmpty;
    
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
      child: hasLogo
          ? CachedNetworkImage(
              imageUrl: country.flagUrl!,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
              placeholder: (context, url) => const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => _buildFallbackText(),
            )
          : _buildFallbackText(),
    );
  }

  Widget _buildFallbackText() {
    return Text(
      country.name.substring(0, 1).toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}