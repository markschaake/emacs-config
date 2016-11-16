(defun ensime-goto-test--test-template-schaake-spec ()
  ""
  "package %TESTPACKAGE%

import schaake.core.Spec

class %TESTCLASS% extends Spec {

  \"%IMPLCLASS%\" should \"work\" in new TestScope {
    pending
  }

  trait TestScope {

  }
}")
