# Server

Vapor beinhaltet einen HTTP-Server auf Basis von [SwiftNIO](https://github.com/apple/swift-nio). Der Server unterstützt die Protokolle HTTP/1, HTTP/2, TLS (SSL). Ebenso unterstützt er WebSockets. Mehr dazu findest du im Abschnitt [WebSockets](websockets.md).

## Einrichtung

Der Server besitzt mehrere Einstellungen, die über _app.http.server_ eingerichtet oder verändert werden können.

### Servername

Der _Hostname_ ist die Bezeichnung des Servers. Standardmäßig lautet der Name "_127.0.0.1_".

```swift
/// [configure.swift]

// Configure custom hostname.
app.http.server.configuration.hostname = "dev.local"
```

The server configuration's hostname can be overridden by passing the `--hostname` (`-H`) flag to the `serve` command or by passing the `hostname` parameter to `app.server.start(...)`. 

```sh
# Override configured hostname.
vapor run serve --hostname dev.local
```

### Port

Der _Port_ ist die Portnummer des Servers. Der Standard-Port lautet "_8080_". 

```swift
/// [configure.swift]

// Configure custom port.
app.http.server.configuration.port = 1337
```

!!! info
	`sudo` may be required for binding to ports less than `1024`. Ports greater than `65535` are not supported. 


The server configuration's port can be overridden by passing the `--port` (`-p`) flag to the `serve` command or by passing the `port` parameter to `app.server.start(...)`. 

```sh
# Override configured port.
vapor run serve --port 1337
```

### Backlog

Der Parameter _Backlog_ definiert die maximale Anzahl an ausstehenden Verbindungen zum Server. Der Standardwert lautet "_256_".

```swift
/// [configure.swift]

// custom backlog.
app.http.server.configuration.backlog = 128
```

### Reuse Address

Der Parameter _Reuse Adress_ allows for reuse of local addresses. Standardmäßig ist der Parameter aktiviert.

```swift
/// [configure.swift]

// Disable address reuse.
app.http.server.configuration.reuseAddress = false
```

### TCP No Delay

Mit Aktivieren des Parameters _TCP No Delay_ wird versucht die Paketverzögerung so gering wie möglich zu halten. Der Standardwert ist "_true_". 

```swift
/// [configure.swift]

// Minimize packet delay.
app.http.server.configuration.tcpNoDelay = true
```

### Antwortkomprimierung

Der Parameter _Response Compression_ controls HTTP response compression using gzip. Der Standardwert ist "_.disabled_".

```swift
/// [configure.swift]

// Enable HTTP response compression.
app.http.server.configuration.responseCompression = .enabled

// Enable HTTP response compression with an initial buffer capacity
app.http.server.configuration.responseCompression = .enabled(initialByteBufferCapacity: 1024)
```

### Request Decompression

The `requestDecompression` parameter controls HTTP request decompression using gzip. The default is `.disabled`.

```swift
/// [configure.swift]

// Enable HTTP request decompression.
app.http.server.configuration.requestDecompression = .enabled

// Enable HTTP request decompression with size limit
app.http.server.configuration.requestDecompression = .enabled(limit: .ratio(10))

// Enable HTTP request decompression with no size limit
app.http.server.configuration.requestDecompression = .enabled(limit: .none)
```

Available options are:

- `size`: Maximum decompressed size in bytes.
- `ratio`: Maximum decompressed size as ratio of compressed bytes.
- `none`: No size limits.

Setting decompression size limits can help prevent maliciously compressed HTTP requests from using large amounts of memory.

### Pipelining

The `supportPipelining` parameter enables support for HTTP request and response pipelining. The default is `false`. 

```swift
// Support HTTP pipelining.
app.http.server.configuration.supportPipelining = true
```

### Versions

Der Parameter _Support Versions_ legt fest, welche HTTP-Versionen vom Server verwendet werden soll. Wenn TLS aktiviert ist, unterstützt Vapor standardmäßig die beiden Protokolle HTTP/1 und HTTP/2. Sobald TLS deaktiviert wird, wird nur HTTP/1 unterstützt.

```swift
// Disable HTTP/1 support.
app.http.server.configuration.supportVersions = [.two]
```

### TLS

Der Parameter _tlsConfiguration_ legt fest, ob für den Server TLS (SSL) aktiviert werden soll. Standardmäßig ist kein TLS angegeben. 

```swift
/// [configure.swift]

// Enable TLS.
try app.http.server.configuration.tlsConfiguration = .forServer(
    certificateChain: NIOSSLCertificate.fromPEMFile("/path/to/cert.pem").map { .certificate($0) },
    privateKey: .file("/path/to/key.pem")
)
```

For this configuration to compile you need to add `import NIOSSL` at the top of your configuration file. You also might need to add NIOSSL as a dependency in your Package.swift file.

### Name

The `serverName` parameter controls the `Server` header on outgoing HTTP responses. The default is `nil`.

```swift
// Add 'Server: vapor' header to responses.
app.http.server.configuration.serverName = "vapor"
```

## Serve Command

To start up Vapor's server, use the `serve` command. This command will run by default if no other commands are specified. 

```swift
vapor run serve
```

The `serve` command accepts the following parameters:

- `hostname` (`-H`): Overrides configured hostname.
- `port` (`-p`): Overrides configured port.
- `bind` (`-b`): Overrides configured hostname and port joined by `:`. 

An example using the `--bind` (`-b`) flag:

```swift
vapor run serve -b 0.0.0.0:80
```

Use `vapor run serve --help` for more information.

The `serve` command will listen for `SIGTERM` and `SIGINT` to gracefully shutdown the server. Use `ctrl+c` (`^c`) to send a `SIGINT` signal. When the log level is set to `debug` or lower, information about the status of graceful shutdown will be logged.

## Manual Start

Vapor's server can be started manually using `app.server`.

```swift
// Start Vapor's server.
try app.server.start()
// Request server shutdown.
app.server.shutdown()
// Wait for the server to shutdown.
try app.server.onShutdown.wait()
```

## Servers

The server Vapor uses is configurable. By default, the built in HTTP server is used.

```swift
app.servers.use(.http)
```

### Custom Server

Vapor's default HTTP server can be replaced by any type conforming to `Server`. 

```swift
import Vapor

final class MyServer: Server {
	...
}

app.servers.use { app in
	MyServer()
}
```

Custom servers can extend `Application.Servers.Provider` for leading-dot syntax.

```swift
extension Application.Servers.Provider {
    static var myServer: Self {
        .init {
            $0.servers.use { app in
            	MyServer()
            }
        }
    }
}

app.servers.use(.myServer)
```
