# 📐 Arquitectura Visual

Este documento muestra diagramas y visualizaciones de la Screaming Architecture.

## 🏗️ Vista General de la Arquitectura

```
┌─────────────────────────────────────────────────────────────┐
│                        APLICACIÓN                            │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                   MODULES (Features)                 │    │
│  │                                                       │    │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐          │    │
│  │  │   Auth   │  │ Products │  │  Orders  │  ...     │    │
│  │  │          │  │          │  │          │          │    │
│  │  │ ┌──────┐ │  │ ┌──────┐ │  │ ┌──────┐ │          │    │
│  │  │ │Prese-│ │  │ │Prese-│ │  │ │Prese-│ │          │    │
│  │  │ │nta-  │ │  │ │nta-  │ │  │ │nta-  │ │          │    │
│  │  │ │tion  │ │  │ │tion  │ │  │ │tion  │ │          │    │
│  │  │ └──┬───┘ │  │ └──┬───┘ │  │ └──┬───┘ │          │    │
│  │  │    │     │  │    │     │  │    │     │          │    │
│  │  │ ┌──▼───┐ │  │ ┌──▼───┐ │  │ ┌──▼───┐ │          │    │
│  │  │ │Domain│ │  │ │Domain│ │  │ │Domain│ │          │    │
│  │  │ └──┬───┘ │  │ └──┬───┘ │  │ └──┬───┘ │          │    │
│  │  │    │     │  │    │     │  │    │     │          │    │
│  │  │ ┌──▼───┐ │  │ ┌──▼───┐ │  │ ┌──▼───┐ │          │    │
│  │  │ │ Data │ │  │ │ Data │ │  │ │ Data │ │          │    │
│  │  │ └──────┘ │  │ └──────┘ │  │ └──────┘ │          │    │
│  │  └──────────┘  └──────────┘  └──────────┘          │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                               │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                    SHARED                            │    │
│  │  • Widgets  • Utils  • Extensions  • Theme          │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                               │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                     CORE                             │    │
│  │  • Config  • DI  • Network  • Errors  • Routes      │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

## 🔄 Flujo de Datos (Clean Architecture)

```
┌────────────────────────────────────────────────────────────┐
│                     USER INTERACTION                        │
└───────────────────────┬────────────────────────────────────┘
                        │
                        ▼
┌────────────────────────────────────────────────────────────┐
│                  PRESENTATION LAYER                         │
│                                                              │
│  ┌──────────┐       ┌──────────┐       ┌──────────┐       │
│  │  Page/   │──────▶│   BLoC/  │──────▶│  Widget  │       │
│  │  Screen  │       │ViewModel│       │          │       │
│  └──────────┘       └────┬─────┘       └──────────┘       │
└─────────────────────────┼──────────────────────────────────┘
                          │
                          │ calls
                          ▼
┌────────────────────────────────────────────────────────────┐
│                    DOMAIN LAYER                             │
│                   (Business Logic)                          │
│                                                              │
│  ┌──────────┐       ┌──────────┐       ┌──────────┐       │
│  │ UseCase  │──────▶│Repository│◀──────│ Entity   │       │
│  │          │       │(Interface)       │          │       │
│  └──────────┘       └────┬─────┘       └──────────┘       │
└─────────────────────────┼──────────────────────────────────┘
                          │
                          │ implements
                          ▼
┌────────────────────────────────────────────────────────────┐
│                     DATA LAYER                              │
│                                                              │
│  ┌──────────┐       ┌──────────┐       ┌──────────┐       │
│  │Repository│──────▶│DataSource│──────▶│  Model   │       │
│  │   Impl   │       │          │       │  (DTO)   │       │
│  └──────────┘       └────┬─────┘       └──────────┘       │
└─────────────────────────┼──────────────────────────────────┘
                          │
                          ▼
┌────────────────────────────────────────────────────────────┐
│                  EXTERNAL SOURCES                           │
│         • REST API  • GraphQL  • Local DB  • Cache         │
└────────────────────────────────────────────────────────────┘
```

## 📦 Estructura de un Módulo

```
auth/
│
├── presentation/           # 🎨 Capa de Presentación
│   ├── pages/
│   │   ├── login_page.dart         ← Screen/Page de login
│   │   └── register_page.dart      ← Screen/Page de registro
│   │
│   ├── widgets/
│   │   ├── login_form.dart         ← Form widget
│   │   └── password_field.dart     ← Campo personalizado
│   │
│   └── bloc/                       ← State Management (BLoC)
│       ├── auth_bloc.dart
│       ├── auth_event.dart
│       └── auth_state.dart
│
├── domain/                 # 🧠 Capa de Dominio (Lógica de Negocio)
│   ├── entities/
│   │   └── user.dart               ← Entidad de negocio
│   │
│   ├── repositories/
│   │   └── auth_repository.dart    ← Interface (contrato)
│   │
│   └── usecases/
│       ├── login_user.dart         ← Caso de uso: Login
│       ├── register_user.dart      ← Caso de uso: Registro
│       └── logout_user.dart        ← Caso de uso: Logout
│
├── data/                   # 💾 Capa de Datos
│   ├── models/
│   │   └── user_model.dart         ← DTO (extends User entity)
│   │
│   ├── datasources/
│   │   ├── auth_remote_datasource.dart    ← API calls
│   │   └── auth_local_datasource.dart     ← Cache/DB local
│   │
│   └── repositories/
│       └── auth_repository_impl.dart      ← Implementación del repo
│
├── routes/
│   └── auth_routes.dart            ← Rutas del módulo
│
└── auth_module.dart                ← Barrel file (exports públicos)
```

## 🔗 Diagrama de Dependencias

```
                    ┌─────────────┐
                    │Presentation │
                    │   Layer     │
                    └──────┬──────┘
                           │
                           │ depends on
                           ▼
                    ┌─────────────┐
                    │   Domain    │
                    │   Layer     │
                    └──────▲──────┘
                           │
                           │ implements
                           │
                    ┌──────┴──────┐
                    │    Data     │
                    │   Layer     │
                    └─────────────┘
                           │
                           │ uses
                           ▼
                    ┌─────────────┐
                    │  External   │
                    │  Services   │
                    └─────────────┘

REGLA: Las flechas siempre apuntan HACIA ADENTRO
       (hacia el dominio, la capa más pura)
```

## 🎯 Ejemplo de Flujo: Login de Usuario

```
1. Usuario toca botón "Login"
   │
   ▼
2. LoginPage emite LoginRequested event
   │
   ▼
3. AuthBloc recibe el event
   │
   ▼
4. AuthBloc llama LoginUseCase
   │
   ▼
5. LoginUseCase valida datos y llama AuthRepository
   │
   ▼
6. AuthRepositoryImpl (Data) ejecuta lógica
   │
   ├─▶ Llama a AuthRemoteDataSource
   │   └─▶ Hace HTTP request a /api/login
   │       └─▶ Recibe UserModel
   │
   └─▶ Llama a AuthLocalDataSource
       └─▶ Guarda token en cache local
   │
   ▼
7. Retorna User entity al UseCase
   │
   ▼
8. UseCase retorna Result al BLoC
   │
   ▼
9. BLoC emite AuthSuccess state
   │
   ▼
10. LoginPage se reconstruye mostrando éxito
```

## 🌳 Árbol de Carpetas Completo

```
lib/
│
├── modules/                        # Módulos de negocio
│   │
│   ├── auth/                       # Feature: Autenticación
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   ├── widgets/
│   │   │   └── bloc/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── datasources/
│   │   │   └── repositories/
│   │   └── routes/
│   │
│   ├── products/                   # Feature: Productos
│   │   ├── presentation/
│   │   ├── domain/
│   │   ├── data/
│   │   └── routes/
│   │
│   └── orders/                     # Feature: Pedidos
│       ├── presentation/
│       ├── domain/
│       ├── data/
│       └── routes/
│
├── shared/                         # Componentes compartidos
│   ├── widgets/                    # Widgets reutilizables
│   │   ├── custom_button.dart
│   │   ├── loading_indicator.dart
│   │   └── error_widget.dart
│   │
│   ├── utils/                      # Utilidades
│   │   ├── validators.dart
│   │   └── formatters.dart
│   │
│   ├── extensions/                 # Extensiones de Dart
│   │   ├── string_extensions.dart
│   │   └── datetime_extensions.dart
│   │
│   ├── constants/                  # Constantes
│   │   └── app_constants.dart
│   │
│   └── theme/                      # Temas
│       └── app_theme.dart
│
├── core/                           # Núcleo de la aplicación
│   ├── config/                     # Configuración
│   │   └── app_config.dart
│   │
│   ├── di/                         # Dependency Injection
│   │   └── injection_container.dart
│   │
│   ├── network/                    # Cliente HTTP
│   │   └── api_client.dart
│   │
│   ├── errors/                     # Manejo de errores
│   │   └── failures.dart
│   │
│   └── routes/                     # Rutas globales
│       └── app_routes.dart
│
├── app/                            # Punto de entrada
│   └── app.dart                    # Widget principal
│
└── main.dart                       # Entry point
```

## 🔀 Comparación: Arquitectura Tradicional vs Screaming

### ❌ Arquitectura Tradicional (No comunica propósito)

```
lib/
├── components/       # ¿Componentes de qué?
├── screens/          # ¿Qué screens?
├── services/         # ¿Qué servicios?
├── models/           # ¿Qué models?
└── utils/            # Cajón de sastre
```

### ✅ Screaming Architecture (Comunica dominio)

```
lib/
├── modules/
│   ├── authentication/    # ¡Claro! Es una app con auth
│   ├── product_catalog/   # ¡Y maneja productos!
│   ├── shopping_cart/     # ¡Es un e-commerce!
│   └── order_management/  # ¡Con sistema de pedidos!
└── ...
```

## 📊 Beneficios Visualizados

```
┌─────────────────────────────────────────────────────────┐
│             BENEFICIOS DE LA ARQUITECTURA                │
├─────────────────────────────────────────────────────────┤
│                                                           │
│  🎯 CLARIDAD                                             │
│  ├─ Estructura refleja el dominio                       │
│  ├─ Fácil onboarding de nuevos devs                     │
│  └─ Code reviews más efectivos                          │
│                                                           │
│  🔌 DESACOPLAMIENTO                                      │
│  ├─ Módulos independientes                              │
│  ├─ Desarrollo en paralelo                              │
│  └─ Testing aislado                                      │
│                                                           │
│  📈 ESCALABILIDAD                                        │
│  ├─ Agregar features sin complejidad                    │
│  ├─ Remover features fácilmente                         │
│  └─ Reutilización de módulos                            │
│                                                           │
│  🧪 TESTEABILIDAD                                        │
│  ├─ Unit tests (domain)                                 │
│  ├─ Integration tests (data)                            │
│  └─ Widget tests (presentation)                         │
│                                                           │
│  🔧 MANTENIBILIDAD                                       │
│  ├─ Todo en un lugar                                    │
│  ├─ Menos acoplamiento                                  │
│  └─ Código más limpio                                   │
│                                                           │
└─────────────────────────────────────────────────────────┘
```

## 🎓 Principios SOLID Aplicados

```
┌──────────────────────────────────────────────────────────┐
│                    SOLID PRINCIPLES                       │
├──────────────────────────────────────────────────────────┤
│                                                            │
│  S - Single Responsibility                                │
│      Cada módulo tiene UNA responsabilidad                │
│      ├─ auth → Solo autenticación                        │
│      └─ products → Solo gestión de productos             │
│                                                            │
│  O - Open/Closed                                          │
│      Módulos abiertos a extensión, cerrados a modif.     │
│      └─ Agregar feature = nuevo módulo                   │
│                                                            │
│  L - Liskov Substitution                                  │
│      Implementaciones intercambiables                     │
│      └─ Repository interface ↔ Multiple impls           │
│                                                            │
│  I - Interface Segregation                                │
│      Interfaces específicas por uso                       │
│      └─ Cada repository tiene su interface               │
│                                                            │
│  D - Dependency Inversion                                 │
│      Depender de abstracciones                            │
│      └─ Domain ← interfaces, Data → implements           │
│                                                            │
└──────────────────────────────────────────────────────────┘
```

## 🚀 Roadmap de Crecimiento de la App

```
Fase 1: MVP                  Fase 2: Features       Fase 3: Enterprise
┌─────────────┐             ┌─────────────┐        ┌─────────────┐
│ modules/    │             │ modules/    │        │ modules/    │
│ ├─ auth     │──────▶      │ ├─ auth     │───▶    │ ├─ auth     │
│ └─ home     │             │ ├─ home     │        │ ├─ home     │
│             │             │ ├─ products │        │ ├─ products │
│             │             │ ├─ cart     │        │ ├─ cart     │
│             │             │ └─ profile  │        │ ├─ profile  │
│             │             │             │        │ ├─ orders   │
└─────────────┘             └─────────────┘        │ ├─ analytics│
                                                   │ ├─ admin    │
                                                   │ └─ reports  │
                                                   └─────────────┘

   2 módulos                   5 módulos              9+ módulos
   Semanas 1-4                 Semanas 5-8            Mes 3+
```

---

## 📚 Referencias Visuales

### Clean Architecture (Uncle Bob)

```
        ┌─────────────────────────────────┐
        │       Frameworks & Drivers       │  ← External
        │     (Web, UI, DB, Devices)      │
        └──────────────┬──────────────────┘
                       │
        ┌──────────────▼──────────────────┐
        │      Interface Adapters          │  ← Data Layer
        │   (Controllers, Presenters)      │
        └──────────────┬──────────────────┘
                       │
        ┌──────────────▼──────────────────┐
        │      Application Business        │  ← Domain Layer
        │         Rules (UseCases)         │
        └──────────────┬──────────────────┘
                       │
        ┌──────────────▼──────────────────┐
        │      Enterprise Business         │  ← Entities
        │          Rules (Entities)        │
        └──────────────────────────────────┘
                    ↑
              Dependencies
           apuntan hacia adentro
```

---

**Este documento se actualizará con el crecimiento del package.**
