# AegisMVP

Offline-first iOS survival MVP scaffold built with SwiftUI + SQLite + RealityKit.

## What was built
- Home, Library, Article Detail, Knot Viewer, Map, and Settings screens.
- True-black high-contrast theme and reusable UI components.
- SQLite seed schema + content (4 categories, 12 articles, 48 steps).
- First-launch DB init to `Application Support/Aegis/System/basic_survival.sqlite`.
- Mapbox configuration scaffold with token injection via xcconfig.
- Diagnostics (app version, build number, DB version, DB init date).

## Project structure
- Swift package root (`Package.swift`) with source under `AegisMVP/`.
- Xcode project is not generated in this Linux environment.
- Open package in Xcode on macOS and run as iOS app target after creating an app host target if needed.

## Setup
1. Duplicate `AegisMVP/Config/Secrets.template.xcconfig` to `AegisMVP/Config/Secrets.xcconfig`.
2. Add your token:
   - `MAPBOX_ACCESS_TOKEN = <YOUR_TOKEN>`
3. In Xcode, include `Secrets.xcconfig` in your app target build configuration.
4. Ensure `AegisMVP/Resources/Models/sampleKnot.usdz` exists to enable 3D model rendering.

## SQLite seeding behavior
On first app launch:
1. App creates `Application Support/Aegis/System/`
2. App creates `basic_survival.sqlite`
3. Executes bundled SQL at `AegisMVP/Resources/Seed/seed.sql`
4. Writes `meta.db_initialized_at` in ISO8601 format

Subsequent launches reuse the existing DB file.

## Manual MVP test checklist
1. **Offline Library**
   - Put device/simulator in Airplane Mode.
   - Launch app, open Library, open category, open article detail.
2. **DB reseed**
   - Delete app from simulator/device.
   - Reinstall and relaunch.
   - Confirm categories load and diagnostics show new init timestamp.
3. **Dynamic Type**
   - Increase text size in iOS Accessibility settings.
   - Reopen app and verify no critical truncation in lists/details.
4. **Knot Viewer**
   - With `sampleKnot.usdz`: viewer should render model.
   - Without model: fallback displays `Model unavailable`.
5. **Map Scaffold**
   - Without token/SDK: placeholder message should display.
   - With token + Mapbox SDK integrated: replace scaffold with real map view.

## Testing on iPhone
1. Use macOS with latest Xcode.
2. Connect iPhone by USB (or trusted wireless pairing).
3. Select your iPhone as run target.
4. In Signing & Capabilities, use your Apple ID/team.
5. Build & Run.
6. Enable Airplane Mode and execute the manual checklist above.

## Testing from Windows 11 (emulator path)
Direct native iOS simulation is not supported on Windows alone. Options:
1. **Remote macOS host** (recommended):
   - Use a legal Mac cloud/remote Mac service.
   - Open project in Xcode remotely and run iOS Simulator there.
2. **Local virtualization + macOS** (only if licensing/hardware allows):
   - Install macOS VM on capable hardware.
   - Install Xcode and run iOS Simulator in the VM.

For both options, run same manual checklist and capture logs/screenshots from the macOS side.

## MVP limitations / not implemented
- SQLCipher encryption, key management
- App Attest / DeviceCheck
- RASP / jailbreak detection
- Subscription / receipt validation
- Offline map routing and pack ingestion pipeline
- AR sun/star dial and full media pipeline

## UX image examples
See `docs/UX_EXAMPLES.md` for static mock image examples of Home, Library, Article Detail, Map placeholder, Settings, and reusable components.
