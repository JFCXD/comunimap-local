# ComuniMap Local

Repositorio de trabajo **independiente**. Solo este repositorio puede modificarse en esta conversación; los originales se consultan únicamente en modo lectura.

## Carpetas

- `web/`: Laravel (copia desde `JFCXD/comunimap`).
- `api/`: API PHP (copia desde `JFCXD/comunimap-api`).
- `android/`: Android Kotlin; se actualiza con el ZIP de Google AI Studio.
- `database/`: esquema **anonimizado** de pruebas, sin usuarios ni credenciales reales.

## Actualizar Android y la base local

1. Subir el paquete `actualizacion_comunimap_local.zip` a la raíz de este repositorio, rama `main`, desde **Add file → Upload files**.
2. La acción `Aplicar Android actualizado y SQL local seguro` descomprime Android y el SQL en `android/` y `database/`.
3. La acción conserva el archivo `app/google-services.json` existente y elimina el ZIP subido después de aplicar los cambios.
4. Comprobar el resultado en **Actions**. No se publica nada en los repositorios originales ni en Railway.

**Advertencia:** el SQL proporcionado no contenía las tablas `publicaciones`, `opciones_encuesta`, `votos_encuesta`; para probar toda Comunidad localmente falta un export de *estructura* de dichas tablas. No subir volcados de producción con cuentas, hashes, tokens, correos o teléfonos.

No ejecutar `scripts/copiar-originales.sh` sobre trabajos ya modificados en este repositorio sin realizar antes una copia de seguridad: su sincronización puede sobrescribir cambios locales.
