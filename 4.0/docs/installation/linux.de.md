# Installation unter Linux

Die Mindestvorraussetzung für Vapor ist die Swift-Version 5.2 oder höher. Unter [Swift.org](https://swift.org/download/) kannst du Swift herunterladen und installieren.

## Unterstütze Distributionen und Versionen

Vapor unterstützt die Linux Distributionen gleich der, die Swift-Version 5.2 oder höher unterstützt.

|Distribution|Version        |Swift Version|
|------------|---------------|-------------|
|Ubuntu      |16.04, 18.04.  |>= 5.2.      |
|Ubuntu.     |20.04          |>= 5.2.4.    |
|Fedora.     |>= 30          |>= 5.2       |
|CentOS.     |8.             |>= 5.2.4.    |
|Amazon Linux|2.             |>= 5.2.4.    |
|_Die Angaben können abweichen. Für offizielle Daten siehe [Swift Releases](https://swift.org/download/#releases)_|

Es kann gut möglich sein, dass Swift auch auf Linux Distributionen läuft, die nicht offiziell unterstützt werden. Allerdings kann Vapor das nicht garantieren. Mehr Informationen dazu unter [Swift repo](https://github.com/apple/swift#getting-started).

## Swift-Installation

Auf der Seite [Swift.org Using Downloads](https://swift.org/download/#using-downloads) findest du eine Anleitung, wie du Swift unter Linux installierst.

### Fedora

Fedora-Nutzer können folgenden Befehl ausführen

```sh
sudo dnf install swift-lang
```

Solltest du jedoch Fedora 30 verwenden, benötigst du EPEL 8 um Swift 5.2 zum Laufen zu bringen.

### Docker

Du kannst ebenso das offizielle Docker-Image benutzen. Mehr Informationen dazu findest du unter [Swift's Docker Hub](https://hub.docker.com/_/swift).

## Toolbox-Installation

Neben Swift kannst du auch die Vapor-Toolbox installieren. Die Toolbox ist zwar für Vapor nicht zwingend notwendig, aber beinhaltet Befehle, die dich bei der Arbeit mit Vapor unterstützen.

Unter Linux muss die Toolbox erst von [Github Toolbox](https://github.com/vapor/toolbox/releases) geladen und anschließend installiert werden.

```sh
git clone https://github.com/vapor/toolbox.git
cd toolbox
git checkout <desired version>
make install
```

Im Anschluss kannst du die Installation überprüfen, indem du den Befehl 

```sh
vapor --help
```

ausführst. Dir sollten nun mehrere Befehl der Toolbox angezeigt werden.

Nach der Swift-Installation kannst du mit der Erstellung deiner ersten Vapor-Anwendung beginnen. Folge dazu den Abschnitt [Erste Schritte &rarr; Hello, world](../hallo-welt.md).
