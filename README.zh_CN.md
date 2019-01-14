# JSONConfig

这是一个基于Perfect的简单的JSON配置函数库。

通过设置一个扁平化的json文件，您能够更好的配置服务器项目。

## Setup: 

请修改您项目的Package.swift文件

```swift
.package(url: "https://github.com/AutomatonTec/JSONConfig.git", from: "0.1.1")

// 在dependencies章节中
dependencies: ["JSONConfig"]
```

如果按照上述方法改变了Package.swift文件，请更新Xcode项目设置：

```
swift package generate-xcodeproj
```

## 使用方法

```swift
import JSONConfig
// 请在程序中（比如main.swift）设置：
#if os(Linux)
    let configSource = "./config/ApplicationConfiguration_Linux.json"
#else
    let configSource = "./config/ApplicationConfiguration_macOS.json"
#endif

// 其他地方设置
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

您的JSON配置文件看起来像这样：

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
