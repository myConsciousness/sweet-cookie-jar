// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:http/http.dart';
import 'package:sweet_cookie_jar/src/sweet_cookie_jar_impl.dart';

/// This class represents a jar that manages cookies.
///
/// For the constructor of this class, specify the [Response] returned when
/// HTTP communication is performed. When the constructor is executed,
/// the cookie information is safely extracted from the header information of [Response]
/// passed to the constructor.
///
/// After the constructor process is completed and an instance of this [SweetCookieJar] is created,
/// use the [isEmpty] or [isNotEmpty] method to check whether the extracted cookie information
/// exists or not.
///
/// This class provides useful functions for managing cookies. For example, you can use
/// the [find] method or [findAll] method to fetch the cookies you want.
///
/// The [find] method finds for and returns the cookie linked to the name specified in the argument
/// The [findAll] method finds for and returns the all cookies linked to the name
/// specified in the argument.
///
/// **_Example:_***
///
/// ```dart
/// import 'package:http/http.dart';
/// import 'package:sweet_cookie_jar/sweet_cookie_jar.dart';
///
/// void main() {
///   final cookieJar = SweetCookieJar.from(response: response);
///
///   if (cookieJar.isEmpty) {
///     // It means that there is no cookie information
///     // in the response header.
///     return;
///   }
///
///   final cookie = cookieJar.find(name: 'AWSALB');
///   print(cookie.name);
///   print(cookie.value);
///   print(cookie.toJson());
///
///   if (cookie.isExpired) {
///     // Do something
///     return;
///   }
/// }
/// ```
abstract class SweetCookieJar {
  /// Returns the new instance of [SweetCookieJar] based on an argument.
  factory SweetCookieJar.from({required Response response}) =>
      SweetCookieJarImpl.from(response: response);

  /// Returns raw set cookie data.
  String get rawData;

  /// Returns the set of cookie names.
  Set<String> get nameSet;

  /// Returns true if this cookie jar is empty, otherwise false.
  bool get isEmpty;

  /// Returns true if this cookie jar is not empty, otherwise false.
  bool get isNotEmpty;

  /// Returns the cookie linked to [name], otherwise empty cookie.
  Cookie find({required String name});

  /// Returns the cookie value linked to [name], otherwise empty string.
  String findValue({required String name});

  /// Returns all cookies linked to [name], otherwise empty list.
  List<Cookie> findAll({required String name});

  /// Returns all cookie values linked to [name], otherwise empty list.
  List<String> findAllValues({required String name});

  /// Returns true if this cookie jar contains cookie linked to [name], otherwise false.
  bool containsName({required String name});
}
