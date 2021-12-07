// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:http/http.dart';
import 'package:sweet_cookie_jar/src/sweet_cookie_jar.dart';
import 'package:sweet_cookie_jar/src/sweet_cookie_rule.dart';

/// This is an implementation class of [SweetCookieJar].
class SweetCookieJarImpl implements SweetCookieJar {
  /// Returns the new instance of [SweetCookieJarImpl] based on an argument.
  SweetCookieJarImpl.from({required Response response}) {
    final setCookie = _getSetCookie(response: response);
    if (setCookie.isEmpty) {
      return;
    }

    for (final cookie in setCookie.split(RegExp(',(?=[^ ])'))) {
      _cookies.add(Cookie.fromSetCookieValue(cookie));
    }

    _rawData = setCookie;
  }

  /// The raw set cookie data
  late String _rawData;

  /// The cookies
  final List<Cookie> _cookies = [];

  @override
  String get rawData => _rawData;

  @override
  Set<String> get nameSet {
    final names = <String>{};
    for (final cookie in _cookies) {
      if (names.contains(cookie.name)) {
        names.add(cookie.name);
      }
    }

    return names;
  }

  @override
  bool get isEmpty => _cookies.isEmpty;

  @override
  bool get isNotEmpty => !isEmpty;

  @override
  Cookie find({required String name}) {
    for (final cookie in _cookies) {
      if (cookie.name == name) {
        return cookie;
      }
    }

    return Cookie(
      SweetCookieRule.emptyName,
      SweetCookieRule.emptyValue,
    );
  }

  @override
  String findValue({required String name}) => find(name: name).value;

  @override
  List<Cookie> findAll({required String name}) {
    final foundCookies = <Cookie>[];
    for (final cookie in _cookies) {
      if (cookie.name == name) {
        foundCookies.add(cookie);
      }
    }

    return foundCookies;
  }

  @override
  List<String> findAllValues({required String name}) {
    final foundValues = <String>[];
    for (final cookie in _cookies) {
      if (cookie.name == name) {
        foundValues.add(cookie.value);
      }
    }

    return foundValues;
  }

  @override
  bool containsName({required String name}) {
    for (final cookie in _cookies) {
      if (cookie.name == name) {
        return true;
      }
    }

    return false;
  }

  String _getSetCookie({required Response response}) {
    final headers = response.headers;

    for (final headerEntry in headers.entries) {
      if (headerEntry.key.toLowerCase() == 'set-cookie') {
        return headers[headerEntry.key]!;
      }
    }

    return '';
  }
}
