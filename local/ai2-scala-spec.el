(defun ensime-goto-test--test-template-ai2-spec ()
  ""
  "package %TESTPACKAGE%

import org.allenai.common.testkit.UnitSpec

import org.scalatest.mock.MockitoSugar

import org.mockito.Mockito._
import org.mockito.Matchers._

class %TESTCLASS% extends UnitSpec {

  behavior of \"%TESTCLASS%\"

  it should \"work\" in new TestScope {
    fail
  }

  trait TestScope extends MockitoSugar {

  }
}
")
