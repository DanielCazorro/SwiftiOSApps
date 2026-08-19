# Watchlist

Lista de películas pendientes de ver, con SwiftUI + SwiftData. iOS 26.5, Xcode 26.

## Estructura

```
Watchlist/
├── App/            WatchlistApp — construye el ModelContainer
├── Core/
│   ├── Models/     Movie, Genre, MovieDraft, WatchlistQuery (sort/filter/predicate)
│   ├── Persistence/MovieStore (escrituras), PreviewContainer (datos de muestra)
│   └── DesignSystem/ Theme — espaciados, radios, animaciones
├── Components/     Piezas reutilizables sin lógica de negocio
├── Features/
│   ├── Watchlist/  Pantalla principal + su ViewModel
│   └── MovieForm/  Alta/edición + su ViewModel
└── Resources/      Localizable.xcstrings (en, es)
```

## Decisiones de arquitectura

**MVVM parcial, no dogmático.** `@Query` tiene que vivir en la vista para seguir
siendo reactivo ante los cambios de SwiftData; meterlo en un ViewModel rompe esa
reactividad. Así que los ViewModels se quedan con lo que sí gana al extraerse:
estado de UI (búsqueda, orden, filtro, routing de sheets), validación y las
reglas de negocio. Las vistas solo declaran intención.

**`MovieStore` es la única puerta de escritura.** Ninguna vista toca
`ModelContext` directamente. Es un `struct` sobre el contexto, así que crearlo en
cada `body` es gratis.

**`MovieDraft` desacopla el formulario del modelo.** Editar un `@Model` a mano
escribe en la base a cada pulsación y deja «Cancelar» sin nada que deshacer. El
formulario trabaja sobre un valor y se confirma una sola vez al guardar.

**El género se persiste como `Int` (`genreID`).** `#Predicate` y `SortDescriptor`
solo llegan a propiedades almacenadas de tipos primitivos: sin el raw value no se
podría filtrar ni ordenar por género en la base de datos.

## Trucos útiles

- `-seedSampleData` como argumento de lanzamiento (Debug) arranca con datos de
  muestra en memoria. Útil para capturas y para probar sin ensuciar el store.
- Los `#Preview` usan `PreviewContainer.empty` / `.populated`; ninguno toca disco.
- `WatchlistView` tiene un preview con `\.locale = "es"` para revisar traducciones
  sin cambiar el idioma del simulador.

## Localización

Todos los textos salen de `Resources/Localizable.xcstrings` (inglés y español,
con plurales donde hacen falta). No hay strings literales en las vistas.
