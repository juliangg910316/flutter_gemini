# flutter_gemini

A new Flutter project.
## Uso de build_runner en modo watch

Para que `build_runner` se quede escuchando cambios y regenere archivos automáticamente, ejecuta el siguiente comando en la raíz de tu proyecto:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

Esto mantendrá el proceso activo y generará los archivos necesarios cada vez que detecte cambios en tu código fuente.