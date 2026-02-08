# 🏗️ Screaming Architecture

[![pub package](https://img.shields.io/pub/v/screaming_architecture.svg)](https://pub.dev/packages/screaming_architecture)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Screaming Architecture** es un package de Dart/Flutter que te ayuda a estructurar tu proyecto siguiendo el patrón de **Arquitectura que Grita** (Screaming Architecture), donde la estructura de carpetas comunica claramente el dominio de negocio y las características de tu aplicación.

## 🎯 ¿Qué es Screaming Architecture?

Acuñado por Robert C. Martin (Uncle Bob), el principio de Screaming Architecture sugiere que cuando miras la estructura de un proyecto, debería **"gritar"** sobre qué trata la aplicación, no sobre qué frameworks usa.

En lugar de ver:

```
lib/
  ├── components/
  ├── pages/
  ├── services/
  └── utils/
```

Deberías ver:

```
lib/
  ├── modules/
  │   ├── auth/          # ¡Esto es una app de autenticación!
  │   ├── products/      # ¡Maneja productos!
  │   ├── orders/        # ¡Procesa órdenes!
  │   └── profile/       # ¡Tiene perfiles de usuario!
```

## ✨ Características

- 🎯 **Orientado al Dominio**: La estructura refleja las características de negocio
- 📦 **Modular**: Cada módulo es independiente y autocontenido
- 🧩 **Clean Architecture**: Implementa separación por capas (Presentation, Domain, Data)
- 🚀 **Generación Automática**: Crea toda la estructura con un solo comando
- 📝 **Archivos de Ejemplo**: Incluye templates listos para usar
- ⚙️ **Configurable**: Personaliza módulos, capas y estructura
- 🎨 **Presets Incluidos**: E-commerce, Social Media, Enterprise, Minimal
- 🎛️ **State Management**: Soporte para BLoC, Riverpod, Provider, GetX
- 🧪 **Tests Automáticos**: Genera estructura completa de tests con mocktail
- 🎯 **Modo Interactivo**: CLI intuitivo para configuración guiada

## 🏛️ Arquitectura Generada

```
lib/
├── modules/                    # Módulos de negocio (Features/Domain)
│   ├── auth/                   # Módulo de autenticación
│   │   ├── presentation/       # Capa de presentación
│   │   │   ├── pages/          # Páginas/Screens
│   │   │   └── widgets/        # Widgets específicos del módulo
│   │   ├── domain/             # Capa de dominio (Lógica de negocio)
│   │   │   ├── entities/       # Entidades de negocio
│   │   │   ├── repositories/   # Interfaces de repositorios
│   │   │   └── usecases/       # Casos de uso
│   │   ├── data/               # Capa de datos
│   │   │   ├── datasources/    # Fuentes de datos (API, BD local)
│   │   │   ├── models/         # Modelos de datos (DTOs)
│   │   │   └── repositories/   # Implementaciones de repositorios
│   │   └── routes/             # Rutas del módulo
│   │
│   ├── products/               # Otro módulo...
│   ├── orders/
│   └── profile/
│
├── shared/                     # Componentes compartidos
│   ├── widgets/                # Widgets reutilizables
│   ├── utils/                  # Utilidades generales
│   ├── extensions/             # Extensiones de Dart
│   ├── constants/              # Constantes de la app
│   └── theme/                  # Temas y estilos
│
├── core/                       # Núcleo de la aplicación
│   ├── config/                 # Configuración
│   ├── di/                     # Inyección de dependencias
│   ├── network/                # Cliente HTTP/API
│   ├── errors/                 # Manejo de errores
│   └── routes/                 # Rutas principales
│
└── app/                        # Punto de entrada
    └── app.dart                # Widget principal de la app
```

## 📦 Instalación

Añade el package a tu proyecto:

```bash
flutter pub add screaming_architecture
```

O manualmente en `pubspec.yaml`:

```yaml
dependencies:
  screaming_architecture: ^1.0.2 # Usa la última versión disponible en pub.dev
```

O instala globalmente para usar el CLI:

```bash
dart pub global activate screaming_architecture
```

## 🚀 Uso Rápido

### Opción 1: Modo Interactivo (Recomendado)

```bash
# Ejecuta el generador en modo interactivo
dart run screaming_architecture:screaming_architecture -i

# Te guiará paso a paso:
# 1. Selecciona un preset (E-commerce, Social, Enterprise, Minimal, Custom)
# 2. Elige state management (None, BLoC, Riverpod, Provider, GetX)
# 3. Configura opciones (ejemplos, tests)
```

### Opción 2: CLI con Presets

```bash
# E-commerce con BLoC y tests
dart run screaming_architecture:screaming_architecture \\
  --preset ecommerce --state bloc --tests

# Social media con Riverpod
dart run screaming_architecture:screaming_architecture \\
  --preset social --state riverpod --tests

# Enterprise con Provider
dart run screaming_architecture:screaming_architecture \\
  --preset enterprise --state provider

# Minimal con GetX
dart run screaming_architecture:screaming_architecture \\
  --preset minimal --state getx
```

### Opción 3: CLI Personalizado

```bash
# Módulos custom con state management
dart run screaming_architecture:screaming_architecture \\
  --modules auth,products,cart,orders \\
  --state bloc \\
  --tests

# Sin ejemplos
dart run screaming_architecture:screaming_architecture \\
  --modules auth,home \\
  --no-examples

# Ver todas las opciones
dart run screaming_architecture:screaming_architecture --help
```

### Opción 4: Programáticamente

```dart
import 'package:screaming_architecture/screaming_architecture.dart';

void main() async {
  // Con state management y tests
  final structure = FolderStructure(
    basePath: 'lib',
    modules: ['auth', 'products', 'orders', 'profile'],
    includeShared: true,
    includeExamples: true,
    generateTests: true,
    stateManagement: StateManagement.bloc,
  );

  final generator = ArchitectureGenerator(structure);
  await generator.generate();
}
```

## 🎨 Presets Disponibles

### 🛒 E-commerce

Perfecto para aplicaciones de comercio electrónico:

- Módulos: `auth`, `products`, `cart`, `checkout`, `orders`, `profile`, `wishlist`, `reviews`

### 👥 Social Media

Ideal para redes sociales:

- Módulos: `auth`, `feed`, `profile`, `chat`, `notifications`, `search`, `friends`, `posts`

### 🏢 Enterprise

Para aplicaciones empresariales:

- Módulos: `auth`, `dashboard`, `analytics`, `reports`, `settings`, `users`, `notifications`

### ⚡ Minimal

Punto de partida minimalista:

- Módulos: `auth`, `home`, `profile`

## 🎛️ State Management

Elige tu solución favorita de state management y el generador creará todos los archivos necesarios:

### BLoC/Cubit

```bash
--state bloc
```

Genera: Events, States, BLoC con todos los imports necesarios

### Riverpod

```bash
--state riverpod
```

Genera: StateNotifier, State class, Provider

### Provider

```bash
--state provider
```

Genera: ChangeNotifier con implementación completa

### GetX

```bash
--state getx
```

Genera: GetxController con programación reactiva

## 🧪 Tests Automáticos

Genera estructura completa de tests con un flag:

```bash
--tests
```

Crea:

- ✅ **UseCase tests**: Tests unitarios para lógica de negocio
- ✅ **Repository tests**: Tests de implementación de repositorios
- ✅ **Model tests**: Tests de serialización (fromJson/toJson)
- ✅ **Widget tests**: Tests de UI para páginas

Todos con mocktail configurado y listos para ejecutar.

```dart
test/
└── modules/
    └── auth/
        ├── domain/
        │   └── usecases/
        │       └── login_usecase_test.dart
        ├── data/
        │   ├── models/
        │   │   └── user_model_test.dart
        │   └── repositories/
        │       └── auth_repository_impl_test.dart
        └── presentation/
            └── pages/
                └── login_page_test.dart
```

## 💡 Ventajas de esta Arquitectura

### 1. **Claridad Inmediata**

Al abrir el proyecto, cualquier desarrollador entiende de qué trata la aplicación viendo los nombres de los módulos.

### 2. **Desacoplamiento**

Cada módulo es independiente. Puedes:

- Desarrollar features en paralelo sin conflictos
- Reutilizar módulos en otros proyectos
- Eliminar features completas sin afectar el resto

### 3. **Escalabilidad**

Agregar nuevas features es tan simple como crear un nuevo módulo. La estructura no se vuelve caótica con el crecimiento.

### 4. **Testeable**

La separación en capas facilita:

- Unit tests (domain/usecases)
- Integration tests (data/repositories)
- Widget tests (presentation)

### 5. **Mantenibilidad**

Todo relacionado con una feature está en un solo lugar. No más buscar archivos dispersos en toda la app.

## 🎓 Conceptos Clave

### Módulos (Modules)

Representan **features o dominios de negocio** completos. Ejemplos:

- `auth`: Todo sobre autenticación (login, registro, recuperación de contraseña)
- `products`: Catálogo, detalles, búsqueda de productos
- `cart`: Carrito de compras
- `orders`: Gestión de pedidos

### Capas (Layers)

#### 1. **Presentation** 🎨

- **Responsabilidad**: UI y lógica de presentación
- **Contiene**: Pages, Widgets, Controllers/BLoCs/ViewModels
- **No debe**: Contener lógica de negocio o acceso a datos directo

#### 2. **Domain** 🧠

- **Responsabilidad**: Lógica de negocio pura
- **Contiene**: Entities, UseCases, Repository Interfaces
- **No debe**: Depender de frameworks o librerías externas

#### 3. **Data** 💾

- **Responsabilidad**: Acceso y gestión de datos
- **Contiene**: Models, DataSources, Repository Implementations
- **No debe**: Contener lógica de negocio

### Shared vs Core

- **Shared**: Código reutilizable sin lógica de negocio (widgets genéricos, utils, extensiones)
- **Core**: Fundamentos de la aplicación (configuración, DI, networking, errores)

## 📚 Ejemplos de Uso

### Crear un módulo de E-commerce completo

```bash
dart run screaming_architecture:screaming_architecture \
  --modules auth,products,cart,orders,profile,wishlist,reviews
```

Esto genera una estructura lista para una app de comercio electrónico con:

- Sistema de autenticación
- Catálogo de productos
- Carrito de compras
- Gestión de pedidos
- Perfil de usuario
- Lista de deseos
- Sistema de reseñas

### Crear una app social

```bash
dart run screaming_architecture:screaming_architecture \
  --modules auth,feed,profile,chat,notifications,search
```

## 🔧 Personalización

Una vez generada la estructura, personalízala según tus necesidades:

1. **Añade más carpetas** a los módulos si lo necesitas (e.g., `tests/`, `models/`)
2. **Modifica los templates** generados para ajustarse a tu estilo
3. **Elimina capas** que no necesites en ciertos módulos
4. **Integra con tu state management** favorito (BLoC, Riverpod, Provider, GetX)

## 🤝 Contribuir

Las contribuciones son bienvenidas! Si tienes ideas para mejorar:

1. Abre un issue en [github.com/GianSandoval5/screaming_architecture](https://github.com/GianSandoval5/screaming_architecture/issues) describiendo tu propuesta
2. Fork el repositorio
3. Crea tu feature branch (`git checkout -b feature/AmazingFeature`)
4. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
5. Push al branch (`git push origin feature/AmazingFeature`)
6. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

## 👨‍💻 Autor

**Gian Sandoval**

- 📧 Email: giansando2022@gmail.com
- 💼 LinkedIn: [linkedin.com/in/giansandoval](https://linkedin.com/in/giansandoval)
- 🐙 GitHub: [@GianSandoval5](https://github.com/GianSandoval5)

Creado con ❤️ para la comunidad Flutter/Dart

## 🌟 ¿Te gusta el proyecto?

Si este package te resulta útil, considera:

- ⭐ Darle una estrella en GitHub
- 🐛 Reportar bugs o sugerir mejoras
- 📢 Compartirlo con otros desarrolladores
- ☕ Invitarme un café (si quieres apoyar el desarrollo)

## 📖 Recursos Adicionales

- [Clean Architecture por Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Screaming Architecture](https://blog.cleancoder.com/uncle-bob/2011/09/30/Screaming-Architecture.html)
- [Flutter Architectural Overview](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options)

---

**¡Que tu código grite su propósito! 📢🏗️**
