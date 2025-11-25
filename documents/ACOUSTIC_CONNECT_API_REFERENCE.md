# Acoustic Connect Flutter Plugin - API Reference

This document provides a comprehensive reference for all available methods in the `connect_flutter_plugin` package (version 2.36.5-beta).

## Table of Contents

- [Main Class: PluginConnect](#main-class-pluginconnect)
- [Screen Tracking](#screen-tracking)
- [Custom Events](#custom-events)
- [Exception Logging](#exception-logging)
- [Network Logging](#network-logging)
- [Configuration](#configuration)
- [Session Information](#session-information)
- [Navigation Observer](#navigation-observer)

---

## Main Class: PluginConnect

All methods are accessed through the `PluginConnect` static class.

```dart
import 'package:connect_flutter_plugin/connect_flutter_plugin.dart';
```

---

## Screen Tracking

### logScreenLayout()

**Purpose**: Manually log a screen view with the widget tree and layout information.

**Signature**:
```dart
static Future<void> logScreenLayout(String logicalPageName) async
```

**Parameters**:
- `logicalPageName` (String): The name of the screen/page to log

**Example**:
```dart
PluginConnect.logScreenLayout('home');
PluginConnect.logScreenLayout('booking-detail-123');
```

**What it does**:
1. Captures the current widget tree
2. Takes a screenshot of the screen
3. Logs UI element positions, text, fonts, and properties
4. Sends a LOAD event with the screen name
5. Makes the session replayable in the dashboard

**When to use**:
- In route builders when screens are created
- When you need explicit control over screen view tracking
- To ensure screens show up in session replays

---

### logScreenViewContextUnLoad()

**Purpose**: Log when a screen is being unloaded/left.

**Signature**:
```dart
static Future<void> logScreenViewContextUnLoad(
  String name,
  String referrer
) async
```

**Parameters**:
- `name` (String): The name of the screen being unloaded
- `referrer` (String): The screen the user is navigating from

**Example**:
```dart
PluginConnect.logScreenViewContextUnLoad('booking-detail', 'home');
```

---

### onScreenview()

**Purpose**: Low-level method to log screen view events (called internally by `logScreenLayout`).

**Signature**:
```dart
static Future<void> onScreenview(
  String tlType,
  String logicalPageName,
  dynamic layoutParameters
) async
```

**Parameters**:
- `tlType` (String): Event type - "LOAD" or "UNLOAD"
- `logicalPageName` (String): The screen name
- `layoutParameters`: Layout data captured from the widget tree

---

## Custom Events

### tlApplicationCustomEvent()

**Purpose**: Log custom application events for tracking specific user actions or business logic.

**Signature**:
```dart
static Future<void> tlApplicationCustomEvent({
  required String eventName,
  Map<String, dynamic>? data
}) async
```

**Parameters**:
- `eventName` (String, required): The name of the custom event
- `data` (Map<String, dynamic>?, optional): Additional data to include with the event

**Example**:
```dart
await PluginConnect.tlApplicationCustomEvent(
  eventName: 'booking_completed',
  data: {
    'destination': 'Alaska',
    'price': 1500.00,
    'travelers': 2
  }
);
```

---

## Exception Logging

### tlApplicationCaughtException()

**Purpose**: Log application-level handled exceptions.

**Signature**:
```dart
static Future<void> tlApplicationCaughtException({
  required String name,
  required String description,
  String? stackTrace,
  Map<String, dynamic>? data
}) async
```

**Parameters**:
- `name` (String, required): Exception name/type
- `description` (String, required): Exception description/message
- `stackTrace` (String?, optional): Stack trace as string
- `data` (Map<String, dynamic>?, optional): Additional context data

**Example**:
```dart
try {
  // some code that might throw
} catch (e, stackTrace) {
  await PluginConnect.tlApplicationCaughtException(
    name: e.runtimeType.toString(),
    description: e.toString(),
    stackTrace: stackTrace.toString(),
    data: {'userId': currentUser.id}
  );
}
```

---

### onTlException()

**Purpose**: Log global unhandled exceptions.

**Signature**:
```dart
static Future<void> onTlException({
  required dynamic exception,
  StackTrace? stackTrace
}) async
```

**Parameters**:
- `exception` (dynamic, required): The exception object
- `stackTrace` (StackTrace?, optional): Stack trace

**Example**:
```dart
FlutterError.onError = (FlutterErrorDetails details) {
  PluginConnect.onTlException(
    exception: details.exception,
    stackTrace: details.stack
  );
};
```

---

## Network Logging

### tlConnection()

**Purpose**: Log network requests and responses for monitoring API calls.

**Signature**:
```dart
static Future<void> tlConnection({
  required String url,
  required String method,
  int? statusCode,
  int? responseTime,
  int? loadTime,
  Map<String, String>? requestHeaders,
  Map<String, String>? responseHeaders,
  String? requestBody,
  String? responseBody
}) async
```

**Parameters**:
- `url` (String, required): The request URL
- `method` (String, required): HTTP method (GET, POST, etc.)
- `statusCode` (int?, optional): HTTP status code
- `responseTime` (int?, optional): Time taken for response in milliseconds
- `loadTime` (int?, optional): Time when response was received
- `requestHeaders` (Map<String, String>?, optional): Request headers
- `responseHeaders` (Map<String, String>?, optional): Response headers
- `requestBody` (String?, optional): Request body content
- `responseBody` (String?, optional): Response body content

**Example**:
```dart
await PluginConnect.tlConnection(
  url: 'https://api.example.com/bookings',
  method: 'POST',
  statusCode: 201,
  responseTime: 450,
  requestHeaders: {'Content-Type': 'application/json'},
  responseHeaders: {'Content-Type': 'application/json'},
  requestBody: '{"destination": "Alaska"}',
  responseBody: '{"id": 123, "status": "confirmed"}'
);
```

---

## Configuration

### setBooleanConfigItemForKey()

**Purpose**: Set a boolean configuration value at runtime.

**Signature**:
```dart
static Future<bool> setBooleanConfigItemForKey(
  String key,
  bool value,
  String moduleName
) async
```

**Parameters**:
- `key` (String): Configuration key
- `value` (bool): Boolean value to set
- `moduleName` (String): Module name (e.g., "Tealeaf")

**Example**:
```dart
await PluginConnect.setBooleanConfigItemForKey(
  'CaptureScreenshots',
  true,
  'Tealeaf'
);
```

---

### setStringItemForKey()

**Purpose**: Set a string configuration value at runtime.

**Signature**:
```dart
static Future<dynamic> setStringItemForKey(
  String key,
  String value,
  String moduleName
) async
```

**Parameters**:
- `key` (String): Configuration key
- `value` (String): String value to set
- `moduleName` (String): Module name

**Example**:
```dart
await PluginConnect.setStringItemForKey(
  'LogicalPageName',
  'checkout',
  'Tealeaf'
);
```

---

### setNumberItemForKey()

**Purpose**: Set a numeric configuration value at runtime.

**Signature**:
```dart
static Future<dynamic> setNumberItemForKey(
  String key,
  num value,
  String moduleName
) async
```

**Parameters**:
- `key` (String): Configuration key
- `value` (num): Numeric value to set
- `moduleName` (String): Module name

---

### tlSetEnvironment()

**Purpose**: Set environment-specific configuration.

**Signature**:
```dart
static Future<void> tlSetEnvironment({
  Map<String, dynamic>? config
}) async
```

---

## Session Information

### connectSessionId

**Purpose**: Get the current session ID.

**Signature**:
```dart
static Future<String> get connectSessionId async
```

**Example**:
```dart
String sessionId = await PluginConnect.connectSessionId;
print('Current session: $sessionId');
```

---

### appKey

**Purpose**: Get the configured app key.

**Signature**:
```dart
static Future<String> get appKey async
```

**Example**:
```dart
String key = await PluginConnect.appKey;
```

---

### connectVersion

**Purpose**: Get the Connect SDK version.

**Signature**:
```dart
static Future<String> get connectVersion async
```

---

### pluginVersion

**Purpose**: Get the Flutter plugin version.

**Signature**:
```dart
static Future<String> get pluginVersion async
```

---

### platformVersion

**Purpose**: Get the platform-specific version information.

**Signature**:
```dart
static Future<String> get platformVersion async
```

---

## Performance Logging

### logPerformanceEvent()

**Purpose**: Log performance metrics for screen loads and interactions.

**Signature**:
```dart
static Future<bool> logPerformanceEvent({
  int? navigationStart,
  int? unloadEventStart,
  int? unloadEventEnd,
  int? redirectStart,
  int? redirectEnd,
  int? fetchStart,
  int? loadEventStart,
  int? loadEventEnd,
  int? navigationType,
  int? redirectCount
}) async
```

**Example**:
```dart
await PluginConnect.logPerformanceEvent(
  navigationStart: 0,
  loadEventStart: 100,
  loadEventEnd: 550,
  navigationType: 0
);
```

---

## Gesture & Pointer Events

### onTlGestureEvent()

**Purpose**: Log gesture events (taps, swipes, etc.). Usually handled automatically.

**Signature**:
```dart
static Future<void> onTlGestureEvent({
  required String tlType,
  Map<String, dynamic>? layoutParameters
}) async
```

---

### onTlPointerEvent()

**Purpose**: Log pointer events (touch down, move, up). Usually handled automatically.

**Signature**:
```dart
static Future<void> onTlPointerEvent({
  required Map fields
}) async
```

---

## Signal Logging

### logSignal()

**Purpose**: Log custom signals or events.

**Signature**:
```dart
static Future<void> logSignal({
  required String signalName,
  Map<String, dynamic>? data
}) async
```

---

## Navigation Observer

### loggingNavigatorObserver

**Purpose**: A pre-configured `NavigatorObserver` that automatically tracks navigation events.

**Type**: `LoggingNavigatorObserver`

**Usage**:
```dart
GoRouter router = GoRouter(
  observers: [PluginConnect.loggingNavigatorObserver],
  // ... routes
);
```

**Or with MaterialApp**:
```dart
MaterialApp(
  navigatorObservers: [PluginConnect.loggingNavigatorObserver],
  // ... other properties
);
```

---

## Best Practices

### Screen Tracking
- **Always** call `PluginConnect.logScreenLayout()` when a new screen is displayed
- Use consistent, meaningful screen names (e.g., 'home', 'booking-detail', 'search')
- Include context in screen names when useful (e.g., 'booking-detail-123')

### Error Handling
- Wrap Connect calls in try-catch blocks to handle `ConnectException`
- Log caught exceptions with `tlApplicationCaughtException()`
- Set up global error handler with `onTlException()`

### Network Tracking
- Log important API calls to track performance
- Include timing information for performance monitoring
- Be mindful of logging sensitive data in request/response bodies

### Custom Events
- Use custom events for business-critical actions
- Include relevant context data
- Keep event names consistent across the app

---

## Example: Complete Integration

```dart
import 'package:connect_flutter_plugin/connect_flutter_plugin.dart';

// In route builder
GoRoute(
  path: '/home',
  name: 'home',
  builder: (context, state) {
    // Log screen view
    PluginConnect.logScreenLayout('home');
    return HomeScreen();
  },
),

// Custom event on button press
void onBookingComplete() async {
  try {
    await PluginConnect.tlApplicationCustomEvent(
      eventName: 'booking_completed',
      data: {
        'destination': 'Alaska',
        'timestamp': DateTime.now().toIso8601String(),
      }
    );
  } catch (e) {
    print('Error logging custom event: $e');
  }
}

// Network logging
Future<void> fetchBookings() async {
  final startTime = DateTime.now().millisecondsSinceEpoch;
  try {
    final response = await http.get(Uri.parse('/api/bookings'));
    final endTime = DateTime.now().millisecondsSinceEpoch;
    
    await PluginConnect.tlConnection(
      url: '/api/bookings',
      method: 'GET',
      statusCode: response.statusCode,
      responseTime: endTime - startTime,
    );
  } catch (e, stackTrace) {
    await PluginConnect.tlApplicationCaughtException(
      name: 'NetworkError',
      description: 'Failed to fetch bookings: $e',
      stackTrace: stackTrace.toString(),
    );
  }
}

// Get session info
Future<void> printSessionInfo() async {
  final sessionId = await PluginConnect.connectSessionId;
  final version = await PluginConnect.connectVersion;
  print('Session: $sessionId, Version: $version');
}
```

---

## Notes

- **Beta Version**: This API reference is for version 2.36.5-beta
- **Breaking Changes**: Beta versions may have API changes
- **Legacy Names**: Some methods still reference "Tealeaf" (the original product name)
- **Automatic Tracking**: Many events (gestures, pointers) are tracked automatically by the SDK
- **Manual Control**: Use explicit methods like `logScreenLayout()` when automatic tracking isn't sufficient

---

## Support

For more information, refer to:
- [Acoustic Connect Documentation](https://developer.goacoustic.com/)
- [Package on pub.dev](https://pub.dev/packages/connect_flutter_plugin)
- Integration guide: `ACOUSTIC_CONNECT_INTEGRATION.md`
