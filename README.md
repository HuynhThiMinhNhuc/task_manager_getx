- [About Todo App](#about_to_do_app)
    - [Requirement, feature list, Techs](#requirement)
    - [Screenshots and Video demo](#screenshoot-and-video-demo)
- [How to run this application?](#How-to-run-this-application?)
- [Contact](#Contact)

# About Todo App
Todo App is a Flutter project with some informations below:
## Requirement vs feature list
- About Requirement - [Reference](https://drive.google.com/drive/folders/1dFsp3GZ40lc8gURTDVCPQgrbBpxc6enk?usp=sharing)

- Feature list:

    * Add new a todo item
    * Update a todo item
    * Delete new todo item
    * View all todos item
    * View all todos item is completion
    * View all todos item is incompletion

- Technicals:

    * MVC architecture with [GetX Package](https://pub.dev/packages/get)
    * Use [sqflite](https://pub.dev/packages/sqflite) to manage and save data at local
    * Setup 3 environment for the app(dev, stg, prod)
    * Setup CI/CD with Firebase

## Screenshots and video demo

- Screenshots:

# How to run this application(on VsCode)?

1. Start a simulator(iOS or Android)
2. Open terminal and go to root project directory after that run command belove:

Run app with developer environment:
```yaml
flutter clean && flutter pub get && flutter run --flavor dev -t lib/main_dev.dart 
```
Note: Other environment(stg, prod) to build file(ipa or apk) for test on device.

# Contact

Nick Name: Minh Nhuc
My email: huynhthiminhnhuc@gmail.com

