# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es/1.0.0/),
y este proyecto adhiere a [Versionado Semántico](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2026-02-07

### 🐛 Corrección

- **Tests con imports correctos**: Los tests generados ahora usan el nombre del proyecto actual (leyendo `pubspec.yaml`) en lugar de `package:screaming_architecture/...`
- Ejemplo: Si tu proyecto se llama `mi_app`, los imports serán `package:mi_app/...` en lugar de `package:screaming_architecture/...`

## [1.0.0] - 2026-02-07

### 🎉 Lanzamiento Inicial

Primera versión estable de Screaming Architecture para Dart/Flutter con características avanzadas.

### ✨ Características Implementadas

#### 🏗️ Generador de Arquitectura

- Generación automática de estructura de carpetas basada en Screaming Architecture
- Clean Architecture con capas: Presentation, Domain y Data
- Soporte para múltiples módulos de negocio
- Carpetas shared/ y core/ para código compartido
- 20+ templates listos para usar

#### 🎯 Presets Predefinidos

- **E-commerce**: 8 módulos (auth, products, cart, checkout, orders, profile, wishlist, reviews)
- **Social Media**: 8 módulos (auth, feed, profile, chat, notifications, search, friends, posts)
- **Enterprise**: 7 módulos (auth, dashboard, analytics, reports, settings, users, notifications)
- **Minimal**: 3 módulos (auth, home, profile)
- **Custom**: Define tus propios módulos

#### 🎛️ State Management

- **BLoC/Cubit**: Templates con Events, States y BLoC completos
- **Riverpod**: StateNotifier y Providers
- **Provider**: ChangeNotifier implementation
- **GetX**: GetxController con reactive programming
- **None**: StatefulWidget básico
- Generación automática por módulo

#### 🧪 Generación de Tests

- Unit tests para UseCases (domain layer)
- Tests para Repository Implementations (data layer)
- Tests de Models (fromJson/toJson)
- Widget tests para Pages
- Integración con mocktail
- Estructura completa en test/modules/{module}/

#### 🎨 CLI Interactivo

- Modo interactivo: `--interactive` o `-i`
- Flags: `--path`, `--modules`, `--preset`, `--state`, `--tests`, `--no-examples`
- Help completo: `--help`

### 📦 Componentes

- `ArchitectureGenerator`: Motor de generación
- `FolderStructure`: Configuración de carpetas
- `ModuleConfig`: Configuración por módulo
- `ProjectPreset`: 4 presets predefinidos
- `StateManagement`: 5 opciones de state management
- `FileTemplates`: Templates base
- `StateManagementTemplates`: Templates para BLoC, Riverpod, Provider, GetX
- `TestTemplates`: Templates de tests

### 🎓 Ejemplos de Uso

```bash
# Modo interactivo
dart run screaming_architecture:screaming_architecture -i

# E-commerce con BLoC y tests
dart run screaming_architecture:screaming_architecture --preset ecommerce --state bloc --tests

# Custom con Riverpod
dart run screaming_architecture:screaming_architecture --modules auth,products,cart --state riverpod --tests
```

### 📚 Documentación

- README.md: Guía completa
- QUICK_START.md: Inicio rápido
- BEST_PRACTICES.md: Mejores prácticas
- ARCHITECTURE_VISUAL.md: Diagramas visuales
- IMPROVEMENTS.md: Roadmap futuro
- PUBLISHING_GUIDE.md: Guía de publicación
- AUTHORS.md: Créditos

### 🔧 Técnico

- 100% Dart
- Dependencias: Flutter SDK + mocktail (dev)
- 25+ templates
- 10+ tests (100% passing)

---

**Autor**: Gian Sandoval ([@GianSandoval5](https://github.com/GianSandoval5))  
**Email**: giansando2022@gmail.com  
**LinkedIn**: [giansandoval](https://linkedin.com/in/giansandoval)
