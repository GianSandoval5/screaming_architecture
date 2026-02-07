/// State management options for project generation
enum StateManagement {
  /// No state management
  none,

  /// BLoC pattern
  bloc,

  /// Riverpod
  riverpod,

  /// Provider
  provider,

  /// GetX
  getx,
}

/// Extension for state management configurations
extension StateManagementExtension on StateManagement {
  /// Get package name
  String get packageName {
    switch (this) {
      case StateManagement.none:
        return '';
      case StateManagement.bloc:
        return 'flutter_bloc';
      case StateManagement.riverpod:
        return 'flutter_riverpod';
      case StateManagement.provider:
        return 'provider';
      case StateManagement.getx:
        return 'get';
    }
  }

  /// Get description
  String get description {
    switch (this) {
      case StateManagement.none:
        return 'No state management (StatefulWidget only)';
      case StateManagement.bloc:
        return 'BLoC pattern (flutter_bloc)';
      case StateManagement.riverpod:
        return 'Riverpod (flutter_riverpod)';
      case StateManagement.provider:
        return 'Provider';
      case StateManagement.getx:
        return 'GetX (get)';
    }
  }

  /// Check if should generate state management files
  bool get hasStateManagement => this != StateManagement.none;
}
