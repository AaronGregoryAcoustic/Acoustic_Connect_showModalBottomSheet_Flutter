# QA Testing Log - Screen Name Null Issue

**Date Started**: November 6, 2025  
**Support Ticket**: CA-116369  
**Issue**: Confirming that screen names don't show up as null in Acoustic replay  
**Plugin Version**: connect_flutter_plugin 2.36.5-beta (updated from 2.36.3-beta)

---

## Summary

Testing the BancoEstado Flutter app to verify that screen names are properly captured in Acoustic Connect session replay and are not appearing as null.

---

## Changes Made

### 1. Flutter Plugin Update
- **File**: `pubspec.yaml`
- **Change**: Updated `connect_flutter_plugin` from `2.36.3-beta` to `2.36.5-beta`
- **Reason**: Engineering updated the Connect plugin; testing with latest version
- **Status**: ✅ Updated

---

## Testing Checklist

### Pre-Build Verification
- [x] Dependencies updated (`flutter pub get`) - ✅ Completed Nov 6, 2025
- [x] iOS pods installed (`cd ios && pod install`) - ✅ Completed Nov 6, 2025
- [x] No compilation errors - ✅ Confirmed

### Build Tests

#### Android
- [x] Debug build successful (`flutter build apk --debug`) - ✅ PASSED
- [x] Release build successful (`flutter build apk --release`) - ❌ FAILED
  - **Error**: Android resource linking failed with `values-v34` system colors
  - **Status**: Known issue with plugin (persists in v2.36.5-beta)
  - **Workaround**: Use debug builds only
- [ ] App installs on device/emulator
- [ ] App launches without crashes

#### iOS
- [x] Build successful (`flutter build ios --debug`) - ✅ PASSED
- [ ] App runs on simulator
- [ ] App launches without crashes

### Screen Name Capture Tests

#### Test Scenario 1: Welcome Screen
- [ ] App launches and shows Welcome screen
- [ ] Screen name appears in Acoustic replay
- [ ] Screen name is NOT null
- [ ] Screen name value: _______________

#### Test Scenario 2: Login Bottom Sheet
- [ ] Tap "Iniciar Sesión" button
- [ ] Login bottom sheet appears
- [ ] Screen name appears in Acoustic replay
- [ ] Screen name is NOT null
- [ ] Expected: `LoginBottomSheet`
- [ ] Actual screen name: _______________

#### Test Scenario 3: Home Screen
- [ ] Enter password and tap Login
- [ ] Home screen appears
- [ ] Screen name appears in Acoustic replay
- [ ] Screen name is NOT null
- [ ] Expected: `HomeScreen`
- [ ] Actual screen name: _______________

#### Test Scenario 4: Shortcut Buttons
Test each shortcut button bottom sheet:

**Autorizar Button**:
- [ ] Tap "Autorizar" shortcut
- [ ] Bottom sheet appears
- [ ] Screen name appears in Acoustic replay
- [ ] Screen name is NOT null
- [ ] Expected: Contains "Autorizar"
- [ ] Actual screen name: _______________

**Realizar Button**:
- [ ] Tap "Realizar" shortcut
- [ ] Bottom sheet appears
- [ ] Screen name appears in Acoustic replay
- [ ] Screen name is NOT null
- [ ] Expected: Contains "Realizar"
- [ ] Actual screen name: _______________

**Consultar Button**:
- [ ] Tap "Consultar" shortcut
- [ ] Bottom sheet appears
- [ ] Screen name appears in Acoustic replay
- [ ] Screen name is NOT null
- [ ] Expected: Contains "Consultar"
- [ ] Actual screen name: _______________

#### Test Scenario 5: Bottom Navigation Bar
Test each navigation tab:

**Inicio Tab**:
- [ ] Tap "Inicio" tab
- [ ] Bottom sheet appears
- [ ] Screen name appears in Acoustic replay
- [ ] Screen name is NOT null
- [ ] Expected: Contains "Inicio"
- [ ] Actual screen name: _______________

**Productos Tab**:
- [ ] Tap "Productos" tab
- [ ] Bottom sheet appears
- [ ] Screen name appears in Acoustic replay
- [ ] Screen name is NOT null
- [ ] Expected: Contains "Productos"
- [ ] Actual screen name: _______________

**Transferir Tab**:
- [ ] Tap "Transferir" tab
- [ ] Bottom sheet appears
- [ ] Screen name appears in Acoustic replay
- [ ] Screen name is NOT null
- [ ] Expected: Contains "Transferir"
- [ ] Actual screen name: _______________

**Más Tab**:
- [ ] Tap "Más" tab
- [ ] Bottom sheet appears
- [ ] Screen name appears in Acoustic replay
- [ ] Screen name is NOT null
- [ ] Expected: Contains "Más"
- [ ] Actual screen name: _______________

### Additional Verification
- [ ] All tap events captured
- [ ] Control IDs are unique (not all showing `/RW/V/RV/MQ/Connect`)
- [ ] No crashes during session
- [ ] Session replay is complete and viewable

---

## Test Results

### Platform: Android
**Device**: _______________ (e.g., Pixel 5 API 34)  
**Date**: _______________

| Screen/Widget | Screen Name Captured | Is Null? | Notes |
|--------------|---------------------|----------|-------|
| Welcome Screen | | | |
| Login Bottom Sheet | | | |
| Home Screen | | | |
| Autorizar Button | | | |
| Realizar Button | | | |
| Consultar Button | | | |
| Inicio Tab | | | |
| Productos Tab | | | |
| Transferir Tab | | | |
| Más Tab | | | |

**Overall Result**: ⬜ PASS / ⬜ FAIL  
**Comments**: 

---

### Platform: iOS
**Device**: _______________ (e.g., iPhone 15 Simulator)  
**Date**: _______________

| Screen/Widget | Screen Name Captured | Is Null? | Notes |
|--------------|---------------------|----------|-------|
| Welcome Screen | | | |
| Login Bottom Sheet | | | |
| Home Screen | | | |
| Autorizar Button | | | |
| Realizar Button | | | |
| Consultar Button | | | |
| Inicio Tab | | | |
| Productos Tab | | | |
| Transferir Tab | | | |
| Más Tab | | | |

**Overall Result**: ⬜ PASS / ⬜ FAIL  
**Comments**: 

---

## Known Issues from Previous Testing

### Issue 1: Screen Names Appearing as Null
**Previous Status**: Bottom sheet screen names appeared as null despite explicit `logScreenLayout()` calls
- iOS: Partial success (login worked, HomeScreen was null)
- Android: All bottom sheets showed as null

**Current Status with v2.36.5-beta**: _To be tested_

### Issue 2: Control ID Differentiation
**Previous Status**: All tap events reported identical control ID: `/RW/V/RV/MQ/Connect`
**Current Status with v2.36.5-beta**: _To be tested_

### Issue 3: Android Release Build
**Previous Status**: Release builds failed with resource errors
**Current Status with v2.36.5-beta**: _To be tested_

---

## Acoustic Session Replay Review

### Session Information
- **Session ID**: _______________
- **Date/Time**: _______________
- **Platform**: _______________
- **Replay URL**: _______________

### Replay Verification
- [ ] Replay is viewable
- [ ] All screens visible
- [ ] Screen transitions captured
- [ ] Screen names are labeled correctly
- [ ] No null values for screen names

---

## Issues Found During Testing

### Issue #1
**Description**: 
**Severity**: ⬜ Critical / ⬜ High / ⬜ Medium / ⬜ Low  
**Platform**: ⬜ Android / ⬜ iOS / ⬜ Both  
**Steps to Reproduce**:
1. 
2. 
3. 

**Expected**: 
**Actual**: 

---

### Issue #2
**Description**: 
**Severity**: ⬜ Critical / ⬜ High / ⬜ Medium / ⬜ Low  
**Platform**: ⬜ Android / ⬜ iOS / ⬜ Both  
**Steps to Reproduce**:
1. 
2. 
3. 

**Expected**: 
**Actual**: 

---

## Final Test Summary

### Test Execution
- **Start Date**: _______________
- **End Date**: _______________
- **Tester**: _______________
- **Total Tests Run**: _______________
- **Tests Passed**: _______________
- **Tests Failed**: _______________

### Overall Result
⬜ **PASS** - Screen names are captured correctly and are not null  
⬜ **FAIL** - Screen names are still appearing as null  
⬜ **PARTIAL** - Some screens work, others still show null

### Recommendation
⬜ **Approve for Production** - All screen names captured correctly  
⬜ **Return to Development** - Issues still present  
⬜ **Further Investigation Needed** - Inconsistent results

### Additional Notes


---

**QA Sign-off**: _______________ Date: _______________
