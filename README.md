# Standard SearchBar

Upgraded version from [Standart SearchBar](https://github.com/ManelRosPuig/StandardSearchBar)

A simple and very customizable search bar widget for Flutter.

<table>
  <tr>
    <th>Preview</th>
    <th>Code</th>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/ManelRosPuig/StandardSearchBar/main/images/Standard%20SearchBar%202.0.gif"></td>
    <td><img src="https://raw.githubusercontent.com/ManelRosPuig/StandardSearchBar/main/images/Standard%20SearchBar%202.0%20Code.png"></td>
  </tr>
</table>

## Features

- Implement a search bar with ease.
- Customize the search bar's appearance:
  - Change the search icon.
  - Adjust size and color.
  - Personalize placeholder text.

## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  standard_searchbar: ^2.1.3
```

or installing using your cmd or terminal:

```bash
flutter pub add standart_searchbar_v2
```

Then, run flutter pub get to install the package.

## Usage

Import the package:

```dart
import 'package:standard_searchbar/new/standard_searchbar.dart';
```

or

```dart
import 'package:standard_searchbar/old/standard_searchbar.dart';
```

Create a `StandardSearchBar` widget:

```dart
StandardSearchBar(
  onChanged: (value) {
    // Handle search input change
  },
  onSubmitted: (value) {
    // Handle search submission
  },
),
```

## Examples

```dart
StandardSearchBar(
  width: 360,
  suggestions: [
    'apple',
    'banana',
    'melon',
    'orange',
    'pineapple',
    'strawberry',
    'watermelon'
  ],
),
```

## Contributing

Contributions are welcome! Please fork the repository and open a pull request with your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
