# JIRA Ticket Template

## Title
Connect SDK Missing JavaScriptInterface for Hybrid Mobile Applications

## Type
Bug / Feature Gap

## Priority
High

## Component
Android SDK - Connect Module

## Affects Version/s
- Connect SDK 10.4.67-beta
- Connect SDK 10.4.29 (stable)

## Description

### Problem Statement
The Connect SDK lacks JavaScriptInterface support required for hybrid mobile applications (Capacitor, Cordova, React Native). This prevents the SDK from being used in WebView-based mobile apps.

### Expected Behavior
Connect SDK should provide:
- `com.tl.uic.javascript.JavaScriptInterface` class for native-to-web bridge communication
- WebView client support (TLFWebViewClient)
- JavaScript bridge data models (JSBridgeData)

### Actual Behavior
Connect SDK only supports native Jetpack Compose UI applications and contains:
- Compose UI components only
- Native gesture tracking
- No hybrid/WebView/JavaScript support

### Impact
**Critical** - Customers using hybrid mobile frameworks cannot use Connect SDK and must use Tealeaf SDK instead.

**Affected Platforms:**
- Capacitor
- Cordova
- Ionic
- React Native (with WebView)
- Any hybrid framework using Android WebView

### Evidence

#### Verification Tools Available

I have created automated verification scripts that prove this issue:
- **Repository:** https://github.com/AaronGregoryAcoustic/Acoustic_Connect_Android_SDK_Verification
- **Scripts:** `compare-sdks.sh` and `analyze-connect-beta.sh`
- **Usage:** Download and run to independently verify the missing JavaScriptInterface

These scripts:

#### Test Results

**Tealeaf SDK 10.4.19-beta:**
```
✅ FOUND JavaScriptInterface class:
   - com.tl.uic.javascript.JavaScriptInterface
   - com.tl.uic.javascript.JavaScriptInterface$1

✅ Hybrid/Bridge classes:
   - com.tl.uic.util.TLFWebViewClient
   - com.tl.uic.model.JSBridgeData
```

**Connect SDK 10.4.67-beta:**
```
❌ NO JavaScriptInterface class found
❌ No hybrid/bridge classes found
❌ All searches for 'javascript', 'bridge', 'webview', 'hybrid' returned zero matches

Total classes analyzed: 134
All classes are Compose UI related
```

### Steps to Reproduce

1. Download verification tool from [GitHub repo link]
2. Run: `./compare-sdks.sh`
3. Observe: Tealeaf SDK has JavaScriptInterface, Connect SDK does not
4. Run: `./analyze-connect-beta.sh`
5. Observe: All 134 Connect classes are Compose-only, no hybrid support

### Technical Details

**Missing Classes in Connect SDK:**
- `com.tl.uic.javascript.JavaScriptInterface` - Critical for WebView bridge
- `com.tl.uic.util.TLFWebViewClient` - WebView integration
- `com.tl.uic.model.JSBridgeData` - Bridge data models

**What Connect SDK Provides:**
- `com.acoustic.connect.android.connectmod.composeui.*` - Jetpack Compose only
- `com.acoustic.connect.android.connectmod.util.GestureUtil` - Native gestures only
- No WebView or JavaScript integration

### Workaround
Use Tealeaf SDK instead of Connect SDK for hybrid mobile applications.

### Suggested Resolution

**Option 1:** Add JavaScriptInterface to Connect SDK
- Migrate hybrid support from Tealeaf SDK to Connect SDK
- Add `com.tl.uic.javascript.JavaScriptInterface` class
- Include WebView client and bridge components

**Option 2:** Document Limitation
- Clearly document that Connect SDK is for native Compose apps only
- Update documentation to direct hybrid app developers to Tealeaf SDK
- Add compatibility matrix showing Connect = Native, Tealeaf = Hybrid

**Option 3:** Create Separate Hybrid Module
- Create `connect-hybrid` artifact with WebView support
- Keep `connect` for Compose UI only
- Allow developers to use both if needed

### Attachments
- [X] Verification scripts (compare-sdks.sh, analyze-connect-beta.sh)
- [X] Sample output showing missing classes
- [X] README with reproduction steps
- [ ] Customer impact documentation

### Labels
- android
- hybrid-mobile
- webview
- javascript-interface
- sdk-limitation
- capacitor
- cordova

### Links
- **Blocks:** [Links to customer issues requiring hybrid support]
- **Documentation:** [Android SDK documentation]
- **GitHub Issues:** [Related issues]

---

## Additional Context

### Customer Impact
Multiple customers using hybrid frameworks are unable to use Connect SDK:
- Cannot migrate from Tealeaf to Connect
- Stuck on older Tealeaf versions
- Unable to use newer Connect features

### Related Issues
- [List any related JIRA tickets]
- [Customer support cases]

### Testing
The verification tool provides:
- Automated SDK analysis
- No Android Studio required
- Reproducible results
- Clear evidence of missing components

---

**Reporter:** [Your Name]  
**Date:** November 11, 2025  
**Verified On:** macOS, Linux (bash)
