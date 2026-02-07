/// Templates for generated files
class FileTemplates {
  FileTemplates._();

  static String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String _pascalCase(String text) {
    return text.split('_').map(_capitalize).join();
  }

  // Module barrel file
  static String moduleBarrelFile(String moduleName) =>
      '''
// ${_capitalize(moduleName)} Module
// Export all public APIs from this module

// Presentation layer
export 'presentation/pages/${moduleName}_page.dart';
export 'presentation/widgets/${moduleName}_widget.dart';

// Domain layer
export 'domain/entities/${moduleName}_entity.dart';
export 'domain/repositories/${moduleName}_repository.dart';
export 'domain/usecases/get_$moduleName.dart';

// Routes
export 'routes/${moduleName}_routes.dart';
''';

  // Page template
  static String pageTemplate(String moduleName) =>
      '''
import 'package:flutter/material.dart';

/// ${_capitalize(moduleName)} page
class ${_pascalCase(moduleName)}Page extends StatelessWidget {
  const ${_pascalCase(moduleName)}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${_capitalize(moduleName)}'),
      ),
      body: const Center(
        child: Text('${_capitalize(moduleName)} Page'),
      ),
    );
  }
}
''';

  // Widget template
  static String widgetTemplate(String moduleName) =>
      '''
import 'package:flutter/material.dart';

/// ${_capitalize(moduleName)} widget
class ${_pascalCase(moduleName)}Widget extends StatelessWidget {
  const ${_pascalCase(moduleName)}Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('${_capitalize(moduleName)} Widget'),
    );
  }
}
''';

  // Entity template
  static String entityTemplate(String moduleName) =>
      '''
/// ${_capitalize(moduleName)} entity
class ${_pascalCase(moduleName)}Entity {
  final String id;
  final String name;

  const ${_pascalCase(moduleName)}Entity({
    required this.id,
    required this.name,
  });
}
''';

  // Repository template
  static String repositoryTemplate(String moduleName) =>
      '''
import '../entities/${moduleName}_entity.dart';

/// ${_capitalize(moduleName)} repository interface
abstract class ${_pascalCase(moduleName)}Repository {
  Future<${_pascalCase(moduleName)}Entity> get${_pascalCase(moduleName)}(String id);
  Future<List<${_pascalCase(moduleName)}Entity>> getAll${_pascalCase(moduleName)}s();
}
''';

  // Use case template
  static String usecaseTemplate(String moduleName) =>
      '''
import '../entities/${moduleName}_entity.dart';
import '../repositories/${moduleName}_repository.dart';

/// Use case for getting $moduleName
class Get${_pascalCase(moduleName)} {
  final ${_pascalCase(moduleName)}Repository repository;

  const Get${_pascalCase(moduleName)}(this.repository);

  Future<${_pascalCase(moduleName)}Entity> call(String id) {
    return repository.get${_pascalCase(moduleName)}(id);
  }
}
''';

  // Model template
  static String modelTemplate(String moduleName) =>
      '''
import '../../domain/entities/${moduleName}_entity.dart';

/// ${_capitalize(moduleName)} data model
class ${_pascalCase(moduleName)}Model extends ${_pascalCase(moduleName)}Entity {
  const ${_pascalCase(moduleName)}Model({
    required super.id,
    required super.name,
  });

  factory ${_pascalCase(moduleName)}Model.fromJson(Map<String, dynamic> json) {
    return ${_pascalCase(moduleName)}Model(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
''';

  // Datasource template
  static String datasourceTemplate(String moduleName) =>
      '''
import '../models/${moduleName}_model.dart';

/// ${_capitalize(moduleName)} remote data source
abstract class ${_pascalCase(moduleName)}RemoteDataSource {
  Future<${_pascalCase(moduleName)}Model> get${_pascalCase(moduleName)}(String id);
  Future<List<${_pascalCase(moduleName)}Model>> getAll${_pascalCase(moduleName)}s();
}

/// Implementation of ${_capitalize(moduleName)} remote data source
class ${_pascalCase(moduleName)}RemoteDataSourceImpl implements ${_pascalCase(moduleName)}RemoteDataSource {
  // final ApiClient apiClient;

  // const ${_pascalCase(moduleName)}RemoteDataSourceImpl(this.apiClient);

  @override
  Future<${_pascalCase(moduleName)}Model> get${_pascalCase(moduleName)}(String id) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<List<${_pascalCase(moduleName)}Model>> getAll${_pascalCase(moduleName)}s() async {
    // TODO: Implement API call
    throw UnimplementedError();
  }
}
''';

  // Repository implementation template
  static String repositoryImplTemplate(String moduleName) =>
      '''
import '../../domain/entities/${moduleName}_entity.dart';
import '../../domain/repositories/${moduleName}_repository.dart';
import '../datasources/${moduleName}_remote_datasource.dart';

/// Implementation of ${_capitalize(moduleName)} repository
class ${_pascalCase(moduleName)}RepositoryImpl implements ${_pascalCase(moduleName)}Repository {
  final ${_pascalCase(moduleName)}RemoteDataSource remoteDataSource;

  const ${_pascalCase(moduleName)}RepositoryImpl(this.remoteDataSource);

  @override
  Future<${_pascalCase(moduleName)}Entity> get${_pascalCase(moduleName)}(String id) {
    return remoteDataSource.get${_pascalCase(moduleName)}(id);
  }

  @override
  Future<List<${_pascalCase(moduleName)}Entity>> getAll${_pascalCase(moduleName)}s() {
    return remoteDataSource.getAll${_pascalCase(moduleName)}s();
  }
}
''';

  // Routes template
  static String routesTemplate(String moduleName) =>
      '''
import 'package:flutter/material.dart';
import '../presentation/pages/${moduleName}_page.dart';

/// ${_capitalize(moduleName)} routes
class ${_pascalCase(moduleName)}Routes {
  static const String $moduleName = '/$moduleName';

  static Map<String, WidgetBuilder> get routes => {
        $moduleName: (context) => const ${_pascalCase(moduleName)}Page(),
      };
}
''';

  // Shared widget template
  static const String sharedWidgetTemplate = '''
import 'package:flutter/material.dart';

/// Custom button widget
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(text),
    );
  }
}
''';

  // Validators template
  static const String validatorsTemplate = '''
/// Utility class for form validators
class Validators {
  Validators._();

  /// Email validator
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}\$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  /// Required field validator
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  /// Minimum length validator
  static String? minLength(String? value, int minLength) {
    if (value == null || value.length < minLength) {
      return 'Minimum length is \$minLength characters';
    }
    return null;
  }
}
''';

  // Extensions template
  static const String extensionsTemplate = '''
/// String extensions
extension StringExtensions on String {
  /// Capitalizes first letter
  String capitalize() {
    if (isEmpty) return this;
    return '\${this[0].toUpperCase()}\${substring(1)}';
  }

  /// Checks if string is a valid email
  bool get isValidEmail {
    final emailRegex = RegExp(r'^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}\$');
    return emailRegex.hasMatch(this);
  }

  /// Truncates string with ellipsis
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '\${substring(0, maxLength)}...';
  }
}
''';

  // Constants template
  static const String constantsTemplate = '''
/// Application constants
class AppConstants {
  AppConstants._();

  /// API related constants
  static const String baseUrl = 'https://api.example.com';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  /// Storage keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';

  /// App info
  static const String appName = 'My App';
  static const String version = '1.0.0';
}
''';

  // Theme template
  static const String themeTemplate = '''
import 'package:flutter/material.dart';

/// Application theme configuration
class AppTheme {
  AppTheme._();

  /// Light theme
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      );

  /// Dark theme
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      );
}
''';

  // App config template
  static const String configTemplate = '''
/// Application configuration
class AppConfig {
  final String apiUrl;
  final String environment;
  final bool enableLogging;

  const AppConfig({
    required this.apiUrl,
    required this.environment,
    this.enableLogging = false,
  });

  /// Development configuration
  static const AppConfig development = AppConfig(
    apiUrl: 'https://dev-api.example.com',
    environment: 'development',
    enableLogging: true,
  );

  /// Production configuration
  static const AppConfig production = AppConfig(
    apiUrl: 'https://api.example.com',
    environment: 'production',
    enableLogging: false,
  );
}
''';

  // Dependency injection template
  static const String diTemplate = '''
/// Dependency injection container
/// 
/// Initialize this before running the app:
/// ```dart
/// await initializeDependencies();
/// runApp(MyApp());
/// ```
class InjectionContainer {
  InjectionContainer._();

  static final Map<Type, dynamic> _dependencies = {};

  /// Register a dependency
  static void register<T>(T dependency) {
    _dependencies[T] = dependency;
  }

  /// Get a dependency
  static T get<T>() {
    final dependency = _dependencies[T];
    if (dependency == null) {
      throw Exception('Dependency of type \$T not found');
    }
    return dependency as T;
  }

  /// Clear all dependencies
  static void clear() {
    _dependencies.clear();
  }
}

/// Initialize all dependencies
Future<void> initializeDependencies() async {
  // Register your dependencies here
  // Example:
  // InjectionContainer.register<ApiClient>(ApiClient());
}
''';

  // Network template
  static const String networkTemplate = '''
import 'dart:convert';
import 'package:http/http.dart' as http;

/// API client for network requests
class ApiClient {
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  ApiClient({
    required this.baseUrl,
    this.defaultHeaders = const {},
  });

  /// GET request
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final response = await http.get(
      Uri.parse('\$baseUrl\$endpoint'),
      headers: {...defaultHeaders, ...?headers},
    );

    return _handleResponse(response);
  }

  /// POST request
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final response = await http.post(
      Uri.parse('\$baseUrl\$endpoint'),
      headers: {
        ...defaultHeaders,
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: body != null ? jsonEncode(body) : null,
    );

    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Request failed with status: \${response.statusCode}');
    }
  }
}
''';

  // Failures template
  static const String failuresTemplate = '''
/// Base failure class
abstract class Failure {
  final String message;

  const Failure(this.message);
}

/// Server failure
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

/// Cache failure
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

/// Network failure
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network connection failed']);
}

/// Validation failure
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed']);
}
''';

  // App routes template
  static const String appRoutesTemplate = '''
import 'package:flutter/material.dart';

/// Central route management
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String splash = '/splash';

  /// Get all routes from modules
  static Map<String, WidgetBuilder> get routes => {
        home: (context) => const Placeholder(), // Replace with your home page
        splash: (context) => const Placeholder(), // Replace with your splash page
        // Add routes from modules here
      };

  /// Navigation helper
  static void navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  /// Navigation with replacement
  static void navigateAndReplace(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }
}
''';

  // App file template
  static const String appFile = '''
import 'package:flutter/material.dart';
import '../shared/theme/app_theme.dart';
import '../core/routes/app_routes.dart';

/// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screaming Architecture App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.home,
      debugShowCheckedModeBanner: false,
    );
  }
}
''';
}
