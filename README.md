# JSONConfig [简体中文](README.zh_CN.md)

This is a simple json based configuration library for Perfect.

Rather than presenting a flat json file for your configuration needs, this library lets you organize it a bit more.

## Setup: 

Include the JSONConfig dependency in your project's Package.swift file:

``` swift
.package(url: "https://github.com/AutomatonTec/JSONConfig.git", from: "1.1.2")

// section dependencies
dependencies: ["JSONConfig"]
```

Rebuild your Xcode project after changing your Package.swift file.

```
swift package generate-xcodeproj
```

## Example usage:

```swift
import JSONConfig
// somewhere, perhaps in main.swift, determine the path to your config file

let configServerDefaults = "./config/server/common.json"
#if os(Linux)
    let configServer = "./config/server/linux.json"
#else
    let configServer = "./config/server/macOS.json"
#endif

let config = JSONConfig(withJsonAt:configServer, defaultsInJsonAt:configServerDefaults)

// somewhere, anywhere
func setupDatabase(withConfig config:JSONConfig) {
    MySQLConnector.host     = config.string(forKeyPath: "database.host", otherwise: "127.0.0.1")
    MySQLConnector.username = config.string(forKeyPath: "database.username", otherwise: "db_user")
    MySQLConnector.password = config.string(forKeyPath: "database.password", otherwise: "best_password")
    MySQLConnector.database = config.string(forKeyPath: "database.database", otherwise: "db_user")
}

func setupServer(withConfig config:JSONConfig, server:HTTPServer) {
    server.serverName = config.string(forKeyPath: "server.name", otherwise: "sub.your-domain.com")
    server.serverPort = UInt16(config.integer(forKeyPath: "server.port", otherwise: 8080))
}
```

In your common json configuration file, you might have something like:

```json
{
	"server": {
		"name" : "api.your-domain.com",
		"port" : 80
	},
    "database": {
        "host":     "127.0.0.1",
        "username": "db_bob",
        "password": "bob_password",
        "database": "db_bob"
    }
}
```

And in your macOS json configuration file, you might have something like:

```json
{
	"server": {
		"name" : "localhost",
		"port" : 8181
	}
}
```
