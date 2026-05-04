# 🎨 Turbo UI

> Sistema de diseño premium para Turbo App

[![Flutter](https://img.shields.io/badge/Flutter-3.29.0+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7.0+-blue.svg)](https://dart.dev)

---

## 📋 Descripción

Turbo UI es el paquete de diseño oficial de Turbo App. Contiene todos los tokens de diseño, temas y estilos predefinidos para mantener una UI consistente y premium.

## 🎨 Paleta de Colores

### Color Primario
El rojo vibrante de Turbo (`#FF003D`) es el corazón de la marca.

```dart
TurboColors.primary      // #FF003D - Rojo principal
TurboColors.primaryDark  // #D50033 - Rojo oscuro
TurboColors.primaryLight // #FF4D73 - Rojo claro
```

### Neutrales
Escala de grises premium para textos y fondos.

```dart
TurboColors.neutral900  // Texto principal
TurboColors.neutral500  // Texto secundario
TurboColors.neutral200  // Bordes
TurboColors.neutral50   // Fondos claros (#F5F5F7)
```

## 🚀 Instalación

Añade el paquete a tu `pubspec.yaml`:

```yaml
dependencies:
  turbo_ui:
    path: packages/turbo_ui
```

## 📖 Uso

### Configurar Temas

```dart
import 'package:turbo_ui/turbo_ui.dart';

MaterialApp(
  theme: TurboTheme.light,
  darkTheme: TurboTheme.dark,
  themeMode: ThemeMode.system,
);
```

### Usar Colores

```dart
import 'package:turbo_ui/turbo_ui.dart';

Container(
  color: TurboColors.primary,
  child: Text(
    'Hola Turbo',
    style: TextStyle(color: TurboColors.white),
  ),
);
```

### Usar Gradientes

```dart
Container(
  decoration: BoxDecoration(
    gradient: TurboColors.primaryGradient,
    borderRadius: TurboRadius.card,
  ),
);
```

### Estilos de Botones

```dart
ElevatedButton(
  style: TurboButtonStyles.primaryMd,
  onPressed: () {},
  child: Text('Botón Primario'),
);

// Variantes
TurboButtonStyles.primarySm      // Pequeño
TurboButtonStyles.primaryLg      // Grande
TurboButtonStyles.primaryGlow    // Con glow
TurboButtonStyles.pillPrimary    // Pill shape
TurboButtonStyles.fullWidthPrimary // Ancho completo
```

### Estilos de Cards

```dart
Container(
  decoration: TurboCardStyles.elevated,
  padding: TurboCardStyles.paddingMd,
  child: Text('Card con elevación'),
);

// Variantes
TurboCardStyles.flat            // Sin sombra
TurboCardStyles.elevatedMd      // Elevación media
TurboCardStyles.featured        // Destacada con borde rojo
TurboCardStyles.gradientPrimary // Con gradiente
TurboCardStyles.glass           // Glassmorphism
```

### Estilos de Inputs

```dart
TextField(
  decoration: TurboInputStyles.standard(
    labelText: 'Email',
    hintText: 'ejemplo@correo.com',
  ),
);

// Especiales
TurboInputStyles.search(hintText: 'Buscar...')
TurboInputStyles.email()
TurboInputStyles.password(isVisible: false)
TurboInputStyles.phone()
```

### Constantes de Espaciado

```dart
Padding(
  padding: EdgeInsets.all(TurboSpacing.base), // 16px
  child: Column(
    children: [
      Text('Item 1'),
      SizedBox(height: TurboSpacing.sm), // 8px
      Text('Item 2'),
    ],
  ),
);
```

### Constantes de Radio

```dart
Container(
  decoration: BoxDecoration(
    borderRadius: TurboRadius.card,     // 16px
    // o
    borderRadius: TurboRadius.mdRadius, // 12px
    // o
    borderRadius: TurboRadius.fullRadius, // Circular
  ),
);
```

### Sombras

```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: TurboShadows.md,
    // o con color
    boxShadow: TurboShadows.primaryGlowMd,
  ),
);
```

### Duraciones de Animación

```dart
AnimatedContainer(
  duration: TurboDurations.normal, // 200ms
  // o
  duration: TurboDurations.slow,   // 400ms
);
```

### Extension de Context

```dart
// En cualquier widget
@override
Widget build(BuildContext context) {
  return Container(
    color: context.primaryColor,    // Color primario
    child: Text(
      'Hola',
      style: context.textTheme.titleLarge,
    ),
  );
}

// Verificar tema oscuro
if (context.isDarkMode) {
  // ...
}
```

## 📁 Estructura

```
lib/
├── turbo_ui.dart              # Exportaciones
└── src/
    ├── colors/
    │   └── turbo_colors.dart  # Paleta de colores
    ├── typography/
    │   └── turbo_typography.dart # Sistema tipográfico
    ├── theme/
    │   ├── turbo_theme.dart   # Entry point temas
    │   ├── turbo_light_theme.dart
    │   └── turbo_dark_theme.dart
    ├── constants/
    │   ├── turbo_spacing.dart # Espaciado
    │   ├── turbo_radius.dart  # Border radius
    │   ├── turbo_shadows.dart # Sombras
    │   └── turbo_durations.dart # Animaciones
    └── styles/
        ├── turbo_button_styles.dart
        ├── turbo_card_styles.dart
        └── turbo_input_styles.dart
```

## 🎯 Principios de Diseño

1. **Consistencia** - Mismos valores en toda la app
2. **Premium** - Estética moderna y elegante
3. **Accesible** - Contraste adecuado en ambos temas
4. **Performante** - Valores constantes cuando es posible

## 📄 Licencia

Propiedad de Turbo Team Organization.
