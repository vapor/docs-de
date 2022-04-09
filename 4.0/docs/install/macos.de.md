# Installation auf macOS

Die Mindestvoraussetzung für Vapor ist Swift 5.2 oder höher.

## Install Xcode

Xcode ist eine Entwicklungsumgebung von Apple. Du findest die App im [AppStore](https://itunes.apple.com/us/app/xcode/id497799835?mt=12). Mit der Installation von Xcode wird auch Swift installiert.

![Xcode in Mac App Store](../images/xcode-mac-app-store.png)

Sobald die App heruntergeladen ist, führe die Installation aus. Öffne nach der Installation auch noch einmal Xcode um die Installation komplett abzuschließen. Mit dem Termin-Befehl `swift --version` kannst du nun überprüfen, ob die Installation von Swift erfolgreich verlief und welche Version installiert wurde.

```sh
swift --version

Apple Swift version 5.2 (swiftlang-1100.0.270.13 clang-1100.0.33.7)
Target: x86_64-apple-darwin19.0.0
```

## Install Toolbox

Now that you have Swift installed, let us install the [Vapor Toolbox](https://github.com/vapor/toolbox). This CLI tool is not required to use Vapor but it includes helpful utilities like a new project creator.

Toolbox is distributed via Homebrew. If you do not have Homebrew yet, visit <a href="https://brew.sh" target="_blank">brew.sh</a> for install instructions.

```sh
brew install vapor
```

Double check to ensure that the installation was successful by printing help.

```sh
vapor --help
```

You should see a list of available commands.

## Next

Now that you have installed Swift and Vapor Toolbox, create your first app in [Getting Started &rarr; Hello, world](../hello-world.md).
