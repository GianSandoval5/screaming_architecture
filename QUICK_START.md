# 🚀 Quick Start Guide

Una guía de 5 minutos para comenzar con Screaming Architecture.

## ⚡ Instalación Rápida

```bash
# 1. Añade el package a tu proyecto
flutter pub add screaming_architecture

# O instala globalmente
dart pub global activate screaming_architecture
```

## 🎯 Uso Básico

### Opción 1: Generar estructura por defecto

```bash
# En la raíz de tu proyecto Flutter
dart run screaming_architecture:screaming_architecture

# Esto crea:
# ✓ Módulos: auth, home, profile
# ✓ Estructura completa de carpetas
# ✓ Archivos de ejemplo listos para usar
```

### Opción 2: Personalizar módulos

```bash
# Define tus propios módulos
dart run screaming_architecture:screaming_architecture \
  --modules auth,products,cart,orders,profile

# Con ruta personalizada
dart run screaming_architecture:screaming_architecture \
  --path src \
  --modules auth,home
```

### Opción 3: Usar en código

```dart
import 'package:screaming_architecture/screaming_architecture.dart';

void main() async {
  final structure = FolderStructure(
    basePath: 'lib',
    modules: ['auth', 'products', 'cart'],
    includeShared: true,
    includeExamples: true,
  );

  final generator = ArchitectureGenerator(structure);
  await generator.generate();
}
```

## 📁 Estructura Generada

Después de ejecutar el comando, tendrás:

```
lib/
├── modules/              # Tus features de negocio
│   ├── auth/
│   │   ├── presentation/ # UI (Pages, Widgets)
│   │   ├── domain/       # Lógica de negocio
│   │   ├── data/         # Acceso a datos
│   │   └── routes/       # Rutas del módulo
│   ├── home/
│   └── profile/
│
├── shared/               # Código reutilizable
│   ├── widgets/
│   ├── utils/
│   ├── extensions/
│   ├── constants/
│   └── theme/
│
├── core/                 # Configuración de la app
│   ├── config/
│   ├── di/
│   ├── network/
│   ├── errors/
│   └── routes/
│
└── app/
    └── app.dart          # Widget principal
```

## 🎨 Primer Paso: Conectar la App

### 1. Actualiza tu `main.dart`

```dart
import 'package:flutter/material.dart';
import 'app/app.dart';
import 'core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa dependencias
  await initializeDependencies();

  runApp(const MyApp());
}
```

### 2. El archivo `app/app.dart` ya está listo

```dart
import 'package:flutter/material.dart';
import '../shared/theme/app_theme.dart';
import '../core/routes/app_routes.dart';

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
    );
  }
}
```

### 3. Define tus rutas en `core/routes/app_routes.dart`

```dart
import 'package:flutter/material.dart';
import '../../modules/auth/presentation/pages/auth_page.dart';
import '../../modules/home/presentation/pages/home_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String auth = '/auth';

  static Map<String, WidgetBuilder> get routes => {
        home: (context) => const HomePage(),
        auth: (context) => const AuthPage(),
      };
}
```

## 🧩 Agregar un Nuevo Módulo

### Opción 1: Manualmente

```bash
# Crea la estructura de carpetas
mkdir -p lib/modules/settings/{presentation,domain,data}/

# Crea archivos base
touch lib/modules/settings/presentation/pages/settings_page.dart
```

### Opción 2: Re-ejecuta el generador

```bash
dart run screaming_architecture:screaming_architecture \
  --modules auth,home,profile,settings
```

## 🔌 Integrar State Management

### Con BLoC

```bash
# Instala BLoC
flutter pub add flutter_bloc

# Crea tu BLoC en el módulo
# lib/modules/auth/presentation/bloc/auth_bloc.dart
```

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/login_usecase.dart';

// Events
abstract class AuthEvent {}
class LoginRequested extends AuthEvent {
  final String email, password;
  LoginRequested(this.email, this.password);
}

// States
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      // Implementa lógica aquí
    });
  }
}
```

### Con Riverpod

```bash
flutter pub add flutter_riverpod
```

```dart
// lib/modules/auth/presentation/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.initial());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    // Implementa lógica aquí
  }
}
```

## 🧪 Testing

Los archivos generados ya están listos para testing:

```bash
# Run tests
flutter test

# Run tests con cobertura
flutter test --coverage
```

### Ejemplo de test

```dart
// test/modules/auth/domain/usecases/login_usecase_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('LoginUseCase debe retornar User cuando credenciales son correctas', () async {
    // Arrange
    final usecase = LoginUseCase(mockRepository);

    // Act
    final result = await usecase('test@test.com', 'password');

    // Assert
    expect(result.isRight(), true);
  });
}
```

## 🎓 Próximos Pasos

1. **Lee la documentación completa**: [README.md](README.md)
2. **Revisa las mejores prácticas**: [BEST_PRACTICES.md](BEST_PRACTICES.md)
3. **Entiende la arquitectura visual**: [ARCHITECTURE_VISUAL.md](ARCHITECTURE_VISUAL.md)
4. **Explora las mejoras futuras**: [IMPROVEMENTS.md](IMPROVEMENTS.md)
5. **Lee el CHANGELOG**: [CHANGELOG.md](CHANGELOG.md)

## 📚 Recursos Adicionales

### Ejemplos Completos

Revisa la carpeta `example/` para ver implementaciones completas:

```bash
cd example
dart screaming_architecture_example.dart
```

### Configuración Avanzada

Usa el archivo de configuración YAML:

```bash
# Copia el ejemplo
cp screaming_config.yaml.example screaming_config.yaml

# Edita según tus necesidades
# Luego ejecuta con la configuración
dart run screaming_architecture:screaming_architecture --config screaming_config.yaml
```

## 🆘 Solución de Problemas

### Error: "Module already exists"

```bash
# Si ya existe la estructura, usa --force (próximamente)
# O elimina manualmente las carpetas que quieres regenerar
rm -rf lib/modules/auth
dart run screaming_architecture:screaming_architecture --modules auth
```

### Error: "Cannot find package"

```bash
# Asegúrate de ejecutar desde la raíz del proyecto
cd /path/to/your/project
flutter pub get
```

### Personalizar templates

Los templates están en `lib/src/templates/file_templates.dart`.
Puedes modificarlos según tus necesidades.

## 💡 Tips Rápidos

1. **Empieza pequeño**: Comienza con 2-3 módulos y ve creciendo
2. **Usa barrel files**: Exporta todo desde `module_name_module.dart`
3. **Mantén Domain puro**: Sin dependencias de Flutter en domain/
4. **Tests primero**: Escribe tests para domain layer primero
5. **Shared vs Core**: Shared = reutilizable, Core = configuración

## 🎉 ¡Listo!

Ya tienes una estructura profesional y escalable para tu app Flutter.

**Siguiente paso:** Comienza a implementar tu primera feature en el módulo `auth`.

---

**¿Necesitas ayuda?**

- 📧 Email: giansando2022@gmail.com
- 🐙 GitHub Issues: [github.com/GianSandoval5/screaming_architecture/issues](https://github.com/GianSandoval5/screaming_architecture/issues)
- 📚 Documentación: Consulta los archivos README.md y BEST_PRACTICES.md
