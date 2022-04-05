# Ordnerstruktur

Lass uns einen Blick auf die Ordnerstruktur von Vapor werfen. Die Ordnerstruktur von Vapor orientiert sich an den Vorgaben des [Swift Package Managers](spm.md). Falls du schon mal mit dem SPM gearbeitet hast, sollte dir die Struktur bekannt vorkommen.

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

Der Ordner _Public_ beinhaltet Dateien, die sozusagen mitveröffentlicht werden. Das können z.B. Dateien sein, die für die Seitendarstellung benötigt werden wie z.B. Bilder (.jpeg, .png etc.), Stylesheets (.css) oder auch Skripte (.js). Damit Vapor während der Ausführung auf den Ordner zugreifen kann muss eine sogenannte _FileMiddleware_ in der Datei `configure.swift` mitangegeben werden.

```swift
// Serves files from `Public/` directory
let fileMiddleware = FileMiddleware(
    publicDirectory: app.directory.publicDirectory
)
app.middleware.use(fileMiddleware)
```

## Sources

Im Ordner _Sources_ befinden sich die Anwendungsdateien des Projektes. Die Unterordner _App_ und _Run_ stellen die Paketmodule dar. Mehr dazu findest du im Abschnitt [Swift Package Manager](spm.md).

### App

Der Ordner _App_ beinhaltet die Anwendungslogik.

#### Controllers

Der Ordner _Controllers_ beinhaltet die Endpunktdefinitionen der Anwendung. Mehr dazu findest du im Abschnitt [Controllers](controllers.md).

#### Migrations

Der Ordner _Migrations_ beinhaltet die Tabellendefinitionen der Datebank.

#### Models

Der Ordner _Models_ beinhaltet mögliche Klassendefinitionen für deine Model oder Entitäten.

#### configure.swift

Die Datei beinhaltet die Methode `configure(_:)`. Die Methode wird von der Datei `main.swift` aufgerufen um deine Anwendung mit den möglichen Angaben zu den Endpunkten, zur Datenbank oder zu Providern in der Methode zu konfigurieren.

#### routes.swift

Die Datei beinhaltet die Methode `routes(_:)`. Sie wird am Ende von der `configure(_:)`-Methode aufgerufen um die Anwendungsendpunkte zu registrieren. 

### Run

Der Ordner _Run_ stellt das Ausführungsziel dar.

#### main.swift

This file creates and runs a configured instance of your Vapor `Application`.

## Tests

Each non-executable module in your `Sources` folder can have a corresponding folder in `Tests`. This contains code built on the `XCTest` module for testing your package. Tests can be run using `swift test` on the command line or pressing ⌘+U in Xcode. 

### AppTests

This folder contains the unit tests for code in your `App` module.

## Package.swift

Finally is [SPM](spm.md)'s package manifest.

