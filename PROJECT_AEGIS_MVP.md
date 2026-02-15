# Project Aegis — iOS Offline-First Survival MVP

This repository contains an MVP scaffold implementing:
- SwiftUI True Black shell
- Offline SQLite-backed survival library
- RealityKit knot viewer screen with graceful fallback
- Map integration scaffold with token/dependency guards
- Settings + diagnostics

## Notes
- Workday issue captured: external recipients added do not get sent invites out of the calendar when event is created.
- Teams invite generation is not automatic when the event is created.

## Phase 2 TODO boundaries
- SQLCipher migration strategy
- Receipt validation boundaries
- RASP/jailbreak heuristics
- Offline map region packs in `/SecureStorage/Regions/`
