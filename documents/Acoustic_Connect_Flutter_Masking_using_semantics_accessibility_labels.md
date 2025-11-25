# Masking using semantics accessibility labels

You can mask or block sensitive customer information from being transmitted and captured. For example, you can mask credit card numbers from being captured. In Flutter apps, you can use the accessibility label tag to mask privacy.

Flutter uses semantic accessibility to make the app understandable and usable for people with disabilities. The semantics widget in Flutter helps achieve accessibility requirements in the app by providing a textual description of the UI elements for screen readers and other assistive technologies. The Semantics widget adds a label tag to the UI element to provide the textual description for the element. For example, if you have a button that says "Submit," you can use Semantics to add a label like "Submit button" to describe what that button does. This way, a screen reader can read that description to someone who can't see the screen, helping them navigate and understand your app better.

## Configure masking in the Tealeaf plugin

You can use the accessibility labels defined in your Flutter apps for masking purposes with the Tealeaf plugin. To configure the masking of data and screenshot images in the Tealeaf plugin for your app, you must create and add the label regex in the TealeafLayoutConfig.json(TealeafConfig.json) file:

1. Create a semantics label in the app.
2. Use the label as masking regex.

Example: Semantics labels created in the gallery sample app:

```dart
class _ShrineLogo extends StatelessWidget {
  const _ShrineLogo();

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Column(
        children: [
          const FadeInImagePlaceholder(
            image: AssetImage('packages/shrine_images/diamond.png'),
            placeholder: SizedBox(
              width: 34,
              height: 34,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            semanticsLabel: 'Hello, world!',
            'SHRINE',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Semantics(
              label: 'Shrine - Tealeaf masking label',
              hint: 'Shrine - Tealeaf test hint',
              child: const Text('Shrine - Tealeaf Accessibility Label'),
            ),
        ],
      ),
    );
  }
}
```

Example: *TealeafLayoutConfig.json* configured to mask screen data using the semantics labels created `username`, and `Shrine - Tealeaf masking label`.

```json
{
  "AutoLayout": {
    "GlobalScreenSettings":{
      "ScreenChange": true,
      "DisplayName": "",
      "CaptureLayoutDelay": 1000,
      "ScreenShot": true,
      "NumberOfWebViews": 0,
      "CaptureUserEvents": true,
      "CaptureScreenVisits": true,
      "CaptureLayoutOn": 2,
      "CaptureScreenshotOn": 2,
      "Masking": {
        "HasMasking": true,
        "HasCustomMask": true,
        "Sensitive": {
          "capitalCaseAlphabet": "X",
          "number": "9",
          "smallCaseAlphabet": "x",
          "symbol": "#"
        },
        "MaskAccessibilityLabelList": [
          "username",
          "Shrine - Tealeaf masking label"
        ]
      }
    },
    "MainActivity": {
      "ScreenChange": false,
      "DisplayName": "Home",
      "CaptureLayoutOn": 2,
      "CaptureScreenshotOn": 2
    }
  },
  "AppendMapIds": {
    "com.any.package:id/givenIdOnXmlLayout1": {
      "mid": "giveAdditionalId1"
    },
    "com.any.package:id/givenIdOnXmlLayout2": {
      "mid": "giveAdditionalId2"
    }
  }
}
```

## Define accessibility labels in Flutter

The following code snippets demonstrate the different ways you can define accessibility labels in Flutter.

### Using Semantics Widget

```dart
Semantics(
  label: 'Submit button',
  child: ElevatedButton(
    onPressed: () {
      // Your button logic here
    },
    child: Text('Submit'),
  ),
)
```

### Accessibility properties

```
Text(
  'Your Text',
  semanticsLabel: 'Custom label for Text widget',
)
```

### Annotations

```
import 'package:flutter/material.dart';

@SemanticsHint('This is a custom hint')
@SemanticsLabel('Custom label for this widget')
class CustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Your widget content
    );
  }
}
```

### Localizations

```
Semantics(
  label: AppLocalizations.of(context).translate('Submit button'),
  child: ElevatedButton(
    onPressed: () {
      // Your button logic here
    },
    child: Text('Submit'),
  ),
)
```

### Custom widgets

```
class CustomAccessibleButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomAccessibleButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
```
