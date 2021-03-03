xquery version '1.0-ml';

import module namespace qe="com.blakeley.xqysp.query-eval" at "/xqysp/lib/query-eval.xqy";
import module namespace test = "http://marklogic.com/test" at "/test/test-helper.xqy";

(
  test:assert-not-exists(qe:parse("")),
  test:assert-not-exists(qe:parse(" ")),
  test:assert-not-exists(qe:parse("  "))
)
