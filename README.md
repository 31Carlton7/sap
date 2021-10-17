<img src="https://github.com/31Carlton7/sap/blob/master/assets/images/banner.png\"> </img>

# Sap

Sap is a music streaming & discovery app built with the [Deezer API](https://developers.deezer.com/) for iOS and Android. It includes a mini player, search and local storage. Be sure to leave a star 🌟.

[License](https://github.com/31Carlton7/sap/blob/master/LICENSE)

[Screenshots](#screenshots)

## Developer Info

The API for getting the music and other information are courtesy of [Deezer](https://developers.deezer.com/).
To build the app I utilized the [Flutter SDK](https://flutter.dev) as the UI Framework and that uses [Dartlang](https://dart.dev) as the programming language. The list of packages the app uses can be found [here](https://github.com/31Carlton7/sap/blob/master/pubspec.yaml) under the `dependencies` indent. My UI Package I use to curate the UI can be found [here](https://github.com/31Carlton7/canton_design_system), however I will not be publishing the package on [pub.dev](pub.dev) anytime soon. This project is null safe. I also used Firebase Analytics and Crashlytics to better understand the users who use the app. There is no form of authentication or database usage.

## FAQ

<details>
<summary>Why are all the songs only 30 seconds long?</summary>
Sap plays the preview of every song rather than the actual song. The Deezer API does not provide the actual song link.
</details>

<details>
<summary>Can I load my own music?</summary>
No.
</details>

<details>
<summary> Why did you name it Sap?</summary>
Special thanks to my sister, she gave me the idea to name the app "Sap".
</details>

## Features

- _Mini Player_: A persistent mini player to play music. Has a full-screen version with slider and seek controls.
- _Download Music_: Save all music locally to the device, and play it whenever you want.
- _Search_: Search for Albums, Artists & Songs from Deezer's catalog.
- _Artist Stats_: Get artist stats and most popular songs.
- _Top Albums_: See what's new with the top albums feature in the browse screen.
- _Top Playlists_: See what music is trending with the top playlists feature in the browse screen.
- _Top Songs_: Get the top 10 songs currently.
- _Liked Songs_: Like songs and add them to your Liked Songs, and find them in the Liked Songs Screen.

## Getting Started

Assuming Flutter is installed and setup on your device (If not, follow the steps to do so [here](https://flutter.dev/docs/get-started/install)), Fork, clone, or download the code for this repository and navigate to the enclosing folder inside your terminal. Then use this command to run:

```
flutter run
```

## Screenshots

Coming soon!

## Socials

If you have any questions, you can reach me here:

- Instagram: [@31carlton7](https://www.instagram.com/31carlton7/)
- Email: carltonaikins7@gmail.com
