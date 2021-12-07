// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:sweet_cookie_jar/src/sweet_cookie_rule.dart';

/// This is an extension of the [Cookie] class.
///
/// It provides useful functions for handling cookies that are not defined
/// in the existing [Cookie] class. For example, to check if a particular cookie has expired,
/// it is possible to call [isExpired] or [isNotExpired].
///
/// Also, you can use the [toJson] method to get a json map of this cookie.
extension SweetCookie on Cookie {
  /// Returns this cookie as JSON format.
  ///
  /// The returned JSON will have the following keys and values.
  /// 1. name -> [name]
  /// 2. value -> [value]
  /// 3. expires -> [expires]
  /// 4. maxAge -> [maxAge]
  /// 5. domain -> [domain]
  /// 6. path -> [path]
  /// 7. secure -> [secure]
  /// 8. httpOnly -> [httpOnly]
  Map<String, dynamic> toJson() => {
        'name': name,
        'value': value,
        'expires': expires,
        'maxAge': maxAge,
        'domain': domain,
        'path': path,
        'secure': secure,
        'httpOnly': httpOnly,
      };

  /// Returns true if this cookie is expired, otherwise false.
  bool get isExpired => expires != null && expires!.isBefore(DateTime.now());

  /// Returns true if this cookie is not expired, otherwise false.
  bool get isNotExpired => !isExpired;

  /// Returns true if this cookie is empty, otherwise false.
  bool get isEmpty =>
      name == SweetCookieRule.emptyName && value == SweetCookieRule.emptyValue;

  /// Returns true if this cookie is not empty, otherwise false.
  bool get isNotEmpty => !isEmpty;
}
