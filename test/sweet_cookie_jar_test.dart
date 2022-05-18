// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:http/http.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// Project imports:
import 'package:sweet_cookie_jar/sweet_cookie_jar.dart';

final _testResponse = Response.bytes(
  [],
  200,
  headers: {
    'set-cookie':
        'AWSALB=CGSOoaFEi91n9xSfeeSxoUvs0A/TTQn9/Mbxe8dtkv50cBqJmHTwPw3; Expires=Tue, 14 Dec 2021 02:20:37 GMT; Path=/,AWSALBCORS=OHhxYMU0mU7WOoh+4RH5bxe8d6AytmnHaZNGUBqJmHTwPw3; Expires=Tue, 14 Dec 2021 02:20:37 GMT; Path=/; SameSite=None; Secure,jwt_token=test; Domain=.test; Max-Age=31536000; Path=/; expires=Wed, 07-Dec-2022 02:20:37 GMT; SameSite=lax; Secure,csrf_token=test==; Domain=.test; Max-Age=31536000; Path=/; expires=Wed, 07-Dec-2022 02:20:37 GMT,csrf_token=test==; Domain=.test; Max-Age=31536000; Path=/; expires=Wed, 07-Dec-2022 02:20:37 GMT,wuuid=77be8f46-4'
  },
);

final _partTestResponse1 = Response.bytes(
  [],
  200,
  headers: {
    'set-cookie':
        'AWSALB=CGSOoaFEi91n9xSfeeSxoUvs0A/TTQn9/Mbxe8dtkv50cBqJmHTwPw3; Expires=Tue, 14 Dec 2021 02:20:37 GMT; Path=/,AWSALBCORS=OHhxYMU0mU7WOoh+4RH5bxe8d6AytmnHaZNGUBqJmHTwPw3; Expires=Tue, 14 Dec 2021 02:20:37 GMT; Path=/; SameSite=None; Secure,jwt_token=test; Domain=.test; Max-Age=31536000; Path=/; expires=Wed, 07-Dec-2022 02:20:37 GMT; SameSite=lax; Secure'
  },
);

final _partTestResponse2 = Response.bytes(
  [],
  200,
  headers: {
    'set-cookie':
        'csrf_token=test==; Domain=.test; Max-Age=31536000; Path=/; expires=Wed, 07-Dec-2022 02:20:37 GMT,csrf_token=test==; Domain=.test; Max-Age=31536000; Path=/; expires=Wed, 07-Dec-2022 02:20:37 GMT,wuuid=77be8f46-4'
  },
);

void main() {
  group('Test constructor.', () {
    test('Test constructor.', () {
      final cookieJar = SweetCookieJar.from(response: _testResponse);
      expect(cookieJar.isEmpty, false);
      expect(cookieJar.isNotEmpty, true);
    });
  });

  group('Test nameSet', () {
    test('Test nameSet', () {
      final cookieJar = SweetCookieJar.from(response: _testResponse);
      expect(cookieJar.nameSet,
          {"AWSALB", "AWSALBCORS", "jwt_token", "csrf_token", "wuuid"});
    });
  });

  group('Test operator +.', () {
    test('Test operator +.', () {
      final cookieJar1 = SweetCookieJar.from(response: _partTestResponse1);
      final cookieJar2 = SweetCookieJar.from(response: _partTestResponse2);
      final cookieJar3 = cookieJar1 + cookieJar2;

      expect(cookieJar3.nameSet,
          {"AWSALB", "AWSALBCORS", "jwt_token", "csrf_token", "wuuid"});
    });
  });

  group('Test find.', () {
    test('Test find AWSALB', () {
      final cookieJar = SweetCookieJar.from(response: _testResponse);
      expect(cookieJar.isEmpty, false);
      expect(cookieJar.isNotEmpty, true);

      final cookie = cookieJar.find(name: 'AWSALB');

      expect(cookie.isEmpty, false);
      expect(cookie.isNotEmpty, true);
      expect(cookie.name, 'AWSALB');
      expect(cookie.value,
          'CGSOoaFEi91n9xSfeeSxoUvs0A/TTQn9/Mbxe8dtkv50cBqJmHTwPw3');
      expect(cookie.secure, false);
    });

    test('Test find jwt_token', () {
      final cookieJar = SweetCookieJar.from(response: _testResponse);
      expect(cookieJar.isEmpty, false);
      expect(cookieJar.isNotEmpty, true);

      final cookie = cookieJar.find(name: 'jwt_token');

      expect(cookie.isEmpty, false);
      expect(cookie.isNotEmpty, true);
      expect(cookie.name, 'jwt_token');
      expect(cookie.value, 'test');
      expect(cookie.secure, true);
    });

    test('Test find cookie does not exist.', () {
      final cookieJar = SweetCookieJar.from(response: _testResponse);
      expect(cookieJar.isEmpty, false);
      expect(cookieJar.isNotEmpty, true);

      final cookie = cookieJar.find(name: 'not_exist');

      expect(cookie.isEmpty, true);
      expect(cookie.isNotEmpty, false);
      expect(cookie.name, '');
      expect(cookie.value, '');
      expect(cookie.secure, false);
    });
  });

  group('Test findAll.', () {
    test('Test findAll csrf_token.', () {
      final cookieJar = SweetCookieJar.from(response: _testResponse);
      expect(cookieJar.isEmpty, false);
      expect(cookieJar.isNotEmpty, true);

      final cookies = cookieJar.findAll(name: 'csrf_token');

      expect(cookies.isNotEmpty, true);
      expect(cookies.length, 2);
      expect(cookies[0].name, 'csrf_token');
      expect(cookies[0].value, 'test==');
      expect(cookies[0].secure, false);
    });

    test('Test findAll does not exist.', () {
      final cookieJar = SweetCookieJar.from(response: _testResponse);
      expect(cookieJar.isEmpty, false);
      expect(cookieJar.isNotEmpty, true);

      final cookies = cookieJar.findAll(name: 'not_exist');

      expect(cookies.isEmpty, true);
    });
  });
}
