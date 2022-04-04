# Ordnerstruktur

Lass und einen Blick auf die Ordnerstruktur von Vapor werfen. Die Ordnersturktur von Vapor orentiert sich an der Orderstruktur des [Swift Package Managers](spm.md). Falls du schon mal mit dem SPM gearbeitet hast, sollte sie dir bekannt vorkommen.

```
.
├── Public
├── Sources
│   ├── App
│   │   ├── Controllers
│   │   ├── Migrations
│   │   ├── Models
│   │   ├── configure.swift
│   │   └── routes.swift
│   └── Run
│       └── main.swift
├── Tests
│   └── AppTests
└── Package.swift
```

## Public

Der Ordner _Public_ beinhaltet alle öffentlich zugänglichen Dateien, die für deine Seite bzw. manche Seitenansichten benötigt werden wie z.B. Bilder (.jpeg, .png etc.), Stylesheets (.css) oder auch Skripte (.js). Damit Vapor auf den Ordner zugreifen kann muss eine sogenannte `FileMiddleware` in der Datei `configure.swift` mitangegeben werden.

```swift
// Serves files from `Public/` directory
let fileMiddleware = FileMiddleware(
    publicDirectory: app.directory.publicDirectory
)
app.middleware.use(fileMiddleware)
```

## Sources

Der Ordner _Sources_ beinhaltet alle Programmdateien des Projektes. Die Unterordner _App_ und _Run_ stellen Paketmodule dar. Mehr dazu findest du im Abschnitt [Swift Package Manager](spm.md).

### App

Der Ordner _App_ beinhaltet die Programmlogik.

#### Controllers

Mittels _Controller_ kannst du deinen Code strukturieren und in deinem Projekt für Übersicht sorgen. Ein Controller kann ein oder mehrere Methoden besitzen, die grunsätzlich dazu da sind die (Web)Anfragen entgegenzunehmen und ein enstprechendes Ergebnis zurückzuliefern. Mehr dazu findest du im Abschnitt [Controllers](controllers.md).

#### Migrations

Der Ordner _Migrations_ beinhaltet die Tabellendefinitionen deiner Datebank, solltest du _Fluent_ verwenden.

#### Models

Der Ordner _Models_ beinhaltet mögliche Klassendefinitionen für deine Model oder Entitäten.

#### configure.swift

This file contains the `configure(_:)` function. This method is called by `main.swift` to configure the newly created `Application`. This is where you should register services like routes, databases, providers, and more. 

#### routes.swift

This file contains the `routes(_:)` function. This method is called near the end of `configure(_:)` to register routes to your `Application`. 

### Run

This is the main executable target, containing just the code needed to get your application up and running.

#### main.swift

This file creates and runs a configured instance of your Vapor `Application`.

## Tests

Each non-executable module in your `Sources` folder can have a corresponding folder in `Tests`. This contains code built on the `XCTest` module for testing your package. Tests can be run using `swift test` on the command line or pressing ⌘+U in Xcode. 

### AppTests

This folder contains the unit tests for code in your `App` module.

## Package.swift

Finally is [SPM](spm.md)'s package manifest.

