# JSONConfig

This is a simple json based configuration library for Perfect.

Rather than presenting a flat json file for your configuration needs, this library lets you organize it a bit more.

## Setup: 

Include the JSONConfig dependancy in your project's Package.swift file:

```swift
.Package(url: "https://github.com/AutomatonTec/JSONConfig.git", majorVersion: 0)
```

Rebuild your Xcode project after changing your Package.swift file.

```
swift package generate-xcodeproj
```

## Example usage:

```swift
import JSONConfig
// somewhere, perhaps in main.swift, determine the path to your config file
#if os(Linux)
    let configSource = "./config/ApplicationConfiguration_Linux.json"
#else
    let configSource = "./config/ApplicationConfiguration_macOS.json"
#endif

// somewhere, anywhere
func setupDatabase() {
    MySQLConnector.host     = JSONConfig.shared.string(forKeyPath: "database.host", otherwise: "127.0.0.1")
    MySQLConnector.username = JSONConfig.shared.string(forKeyPath: "database.username", otherwise: "db_user")
    MySQLConnector.password = JSONConfig.shared.string(forKeyPath: "database.password", otherwise: "best_password")
    MySQLConnector.database = JSONConfig.shared.string(forKeyPath: "database.database", otherwise: "db_user")
}

func setupServer(server:HTTPServer) {
    server.serverName = JSONConfig.shared.string(forKeyPath: "server.name", otherwise: "sub.your-domain.com")
    server.serverPort = UInt16(JSONConfig.shared.integer(forKeyPath: "server.port", otherwise: 8080))
}
```

In your configuration json file, you can have something like:

```json
{
    "server": {
        "name": "www.your-domain.com",
        "port": 80
    },
    "database": {
        "host":     "127.0.0.1",
        "username": "db_bob",
        "password": "bob_password",
        "database": "db_bob"
    }
}
```
