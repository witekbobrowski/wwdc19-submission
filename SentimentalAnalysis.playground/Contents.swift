import UIKit
import PlaygroundSupport

// Welcome to my WWDC19 playground!

// Create a user for yourself 🤩
let user: User? = User(
    username: "witekbobrowski",
    fullName: "Witek Bobrowski",
    avatar: "👨🏻‍💻" // Remeber to use a single emoji for the avatar!
)
// Psst. Avatars with emojis from Animoji are already taken, so you might
// want to choose a different one 🙃

let scene = SceneViewController()
let home = HomeViewController(
    quackController: QuackController(current: user)
)
scene.contentViewController = home
home.scene = scene

let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 760, height: 960))
window.rootViewController = scene
window.makeKeyAndVisible()

PlaygroundPage.current.liveView = window
