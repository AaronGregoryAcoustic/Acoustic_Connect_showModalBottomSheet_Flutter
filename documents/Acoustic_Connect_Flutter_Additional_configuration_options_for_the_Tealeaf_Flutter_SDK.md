# Additional configuration options for the Tealeaf Flutter SDK

After you have integrated the SDK into your app, you may want to configure some additional options.

## HTTP Connection Logging

HTTP connection logging is the process of recording information about requests made to a server. It helps to monitor and analyze user behavior and gain insights into application performance and issues.

The Tealeaf plugin for Flutter supports HTTP connection logging through a custom HTTP client: `TlHttpClient`. The `TlHttpClient` extends Flutter's `http.BaseClient` and exposes the same interface so it can be used to replace `http.BaseClient`.

### Example usage:

```dart
import 'package:tl_flutter_plugin/tl_http_client.dart';

Future<String> fetchData() async {
    var client = TlHttpClient();
    var url = Uri.parse('https://www.google.com/');
    final response = await client.get(url);

    if (response.statusCode == 200) {
        // If server returns an OK response
        return 'Success';
    } else {
        // If that response was not OK
        return 'Failed to load page';
    }
}
```

## Logging custom events

Use the following function to log custom events.

```dart
PluginTealeaf.tlApplicationCustomEvent(
   eventName: 'ButtonClicked',
   customData: {'buttonName': 'Cancel - Sample Custom Event'}
);
```

Here is an example from our sample app.

![Logging the onPressed section of a button](https://files.readme.io/73cc7c7ea26b71dd51780575cfcaa7107d478c359ce8bd61cc705f947c5c6ab7-custom-event-logging.png)

*Logging the onPressed section of a button*

## TextField focus change listener

The `TextField focus change listener` lets you detect when the user's input focus moves in and out of a Text Field component in your application.

The Tealeaf plugin for Flutter supports `TextField focus change listener`. To add the listener, complete the following steps:

### 1. Set the Key to the widget

It allows you to identify and reference the widget using the key.

```dart
final mywidgetkey = GlobalKey();
Container(
    key: mywidgetkey
)
```

Where `myWidgetKey` is a GlobalKey assigned to the key property of the Container widget.

### 2. Declare the focus node

Declare the focus node to implement on TextField. The focus node allows you to listen for focus changes and control the focus behavior of the TextField widget.

```dart
FocusNode myfocus = FocusNode();
```

Where `myFocus` is the `FocusNode` class, which will be used to manage the focus state of the TextField.

### 3. Implement the FocusNode to TextField or TextFormField

```dart
TextField(
    focusNode: myfocus,
)
```

Where: The focusNode property of the TextField widget is set to the previously declared myFocus FocusNode. This setting associates the FocusNode with the TextField, allowing you to listen for focus changes on the TextField using the FocusNode.

### 4. Add the focus listener

Add the focus listener to the `Focusnode`. It allows you to set up a focus listener to react to focus changes on the TextField associated with the FocusNode.

```dart
myfocus.addListener(() {
    TlTextFieldListener.setupFocusListener(mywidgetkey, myfocus.hasFocus);
  }
);
```

Where:
- The `addListener` method is called on the `myFocus` FocusNode.
- A callback function is triggered whenever the focus state of the FocusNode `myFocus` changes.
- `TlTextFieldListener.setupFocusListener` is called with the key of the widget (myWidgetKey) and the current focus state (myFocus.hasFocus).

### Example usage:

```dart
import 'package:tl_flutter_plugin/tl_text_field_listener.dart';

final widgetKey = GlobalKey();
FocusNode widgetFocusNode = FocusNode();

widgetFocusNode.addListener(() {
  TlTextFieldListener.setupFocusListener(widgetKey, widgetFocusNode.hasFocus);
});

Form(
  key: _formKey,
  autovalidateMode: AutovalidateMode.values[_autoValidateModeIndex.value],
  child: Scrollbar(
    child: SingleChildScrollView(
      restorationId: 'text_field_demo_scroll_view',
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          sizedBoxSpace,
          TextFormField(
            key: widgetKey,
            restorationId: 'name_field',
            focusNode: widgetFocusNode,
          ),
          sizedBoxSpace,
        ],
      ),
    ),
  ),
);
```

## Performance logging

Performance logging involves recording and analyzing various performance metrics. The Tealeaf plugin for Flutter facilitates logging the following performance metrics.

| Parameter | Values | Definition |
|-----------|--------|------------|
| `navigationType` | - NAVIGATE = Default 0. Navigation is initiated by a user action like tapping on a button or initializing through a script operation, excluding TYPE_RELOAD and TYPE_BACK_FORWARD.<br>- RELOAD = 1: Navigation through the reload operation.<br>- BACK_FORWARD = 2: Navigation through a history traversal operation.<br>- RESERVED = 255: Any navigation types not defined by the above values. | The type of navigation |
| `redirectCount` | `0` (default) | The number of redirects since the last non-redirect navigation under the current browsing context. If there is no redirect or any redirect is not from the same origin as the destination screen, this attribute must be `0`. |
| `navigationStart` | `0` (default) | Returns the time immediately after the user finishes prompting to unload the previous screen. |
| `unloadEventStart` | `0` (default) | Represents the time immediately before the app starts the unload event of the previous screen, i.e., the pop of the current page. |
| `unloadEventEnd` | `0` (default) | Indicates the time ending from `redirectStart` immediately after the user app finishes the unload event of the previous screen. |
| `redirectStart` | `0` (default) | If there are HTTP redirects or equivalents during navigation and if they all originate at the same place, this attribute returns the starting time of the fetch that initiates the redirect. Otherwise, it returns `0`. |
| `redirectEnd` | `0` (default) | Time ending from `redirectStart`. If there are HTTP redirects or equivalents during navigation and if they all originate at the same place, this attribute returns the time immediately after receiving the last byte of the response of the last redirect, i.e., use push/pop of the current page. Otherwise, it returns zero. |
| `loadEventStart` | `0` (default) | Returns the time immediately before the load event of the current screen is fired. It returns zero when the load event is not fired, i.e., `initState`. |
| `loadEventEnd` | | End time of loading page. Returns the time when the load event of the current document is completed. It returns zero when the load event is not fired or not completed, i.e., `onFocusGained` when the page finished rendering or displayed. |

### Example usage:

```dart
import 'package:tl_flutter_plugin/tl_flutter_plugin.dart';

PluginTealeaf.logPerformanceEvent(
    navigationType: 0,
    redirectCount: 0,
    navigationStart: 0,
    unloadEventStart: 10,
    unloadEventEnd: 20,
    redirectStart: 0,
    redirectEnd: 0,
    loadEventStart: 30,
    loadEventEnd: 40
);
```

---

*Updated about 1 year ago*
