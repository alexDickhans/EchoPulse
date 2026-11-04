# MatchPulse

iOS Live Activities for VEX V5 Robotics Competition matches. The Xcode project is EchoPulse.

Enter a team number, pick an event, and start a Live Activity. The Lock Screen and Dynamic Island show the last match, the next match on the field, and your team’s next match. Push updates continue while the app is in the background.

<p align="center">
  <img src="EchoPulse/Assets.xcassets/AppIcon.appiconset/Artboard%202.png" alt="MatchPulse icon" width="128">
</p>

## Requirements

- macOS with Xcode 16.2 or later
- iOS 18 or later
- A [RobotEvents API token](https://www.robotevents.com/api/v2)

Live Activity push tokens are issued only on a physical iPhone.

## Setup

1. Open `EchoPulse.xcodeproj`.
2. Set your Apple Development Team on the EchoPulse and CompetitionExtension targets.
3. Copy `Config.plist.example` to `EchoPulse/Config.plist` and paste your token. That file is gitignored. Do not put the token in a shared Xcode scheme.
4. Run the **EchoPulse** scheme.

`ROBOTEVENTS_API_KEY` in the process environment is also accepted, and takes priority over the plist.

## What it talks to

Match data comes from the RobotEvents API. Starting an activity registers the device with `https://echoscopebackend.onrender.com` so the Live Activity can be updated remotely. Stopping the activity unsubscribes.

## Credits

Developed by Alex Dickhans.

`EchoPulse/RoboScoutAPI.swift` and `EchoPulse/UserSettings.swift` are adapted from [VRC RoboScout](https://github.com/SunkenSplash/VRC-RoboScout) by William Castro.
