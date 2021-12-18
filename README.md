![sweet_cookie_jar](https://user-images.githubusercontent.com/13072231/145067729-a8ac198a-e157-484a-8834-c74ca3470616.png)

**_A most easily usable cookie management library in Dart!_**

[![pub package](https://img.shields.io/pub/v/sweet_cookie_jar.svg)](https://pub.dev/packages/sweet_cookie_jar)
[![codecov](https://codecov.io/gh/myConsciousness/sweet-cookie-jar/branch/main/graph/badge.svg?token=2JMUAZOIGB)](https://codecov.io/gh/myConsciousness/sweet-cookie-jar)
[![Analyzer](https://github.com/myConsciousness/sweet-cookie-jar/actions/workflows/analyzer.yml/badge.svg)](https://github.com/myConsciousness/sweet-cookie-jar/actions/workflows/analyzer.yml)
[![Test](https://github.com/myConsciousness/sweet-cookie-jar/actions/workflows/test.yml/badge.svg)](https://github.com/myConsciousness/sweet-cookie-jar/actions/workflows/test.yml)

<!-- TOC -->

- [1. About](#1-about)
  - [1.1. Introduction](#11-introduction)
    - [1.1.1. Install Library](#111-install-library)
    - [1.1.2. Import It](#112-import-it)
    - [1.1.3. Use SweetCookieJar](#113-use-sweetcookiejar)
  - [1.2. License](#12-license)
  - [1.3. More Information](#13-more-information)

<!-- /TOC -->

# 1. About

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

## 1.2. License

```license
Copyright (c) 2021, Kato Shinya. All rights reserved.
Use of this source code is governed by a
BSD-style license that can be found in the LICENSE file.
```

## 1.3. More Information

`SweetCookieJar` was designed and implemented by **_Kato Shinya_**.

- [Creator Profile](https://github.com/myConsciousness)
- [License](https://github.com/myConsciousness/sweet-cookie-jar/blob/main/LICENSE)
- [API Document](https://pub.dev/documentation/sweet_cookie_jar/latest/sweet_cookie_jar/sweet_cookie_jar-library.html)
- [Release Note](https://github.com/myConsciousness/sweet-cookie-jar/releases)
- [Bug Report](https://github.com/myConsciousness/sweet-cookie-jar/issues)
