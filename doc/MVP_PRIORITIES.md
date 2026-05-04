# 🎯 Prioridades MVP - Turbo App

> **Resumen ejecutivo de lo que se debe enfocar**

---

## 🔥 TOP 5 - Prioridades Absolutas

### 1️⃣ Pantalla de Perfil de Usuario
**¿Por qué?** Los usuarios no pueden ver su información ni cerrar sesión de forma elegante.

```
Tiempo estimado: 8-16 horas
Dependencias: Ninguna
Complejidad: Media
```

**Entregables:**
- [ ] ProfileScreen con información del usuario
- [ ] Estadísticas (favoritos, reservaciones, reseñas)
- [ ] Configuraciones básicas
- [ ] Botón de cerrar sesión

---

### 2️⃣ Onboarding (Primera Experiencia)
**¿Por qué?** Sin onboarding, los usuarios no entienden el valor de la app inmediatamente.

```
Tiempo estimado: 8-12 horas
Dependencias: Ninguna
Complejidad: Baja
```

**Entregables:**
- [ ] 3-4 pantallas de introducción
- [ ] Animaciones suaves
- [ ] Indicador de página
- [ ] Botón Skip/Siguiente
- [ ] Persistencia (mostrar solo primera vez)

---

### 3️⃣ Limpieza de Logs de Debug
**¿Por qué?** Impacta rendimiento y puede exponer información sensible.

```
Tiempo estimado: 2-4 horas
Dependencias: Ninguna
Complejidad: Baja
```

**Entregables:**
- [ ] Crear AppLogger utility
- [ ] Reemplazar todos los print() 
- [ ] Configurar logging condicional

---

### 4️⃣ Manejo de Errores de Conexión
**¿Por qué?** La app crashea o se comporta mal sin conexión.

```
Tiempo estimado: 4-8 horas
Dependencias: Ninguna
Complejidad: Media
```

**Entregables:**
- [ ] Widget de "Sin conexión"
- [ ] Retry automático
- [ ] Mensajes de error amigables
- [ ] Loading states consistentes

---

### 5️⃣ Recuperación de Contraseña (UI)
**¿Por qué?** Flujo básico de autenticación incompleto.

```
Tiempo estimado: 4-6 horas
Dependencias: Core (ya implementado)
Complejidad: Baja
```

**Entregables:**
- [ ] ForgotPasswordScreen
- [ ] Integración con Core
- [ ] Mensaje de confirmación

---

## 📊 Matriz de Priorización

| Feature | Impacto | Esfuerzo | Prioridad |
|---------|---------|----------|-----------|
| Pantalla de Perfil | 🔴 Alto | 🟡 Medio | 1️⃣ |
| Onboarding | 🔴 Alto | 🟢 Bajo | 2️⃣ |
| Limpieza de Logs | 🟡 Medio | 🟢 Bajo | 3️⃣ |
| Manejo de Errores | 🔴 Alto | 🟡 Medio | 4️⃣ |
| Recuperación Contraseña | 🟡 Medio | 🟢 Bajo | 5️⃣ |
| Notificaciones Push | 🟡 Medio | 🔴 Alto | 6️⃣ |
| Validaciones Forms | 🟢 Bajo | 🟢 Bajo | 7️⃣ |
| Búsqueda Mejorada | 🟢 Bajo | 🟡 Medio | 8️⃣ |
| Deep Linking | 🟢 Bajo | 🟡 Medio | 9️⃣ |
| Modo Offline | 🟢 Bajo | 🔴 Alto | 🔟 |

---

## ✅ Lo que YA está BIEN

No tocar estas áreas (están funcionando correctamente):

1. **Sistema de autenticación** - Login/Registro funciona
2. **Feed principal** - UI atractiva y funcional
3. **Detalle de lugares** - Información completa
4. **Sistema de reservaciones** - Flujo completo
5. **Favoritos** - Toggle funciona
6. **Eventos** - Listado funcional
7. **Navegación** - auto_route bien configurado
8. **Tema oscuro/claro** - Implementado
9. **Core package** - Sólido y bien documentado

---

## ⚠️ Lo que NO hacer ahora

Evitar estas tentaciones hasta post-MVP:

1. ❌ **Refactorizar arquitectura** - Funciona, no tocar
2. ❌ **Añadir nuevas features** - Enfocarse en completar lo existente
3. ❌ **Migrar dependencias** - Riesgoso antes del lanzamiento
4. ❌ **Rediseñar UI** - Ya está bien
5. ❌ **Internacionalización** - Solo español por ahora
6. ❌ **Tests exhaustivos** - Solo flujos críticos

---

## 📅 Timeline Sugerido

```
Semana 1:
├── Día 1-2: Pantalla de Perfil
├── Día 3-4: Onboarding
└── Día 5: Limpieza de Logs

Semana 2:
├── Día 1-2: Manejo de Errores
├── Día 3: Recuperación de Contraseña
├── Día 4: Bug fixes
└── Día 5: Testing interno

Semana 3:
├── Día 1-2: Notificaciones Push (opcional)
├── Día 3-4: QA en dispositivos
└── Día 5: Preparación para stores

Semana 4:
├── Día 1-2: Submit a stores
├── Día 3-5: Monitoreo y fixes
```

---

## 🎯 Definición de "Done" para MVP

### Funcionalidad Mínima Viable
- [x] Usuario puede registrarse con email
- [x] Usuario puede hacer login con email/Google
- [ ] Usuario puede ver y editar su perfil
- [x] Usuario puede explorar lugares
- [x] Usuario puede ver detalles de lugares
- [x] Usuario puede hacer reservaciones
- [x] Usuario puede gestionar favoritos
- [x] Usuario puede ver eventos
- [x] Usuario puede ver reseñas
- [ ] Usuario nuevo ve onboarding

### Calidad Mínima
- [ ] Sin crashes en flujos principales
- [ ] Mensajes de error claros
- [ ] Carga < 3 segundos
- [ ] Sin logs de debug en producción

### Documentación
- [ ] Política de privacidad
- [ ] Términos de servicio
- [ ] Screenshots para stores
- [ ] Descripción de la app

---

## 💬 Preguntas Frecuentes

**Q: ¿Puedo agregar X feature que sería genial?**
A: Añádelo al backlog post-MVP. Enfócate en las 5 prioridades.

**Q: ¿Qué pasa si encuentro un bug crítico?**
A: Arréglalo inmediatamente si bloquea flujos principales.

**Q: ¿Debo escribir tests para todo?**
A: Solo para los 5 flujos principales por ahora.

**Q: ¿Puedo mejorar la UI de algo existente?**
A: Solo si no agrega tiempo significativo (<2 horas).

---

## 🚀 Siguiente Paso Inmediato

**Hoy:** Comenzar con la Pantalla de Perfil

1. Crear estructura de archivos
2. Diseñar UI básica
3. Conectar con AuthCubit existente
4. Implementar cerrar sesión

---

**Mantra MVP:** "Menos es más. Lanza rápido, itera después."
