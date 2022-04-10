# Server

Vapor beinhaltet einen HTTP-Server auf Basis von [SwiftNIO](https://github.com/apple/swift-nio). Der Server unterstützt die Protokolle HTTP/1, HTTP/2. Ebenso erlaubt er das Aktivieren von TLS (SSL) und unterstützt [WebSockets](websockets.md).

## Einrichtung

Der Server besitzt mehrere Einstellungen, die über _app.http.server_ eingerichtet oder verändert werden können.

### Hostname

Der _Hostname_ ist die Bezeichnung des Servers. Der Standard-Hostname lautet "_127.0.0.1_".

```swift
/// [configure.swift]

// custom hostname.
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

// custom port.
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

Der Parameter _Reuse Adress_ `reuseAddress` allows for reuse of local addresses. Der Standardwert ist "_true_".

```swift
/// [configure.swift]

// Disable address reuse.
app.http.server.configuration.reuseAddress = false
```

### TCP No Delay

Der Parameter _TCP No Delay_ legt fest attempt to minimize TCP packet delay. Der Standardwert ist "_true_". 

```swift
/// [configure.swift]

// Minimize packet delay.
app.http.server.configuration.tcpNoDelay = true
```

### Response Compression

The `responseCompression` parameter controls HTTP response compression using gzip. The default is `.disabled`.

```swift
/// [configure.swift]

// Enable HTTP response compression.
app.http.server.configuration.responseCompression = .enabled
```

To specify an initial buffer capacity, use the `initialByteBufferCapacity` parameter.

```swift
.enabled(initialByteBufferCapacity: 1024)
```

### Request Decompression

The `requestDecompression` parameter controls HTTP request decompression using gzip. The default is `.disabled`.

```swift
// Enable HTTP request decompression.
app.http.server.configuration.requestDecompression = .enabled
```

To specify a decompression limit, use the `limit` parameter. The default is `.ratio(10)`.

```swift
// No decompression size limit
.enabled(limit: .none)
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

The `supportVersions` parameter controls which HTTP versions the server will use. By default, Vapor will support both HTTP/1 and HTTP/2 when TLS is enabled. Only HTTP/1 is supported when TLS is disabled. 

```swift
// Disable HTTP/1 support.
app.http.server.configuration.supportVersions = [.two]
```

### TLS

The `tlsConfiguration` parameter controls whether TLS (SSL) is enabled on the server. The default is `nil`. 

```swift
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
