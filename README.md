# UpHome

## Descripción
UpHome es una aplicación móvil desarrollada en Flutter para la gestión y renta de propiedades inmobiliarias. Permite a los usuarios explorar proyectos inmobiliarios, ver detalles de propiedades y simular la conexión con dispositivos inteligentes.

## Versión de Flutter
Este proyecto fue desarrollado utilizando Flutter 3.27.1.

## Instalación
Para instalar y ejecutar este proyecto, sigue estos pasos:

1. Asegúrate de tener Flutter 3.27.1 instalado en tu sistema.
2. Clona este repositorio.
3. Ejecuta `flutter pub get` en la raíz del proyecto para instalar las dependencias.
4. Ejecuta `flutter run` para iniciar la aplicación en un emulador o dispositivo conectado.

## Arquitectura
El proyecto utiliza Clean Architecture para mantener una separación clara de responsabilidades y facilitar la escalabilidad y mantenimiento del código.

## Gestión de Estado
Se utiliza Riverpod para la gestión del estado de la aplicación, proporcionando una forma eficiente y predecible de manejar los datos y la lógica de negocio.

## Simulación de Dispositivos Bluetooth
La aplicación simula la detección y conexión con dispositivos Bluetooth. Permite obtener una lista de dispositivos disponibles y simular la conexión con ellos.

## Base de Datos
Se utiliza SQLite para el almacenamiento local de datos. La implementación actual es una simulación y está preparada para una futura migración a una base de datos real.

## Temas Dinámicos
Al ingresar a los detalles de cualquier proyecto, el tema de la aplicación cambia dinámicamente para reflejar la identidad visual de la agencia inmobiliaria correspondiente.

## Migración a Servicios Reales
La arquitectura está diseñada para facilitar la migración de servicios simulados a servicios reales. Para realizar esta migración:

1. Implementa el nuevo servicio real.
2. Inyecta el servicio en un proveedor de Riverpod.
3. Cambia la configuración del ambiente en el archivo `main.dart`.

## Características Adicionales
- Se ha implementado un [CHANGELOG.md](./CHANGELOG.md) para rastrear y visualizar los cambios en el proyecto.

## Estado Actual del Proyecto
El proyecto esta finalizado.

## Próximos Pasos
- Completar la implementación de todas las funcionalidades descritas en los requisitos.

## Demo
- [Descargar video demo](https://github.com/sooyvilla/uphome_app/raw/main/demo/ScreenRecording_12-27-2024%2012-55-17_1.MP4)
- [Descargar video demo 2](https://github.com/sooyvilla/uphome_app/blob/main/demo/Grabaci%C3%B3n%20de%20pantalla%202025-01-19%20a%20la(s)%2010.32.35%E2%80%AFp.m..mov)
