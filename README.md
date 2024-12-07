[![pub package](https://img.shields.io/pub/v/sweet_cookie_jar.svg)](https://pub.dev/packages/sweet_cookie_jar)

<!-- TOC -->

- [1. About](#1-about)
  - [1.1. Introduction](#11-introduction)
    - [1.1.1. Install Library](#111-install-library)
    - [1.1.2. Import It](#112-import-it)
    - [1.1.3. Use SweetCookieJar](#113-use-sweetcookiejar)

<!-- /TOC -->

# 1. About

**_Usable cookie management library in Dart_**

`SweetCookieJar` is an open-sourced Dart library.</br>
With `SweetCookieJar`, you can easily manage cookie on your application.

`SweetCookieJar` is a library that extends the functionality of the official [Cookie](https://api.flutter.dev/flutter/dart-io/Cookie-class.html) class. It also works with [Responses](https://pub.dev/documentation/http/latest/http/Response-class.html) in the [http](https://pub.dev/packages/http) package, and even if multiple `set-cookie` are set in the response header, which is a weak point in the [http](https://pub.dev/packages/http) package, `SweetCookieJar` can manage these cookie information very easily!

No more difficult implementation is needed to handle multiple `set-cookie` set in response header in Dart. Just pass the [Response](https://pub.dev/documentation/http/latest/http/Response-class.html) to the constructor of `SweetCookieJar`!

## 1.1. Introduction

### 1.1.1. Install Library

**_With Dart:_**

```terminal
 dart pub add sweet_cookie_jar
```

**_With Flutter:_**

```terminal
 flutter pub add sweet_cookie_jar
```

### 1.1.2. Import It

```dart
import 'package:sweet_cookie_jar/sweet_cookie_jar.dart';
```

### 1.1.3. Use SweetCookieJar

```dart
import 'package:sweet_cookie_jar/sweet_cookie_jar.dart';

void main() {
    // The cookie set in the response header
    // will be extracted by the constructor process.
    final cookieJar = SweetCookieJar.from(response: response);

    if (cookieJar.isEmpty) {
        // It means that there is no cookie information
        // in the response header.
        return;
    }

    // You can find cookie by name easily.
    final cookie = cookieJar.find(name: 'AWSALB');
    print(cookie.name);
    print(cookie.value);

    // Also you can get cookie as JSON format.
    print(cookie.toJson());

    if (cookie.isExpired) {
        // Do something when cookie is expired.
        return;
    }
}
```
