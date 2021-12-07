// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart';
import 'package:sweet_cookie_jar/sweet_cookie_jar.dart';

class DemoSweetCookieJar {
  void main() {
    final response = Response.bytes(
      [],
      200,
      headers: {
        'set-cookie':
            'AWSALB=CGSOoaFEi91n9xSfeeSxoUvs0A/TTQn9/Mbxe8dtkv50cBqJmHTwPw3; Expires=Tue, 14 Dec 2021 02:20:37 GMT; Path=/,AWSALBCORS=OHhxYMU0mU7WOoh+4RH5bxe8d6AytmnHaZNGUBqJmHTwPw3; Expires=Tue, 14 Dec 2021 02:20:37 GMT; Path=/; SameSite=None; Secure,jwt_token=test; Domain=.test; Max-Age=31536000; Path=/; expires=Wed, 07-Dec-2022 02:20:37 GMT; SameSite=lax; Secure,csrf_token=test==; Domain=.test; Max-Age=31536000; Path=/; expires=Wed, 07-Dec-2022 02:20:37 GMT,csrf_token=test==; Domain=.test; Max-Age=31536000; Path=/; expires=Wed, 07-Dec-2022 02:20:37 GMT,wuuid=77be8f46-4'
      },
    );

    final cookieJar = SweetCookieJar.from(response: response);

    if (cookieJar.isEmpty) {
      // It means that there is no cookie information
      // in the response header.
      return;
    }

    final cookie = cookieJar.find(name: 'AWSALB');
    print(cookie.name);
    print(cookie.value);
    print(cookie.toJson());

    if (cookie.isExpired) {
      // Do something
      return;
    }
  }
}
