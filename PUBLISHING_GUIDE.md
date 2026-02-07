# 📤 Guía de Publicación

Instrucciones paso a paso para publicar este package en pub.dev.

## ✅ Pre-requisitos

1. **Cuenta en pub.dev**
   - Visita https://pub.dev
   - Inicia sesión con tu cuenta de Google

2. **Dart SDK instalado**

   ```bash
   dart --version
   # Debe ser >= 3.10.8
   ```

3. **Git configurado**
   ```bash
   git config --global user.name "Tu Nombre"
   git config --global user.email "tu@email.com"
   ```

## 📝 Pasos Previos

### 1. Actualizar pubspec.yaml

✅ **Ya actualizado con tu información:**

```yaml
name: screaming_architecture
description: A Flutter package that generates project structure following Screaming Architecture pattern, where folder organization clearly communicates business domain and features.
version: 1.0.0
homepage: https://github.com/GianSandoval5/screaming_architecture
repository: https://github.com/GianSandoval5/screaming_architecture
issue_tracker: https://github.com/GianSandoval5/screaming_architecture/issues
documentation: https://github.com/GianSandoval5/screaming_architecture#readme
```

### 2. Crear Repositorio en GitHub

✅ **Tu usuario de GitHub: GianSandoval5**

```bash
# Inicializar git si no lo has hecho
git init

# Crear repositorio en GitHub
# Opción 1: Usando GitHub CLI
gh repo create screaming_architecture --public --source=. --remote=origin

# Opción 2: Manualmente
# - Ve a https://github.com/new
# - Crea repo llamado "screaming_architecture"
# - Sigue las instrucciones

# Añadir archivos
git add .
git commit -m "Initial release v1.0.0 - Screaming Architecture package"

# Push
git branch -M main
git remote add origin https://github.com/GianSandoval5/screaming_architecture.git
git push -u origin main
```

### 3. Crear Release en GitHub

```bash
# Crear tag
git tag -a v1.0.0 -m "Release v1.0.0 - Initial stable release"
git push origin v1.0.0

# O usa GitHub UI:
# - Ve a https://github.com/GianSandoval5/screaming_architecture/releases/new
# - Tag: v1.0.0
# - Title: v1.0.0 - Initial Release
# - Description: Copia contenido de CHANGELOG.md
```

## 🔍 Validación Pre-Publicación

### 1. Verificar Análisis

```bash
# Sin errores críticos
dart analyze
```

### 2. Ejecutar Tests

```bash
# Todos deben pasar
flutter test
```

### 3. Verificar Formato

```bash
# Formatear código
dart format .
```

### 4. Dry Run de Publicación

```bash
# Simula la publicación sin publicar
dart pub publish --dry-run
```

**Verifica que no haya warnings o errores.**

Salida esperada:

```
Publishing screaming_architecture 1.0.0 to https://pub.dev:
Package has 0 warnings.
```

## 🚀 Publicación

### Paso 1: Publicar a pub.dev

```bash
dart pub publish
```

Se te pedirá confirmación:

```
Publishing screaming_architecture 1.0.0 to https://pub.dev:

Files:
  ...lista de archivos...

Do you want to publish screaming_architecture 1.0.0 to pub.dev? (y/N):
```

Escribe `y` y presiona Enter.

### Paso 2: Autenticación

Si es tu primera vez publicando:

1. Se abrirá un navegador
2. Autoriza pub.dev a acceder a tu cuenta
3. La publicación continuará automáticamente

### Paso 3: Verificar

Una vez publicado, verifica en:

- https://pub.dev/packages/screaming_architecture

## 📈 Post-Publicación

### 1. Actualizar README con Badge

Añade al inicio del README.md:

```markdown
[![pub package](https://img.shields.io/pub/v/screaming_architecture.svg)](https://pub.dev/packages/screaming_architecture)
```

### 2. Promocionar el Package

#### Reddit

- r/FlutterDev
- r/dartlang

Post sugerido:

```
🏗️ [New Package] Screaming Architecture - Structure your Flutter apps professionally

Hi Flutter community! I just published a new package that helps you scaffold
Flutter projects following the Screaming Architecture pattern (by Uncle Bob).

Key features:
- 🎯 Business-focused folder structure
- 📦 Modular Clean Architecture
- 🚀 One-command generation
- 📝 20+ ready-to-use templates
- ✨ Highly configurable

Check it out: https://pub.dev/packages/screaming_architecture

Any feedback is welcome!
```

#### Twitter/X

```
🚀 Just published Screaming Architecture for #Flutter!

Generate professional, scalable project structures with one command.

✅ Clean Architecture
✅ Modular design
✅ Production-ready templates

pub.dev/packages/screa…

#Dart #FlutterDev #CleanCode
```

#### Dev.to

Escribe un artículo detallado:

- "How to Structure Large Flutter Apps with Screaming Architecture"
- Include examples, diagrams
- Link to package

#### Medium

Similar al artículo de Dev.to

#### Discord

- Flutter Community Discord
- Clean Coders Discord

#### LinkedIn

Post profesional sobre arquitectura de software

### 3. Crear Sitio Web (Opcional)

Usa GitHub Pages:

```bash
# Crear rama gh-pages
git checkout --orphan gh-pages

# Crear index.html simple
cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Screaming Architecture</title>
    <meta http-equiv="refresh" content="0; url=https://pub.dev/packages/screaming_architecture">
</head>
<body>
    <p>Redirecting to <a href="https://pub.dev/packages/screaming_architecture">pub.dev</a>...</p>
</body>
</html>
EOF

git add index.html
git commit -m "Add GitHub Pages redirect"
git push origin gh-pages
```

### 4. Configurar CI/CD

Crea `.github/workflows/publish.yml`:

```yaml
name: Publish Package

on:
  push:
    tags:
      - "v*"

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: dart-lang/setup-dart@v1

      - name: Install dependencies
        run: flutter pub get

      - name: Run tests
        run: flutter test

      - name: Publish to pub.dev
        run: dart pub publish --force
        env:
          PUB_CREDENTIALS: ${{ secrets.PUB_CREDENTIALS }}
```

## 🔄 Actualizaciones Futuras

### Versioning (Semantic Versioning)

- **MAJOR** (x.0.0): Breaking changes
- **MINOR** (1.x.0): New features, backwards compatible
- **PATCH** (1.0.x): Bug fixes

### Proceso de Actualización

```bash
# 1. Implementar cambios
# 2. Actualizar CHANGELOG.md
# 3. Actualizar version en pubspec.yaml

# 4. Commit y tag
git add .
git commit -m "Release v1.1.0 - Add new features"
git tag v1.1.0
git push origin main --tags

# 5. Publicar
dart pub publish
```

## 🐛 Manejo de Issues

### Configurar Issue Templates

Crea `.github/ISSUE_TEMPLATE/bug_report.md`:

```markdown
---
name: Bug Report
about: Report a bug
title: "[BUG] "
labels: bug
---

**Describe the bug**
A clear description of the bug.

**To Reproduce**
Steps to reproduce the behavior.

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Environment:**

- Flutter version:
- Dart version:
- Package version:
```

### Configurar PR Template

Crea `.github/PULL_REQUEST_TEMPLATE.md`:

```markdown
## Description

Brief description of changes.

## Type of Change

- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Checklist

- [ ] Tests pass
- [ ] Code follows style guide
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
```

## 📊 Métricas

### Monitorear

- **Downloads**: pub.dev muestra estadísticas
- **Stars**: GitHub stars
- **Issues**: Tiempo de respuesta
- **PRs**: Contribuciones de la comunidad

### Responder Rápidamente

- Issues: < 24 horas
- PRs: Review en < 48 horas
- Preguntas: Lo antes posible

## 🎯 Metas del Primer Mes

1. ✅ 100+ downloads
2. ✅ 50+ pub points (score de calidad)
3. ✅ 10+ GitHub stars
4. ✅ 0 critical issues sin resolver
5. ✅ 1 artículo técnico publicado

## 🤝 Construir Comunidad

1. **Responde comentarios** en pub.dev
2. **Agradece contribuciones** en PRs
3. **Documenta decisiones** en issues
4. **Comparte casos de uso** reales
5. **Pide feedback** activamente

## 🎉 ¡Listo!

Tu package está listo para ser publicado y compartido con el mundo.

**Good luck! 🚀**

---

## 📞 Soporte

Si tienes problemas publicando:

1. Revisa https://dart.dev/tools/pub/publishing
2. Pregunta en r/FlutterDev
3. Revisa https://github.com/dart-lang/pub/issues

## 🔗 Links Útiles

- [Publishing Packages](https://dart.dev/tools/pub/publishing)
- [Package Layout Conventions](https://dart.dev/tools/pub/package-layout)
- [Writing Package Pages](https://dart.dev/tools/pub/writing-package-pages)
- [Verified Publishers](https://dart.dev/tools/pub/verified-publishers)
