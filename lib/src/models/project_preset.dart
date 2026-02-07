/// Predefined project presets for common app types
enum ProjectPreset {
  /// E-commerce application preset
  ecommerce,

  /// Social media application preset
  social,

  /// Enterprise/Business application preset
  enterprise,

  /// Minimal starter preset
  minimal,

  /// Custom preset (user defines modules)
  custom,
}

/// Extension to get preset configurations
extension ProjectPresetExtension on ProjectPreset {
  /// Get module names for this preset
  List<String> get modules {
    switch (this) {
      case ProjectPreset.ecommerce:
        return [
          'auth',
          'products',
          'cart',
          'checkout',
          'orders',
          'profile',
          'wishlist',
          'reviews',
        ];
      case ProjectPreset.social:
        return [
          'auth',
          'feed',
          'profile',
          'chat',
          'notifications',
          'search',
          'friends',
          'posts',
        ];
      case ProjectPreset.enterprise:
        return [
          'auth',
          'dashboard',
          'analytics',
          'reports',
          'settings',
          'users',
          'notifications',
        ];
      case ProjectPreset.minimal:
        return ['auth', 'home', 'profile'];
      case ProjectPreset.custom:
        return [];
    }
  }

  /// Get description for this preset
  String get description {
    switch (this) {
      case ProjectPreset.ecommerce:
        return 'E-commerce app with products, cart, checkout, and orders';
      case ProjectPreset.social:
        return 'Social media app with feed, chat, and friends';
      case ProjectPreset.enterprise:
        return 'Enterprise app with dashboard, analytics, and reports';
      case ProjectPreset.minimal:
        return 'Minimal starter with auth, home, and profile';
      case ProjectPreset.custom:
        return 'Custom modules defined by user';
    }
  }

  /// Get emoji for this preset
  String get emoji {
    switch (this) {
      case ProjectPreset.ecommerce:
        return '🛒';
      case ProjectPreset.social:
        return '👥';
      case ProjectPreset.enterprise:
        return '🏢';
      case ProjectPreset.minimal:
        return '⚡';
      case ProjectPreset.custom:
        return '🎨';
    }
  }
}
