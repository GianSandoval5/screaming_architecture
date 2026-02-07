# 🎯 Best Practices & Recommendations

## 📋 Tabla de Contenidos

- [Organización de Módulos](#organización-de-módulos)
- [Clean Architecture](#clean-architecture)
- [Naming Conventions](#naming-conventions)
- [State Management](#state-management)
- [Testing](#testing)
- [Performance](#performance)

## 🗂️ Organización de Módulos

### ¿Cuándo crear un nuevo módulo?

Crea un nuevo módulo cuando:

- ✅ Representa una **feature de negocio** independiente
- ✅ Puede ser **desarrollado y testeado** de forma aislada
- ✅ Tiene su **propio flujo de navegación**
- ✅ Podría **reutilizarse** en otro proyecto

❌ No crees un módulo si:

- Es solo un componente UI genérico → `shared/widgets/`
- Es una utilidad sin lógica de negocio → `shared/utils/`
- Es parte integral de otro módulo

### Ejemplo: E-commerce

```
modules/
├── auth/           # Login, registro, recuperación
├── catalog/        # Navegación y búsqueda de productos
├── product/        # Detalle individual de producto
├── cart/           # Gestión del carrito
├── checkout/       # Proceso de pago
├── orders/         # Historial y tracking
└── profile/        # Perfil y configuración del usuario
```

## 🏛️ Clean Architecture

### Regla de Dependencia

```
Presentation → Domain ← Data
     ↓           ↓        ↓
  Widgets    Entities  Models
 BLoCs/VMs   UseCases  DataSources
```

**Reglas:**

1. `Domain` NO depende de nadie
2. `Data` depende de `Domain`
3. `Presentation` depende de `Domain`
4. Las dependencias apuntan **hacia dentro**

### Ejemplo de Flujo

```dart
// 1. Usuario interacciona con UI
UserLoginPage → emits event

// 2. BLoC maneja el evento
LoginBloc → calls usecase

// 3. UseCase ejecuta lógica
LoginUseCase → calls repository (interface)

// 4. Repository implementación accede a datos
AuthRepositoryImpl → calls datasource

// 5. DataSource hace la llamada real
AuthRemoteDataSource → HTTP request

// 6. Respuesta viaja de vuelta
HTTP → DataSource → Repository → UseCase → BLoC → UI
```

## 📝 Naming Conventions

### Archivos y Carpetas

```dart
// ✅ BIEN: snake_case para archivos
user_profile_page.dart
auth_repository.dart
get_user_usecase.dart

// ❌ MAL: PascalCase, camelCase
UserProfilePage.dart
authRepository.dart
GetUserUseCase.dart
```

### Clases

```dart
// ✅ BIEN: PascalCase
class UserProfilePage extends StatelessWidget {}
class AuthRepository {}
class GetUserUseCase {}

// Sufijos descriptivos
class LoginBloc extends Bloc {}          // Para BLoC
class UserEntity {}                       // Para entities
class UserModel extends UserEntity {}     // Para models
class AuthRepositoryImpl implements AuthRepository {} // Para implementaciones
```

### Variables y Funciones

```dart
// ✅ BIEN: camelCase
final userName = 'John';
void fetchUserData() {}

// ❌ MAL
final UserName = 'John';
final user_name = 'John';
```

## 🎛️ State Management

### Recomendaciones por Complejidad

#### Simple (Settings, Perfil estático)

```dart
// StatefulWidget simple
class SettingsPage extends StatefulWidget {
  // Estado local simple
}
```

#### Medio (Forms, listas con filtros)

```dart
// Provider o Riverpod
final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});
```

#### Complejo (Features con mucha lógica)

```dart
// BLoC Pattern
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }
}
```

### Integración en Módulos

```
auth/
├── presentation/
│   ├── bloc/              # Si usas BLoC
│   │   └── auth_bloc.dart
│   ├── providers/         # Si usas Riverpod
│   │   └── auth_provider.dart
│   └── pages/
└── ...
```

## 🧪 Testing

### Estructura de Tests

```
test/
├── modules/
│   ├── auth/
│   │   ├── presentation/
│   │   │   └── bloc/
│   │   │       └── auth_bloc_test.dart
│   │   ├── domain/
│   │   │   └── usecases/
│   │   │       └── login_usecase_test.dart
│   │   └── data/
│   │       └── repositories/
│   │           └── auth_repository_impl_test.dart
│   └── ...
└── shared/
    └── utils/
        └── validators_test.dart
```

### Pirámide de Testing

```
       🔺
      /  \     70% Unit Tests
     /____\    (UseCases, Repositories, Utils)
    /      \
   /________\  20% Widget Tests
  /          \ (Presentation layer)
 /____________\
     10% Integration Tests
     (Full user flows)
```

### Ejemplo de Test

```dart
// domain/usecases/login_usecase_test.dart
void main() {
  late LoginUseCase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = LoginUseCase(mockRepository);
  });

  test('should return User when credentials are correct', () async {
    // Arrange
    final email = 'test@example.com';
    final password = 'password123';
    final expectedUser = User(id: '1', email: email);

    when(() => mockRepository.login(email, password))
        .thenAnswer((_) async => Right(expectedUser));

    // Act
    final result = await usecase(email, password);

    // Assert
    expect(result, Right(expectedUser));
    verify(() => mockRepository.login(email, password)).called(1);
  });
}
```

## ⚡ Performance

### Lazy Loading de Módulos

```dart
// app/app.dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // No cargar todos los módulos al inicio
      onGenerateRoute: (settings) {
        // Carga bajo demanda
        if (settings.name?.startsWith('/products') ?? false) {
          return MaterialPageRoute(
            builder: (_) => const ProductsModule(),
          );
        }
        // ...
      },
    );
  }
}
```

### Code Splitting

```dart
// Usa imports diferidos para módulos grandes
import 'package:myapp/modules/analytics/analytics_module.dart' deferred as analytics;

// Carga cuando sea necesario
void loadAnalytics() async {
  await analytics.loadLibrary();
  analytics.initialize();
}
```

### Optimización de Assets

```
modules/
└── products/
    └── assets/          # Assets específicos del módulo
        ├── images/
        └── icons/

shared/
└── assets/              # Assets globales
    └── images/
```

```yaml
# pubspec.yaml
flutter:
  assets:
    - lib/modules/products/assets/images/
    - lib/shared/assets/images/
```

## 🔒 Manejo de Errores

### Failures en Domain Layer

```dart
// core/errors/failures.dart
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}
```

### Either para Results

```dart
// Usa Either de dartz o fpdart
import 'package:dartz/dartz.dart';

// Repository
abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
}

// UseCase
class LoginUseCase {
  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}

// BLoC
on<LoginRequested>((event, emit) async {
  emit(LoginLoading());

  final result = await loginUseCase(event.email, event.password);

  result.fold(
    (failure) => emit(LoginError(failure.message)),
    (user) => emit(LoginSuccess(user)),
  );
});
```

## 📦 Dependency Injection

### Recomendación: get_it

```dart
// core/di/injection_container.dart
final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External
  sl.registerLazySingleton(() => http.Client());

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // BLoC
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));
}

// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(MyApp());
}
```

## 🌐 Internationalization (i18n)

### Estructura

```
modules/
└── auth/
    └── l10n/
        ├── auth_en.arb
        ├── auth_es.arb
        └── auth_localizations.dart

shared/
└── l10n/
    ├── app_en.arb
    ├── app_es.arb
    └── app_localizations.dart
```

## 🎨 Theming

### Por Módulo

```dart
// modules/auth/presentation/theme/auth_theme.dart
class AuthTheme {
  static const primaryColor = Color(0xFF1976D2);

  static InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    );
  }
}
```

### Global

```dart
// shared/theme/app_theme.dart
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  );
}
```

---

## 📚 Recursos Recomendados

- [Reso Coder - Flutter Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)
- [Flutter Architecture Samples](https://github.com/brianegan/flutter_architecture_samples)
- [Very Good Ventures - Best Practices](https://verygood.ventures/blog)

---

**¿Preguntas o sugerencias?**

- 🐙 Repositorio: [github.com/GianSandoval5/screaming_architecture](https://github.com/GianSandoval5/screaming_architecture)
- 📧 Email: giansando2022@gmail.com
- 💼 LinkedIn: [linkedin.com/in/giansandoval](https://linkedin.com/in/giansandoval)
