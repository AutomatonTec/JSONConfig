# JSONConfig

Perfect Empty Starter Project, plus a few steps

This project started off as a blank Perfect project. Then I added a bunch from [raywenderlich.com's great tutorial series.](https://videos.raywenderlich.com/courses/77-server-side-swift-with-perfect/lessons/6) and what I learned from Jonathan Guthrie's post [Easily Secure your Perfect Server Side Swift code with HTTPS](https://medium.com/@iamjono/easily-secure-your-perfect-server-side-swift-code-with-https-3df86a8cab28)

I'm going to write about the process in my [blog... link to be updated.](http://automatontec.ca)

## Compatibility with Swift

The master branch of this project currently compiles with **Xcode 8.2** or the **Swift 3.0.2** toolchain on Ubuntu.

## Building & Running

The following will clone and build an the starter project and launch the server on port 8081 if built/run on Xcode or port 443 if built/run from the command line. But to get to that point, you'll have to either read my blog post or Guthrie's post. First it will startup with port 80 from the command line.

```
git clone https://github.com/AutomatonTec/Acronym.git
cd Acronym
swift build
.build/debug/Acronym
```

You should see the following output:

```
[INFO] Running setup: acronym
[INFO] Starting HTTP server sub.your-domain.com on 0.0.0.0:80
```

If you are running it from Xcode, you should see the following output:

```
[INFO] Running setup: acronym
[INFO] Starting HTTP server sub.your-domain.com on 0.0.0.0:8081
```

This means the server is running and waiting for connections. 

Hit control-c to terminate the server.

## Starter Content

I wanted a starter project that would allow for the use of port 443. Not using https can make for complications in app development. It is what is expected and required for many applications.

I also wanted a starting point that didn't just plop things in main. The main in this project looks like this:

```swift
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

Environment.initializeDatabaseConnector()

let setupObj = Acronym()
try? setupObj.setup()

let basic = BasicController()
let files = FilesController()

let server = HTTPServer()
server.serverName = Environment.serverName
server.serverPort = Environment.serverPort

server.addRoutes(Routes(basic.routes))
server.addRoutes(Routes(files.routes))

if let tls = Environment.tls {
    server.ssl              = (tls.certPath, tls.keyPath ?? tls.certPath)
    server.caCert           = tls.caCertPath
    server.certVerifyMode   = tls.certVerifyMode
    server.cipherList       = tls.cipherList
}

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
```



## Further Information
For more information on the Perfect project, please visit [perfect.org](http://perfect.org).
