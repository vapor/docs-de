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

Der Ordner _Public_ beinhaltet Dateien, die sozusagen mitveröffentlicht werden. Das können Dateien sein, die für die Seitendarstellung benötigt werden wie z.B. Bilder, Stylesheets (.css) oder auch Skripte (.js). Damit Vapor während der Ausführung auf den Ordner zugreifen kann muss eine _FileMiddleware_ in der Datei `configure.swift` mitangegeben werden.

```swift
// Serves files from `Public/` directory
let fileMiddleware = FileMiddleware(
    publicDirectory: app.directory.publicDirectory
)
app.middleware.use(fileMiddleware)
```

## Sources

Im Ordner _Sources_ befinden sich die Anwendungsdateien. Die Unterordner _App_ und _Run_ stellen die Paketmodule dar. Mehr dazu findest du im Abschnitt [Swift Package Manager](spm.md).

### App

Der Ordner _App_ beinhaltet die Anwendungslogik.

#### Controllers

Der Ordner _Controllers_ beinhaltet die Endpunktdefinitionen der Anwendung. Mehr dazu findest du im Abschnitt [Controllers](controllers.md).

#### Migrations

Der Ordner _Migrations_ beinhaltet die Tabellendefinitionen der Datebank.

#### Models

Der Ordner _Models_ beinhaltet mögliche Klassendefinitionen für deine Model oder Entitäten.

#### configure.swift

Die Datei _configure.swift_ umfasst die Methode `configure(_:)`. Sie wird in der Datei `main.swift` aufgerufen um die Anwendung mit entsprechenden Angaben zu Endpunkten, zur Datenbank oder zu Providern zu konfigurieren.

#### routes.swift

Die Datei _routes.swift_ beinhaltet die Methode `routes(_:)`. Sie wird am Ende von der `configure(_:)`-Methode aufgerufen um die Endpunkte zu registrieren. 

### Run

Der Ordner _Run_ stellt die Ausführungsdatei dar.

#### main.swift

Die Datei _main.swift_ erstellt eine Instanz der Anwendung und führt diese aus.

## Tests

Each non-executable module in your `Sources` folder can have a corresponding folder in `Tests`. This contains code built on the `XCTest` module for testing your package. Tests can be run using `swift test` on the command line or pressing ⌘+U in Xcode. 

### AppTests

This folder contains the unit tests for code in your `App` module.

## Package.swift

Finally is [SPM](spm.md)'s package manifest.

