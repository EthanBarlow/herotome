# herotome

Scroll through a list of characters and find some you've never seen or heard of. Search (*coming soon*) for that name you've heard again and again but are unfamiliar with. Select a character to learn more on their biography page which is broken into a section for movies and comics.


This project is for 2 categories of people. 1) Those who are Marvel fanatics and want to know everything about everything related to Marvel. 2) Friends and/or family of person #1 who hear all these character names and need a quick way to get some info.

Marvel does have an API, but the limit is 3000 calls per day. Additionally, and more importantly I couldn't find some of the info that I wanted through the API. So, I wrote a separate web scraper to get everything I wanted and upload that to Firebase.

*Note: In case this was a question - This app is not officially affiliated with Marvel.*

## Running the app

My environment:
```
C:\User\herotome>flutter --version

Flutter 2.5.0 • channel stable • https://github.com/flutter/flutter.git  
Framework • revision 4cc385b4b8 (2 weeks ago) • 2021-09-07 23:01:49 -0700
Engine • revision f0826da7ef
Tools • Dart 2.14.0
```

Clone this project and make sure to run ```flutter pub get``` to install dependencies.

If you want to set up your own firebase collection and integrate it here, go for it! However, this repo is currently set up to run locally using mock data. Only Android development setup is outlined. If you want to see the (public) changes made involving the firebase setup, look at this [commit](https://github.com/EthanBarlow/herotome/commit/d663b2e9041a69ebcbbfafc9aeef1b2b428c0abe). 

In summary, I removed some lines from Android project specific files (gradle), commented out some firebase initialization code (dart), and swapped out real data repositories for fake ones. 

From here you should be able to run the project and see a single hero profile card and be able to view the detailed biography.
