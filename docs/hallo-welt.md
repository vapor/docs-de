# Hallo Welt!

Die Anleitung erklärt Schritt für Schritt, wie du ein Vapor-Projekt erstellst und ausführst.

Sollte dir "Swift" oder die "Vapor Toolbox" noch fehlen, werfe zuerst einen Blick in die folgenden Abschnitte:

- [Installation &rarr; macOS](install/macos.md)
- [Installation &rarr; Linux](install/linux.md)


## Projekt erstellen

Starte die Terminal-App auf deinem Mac und führe den Toolbox-Befehl aus. Der Befehl erstellt einen Projektordner mitsamt den Dateien.

```sh
vapor new hello -n
```

Sobald der Befehl durchgelaufen ist, wechsele in den neu erstellten Projektordner mit dem Befehl

```sh
cd hello
``` 

## Projekt ausführen

### mit Xcode

Öffne nun das Projekt mit dem Befehl

```sh
open Package.swift
```

Xcode öffnet sich und lädt zu Beginn die Paketverweise. Nach dem Laden sollte dir Xcode zur Verfügung stehen.

Wähle anschließend in der Mitte eine Schema (oft einfach nur "Mein Mac") aus. Starte nun das Projekt über die Menüpunkte "Produkt" > "Starten".

Du solltest nun in der Konsole einen Eintrag wie diesen sehen:

```sh
[ INFO ] Server starting on http://127.0.0.1:8080
```

### mit Linux

Für Linux und andere Distributionen (oder falls du einfach kein Xcode verwendest) kannst du den Editor deiner Wahl nutzen, wie z.B. Vim oder VSCode. Mehr Informationen hierzu findest du unter [Swift Server Guides](https://github.com/swift-server/guides/blob/main/docs/setup-and-ide-alternatives.md).

Starte das Projekt mit dem Befehl

```sh
swift run
```

Bei der Erstausführung werden die Paketverweise nachgeladen. Dementsprechend kann die Erstellung ein wenig brauchen. Nach dem Laden solltest einen Eintrag im Terminal sehen

```sh
[ INFO ] Server starting on http://127.0.0.1:8080
```

## Aufruf im Browser

Rufe die Seite über den Link <a href="http://localhost:8080/hello" target="_blank">localhost:8080/hello</a> oder <a href="http://127.0.0.1:8080" target="_blank">http://127.0.0.1:8080</a> im Browser auf.

Als Ergebnis solltest du "Hello World" im Browser sehen.

```html
Hello, world!
```

Das wars! Geschafft! Gratulation zur ersten Vapor-Anwendung. 🎉
