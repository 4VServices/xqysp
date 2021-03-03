xquery version '1.0-ml';

import module namespace qe="com.blakeley.xqysp.query-eval" at "/xqysp/lib/query-eval.xqy";
import module namespace test = "http://marklogic.com/test" at "/test/test-helper.xqy";

(: single term :)
let $actual := qe:parse("foo")
let $assertions := (
  test:assert-true($actual instance of cts:word-query),
  test:assert-equal("foo", cts:word-query-text($actual))
)

(: implied AND :)
let $actual := qe:parse("foo bar")
let $assertions := (
  $assertions,
  test:assert-true($actual instance of cts:and-query, "main query should be an and-query"),
  for $subquery in cts:and-query-queries($actual)
  return
    test:assert-true($subquery instance of cts:word-query, "subqueries should be word queries"),
  test:assert-equal("foo", cts:word-query-text(cts:and-query-queries($actual)[1])),
  test:assert-equal("bar", cts:word-query-text(cts:and-query-queries($actual)[2]))
)

(: phrase :)
let $actual := qe:parse('"foo bar"')
let $assertions := (
  $assertions,
  test:assert-true($actual instance of cts:word-query),
  test:assert-equal("foo bar", cts:word-query-text($actual))
)

return $assertions
