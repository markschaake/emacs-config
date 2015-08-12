(load-file "./ai2-imports.el")

(ert-deftest ai2-fixup-curlies-test ()
  (with-temp-buffer
    (let ((contents "package foo

import foo.bar
import org.allenai.{something, else}
import some.foo.bar.{hi}
import java.what
")
          (expected "package foo

import foo.bar
import org.allenai.{ something, else }
import some.foo.bar.{ hi }
import java.what
"))
      (insert contents)
      (ai2-fixup-curlies)
      (should (string= expected (buffer-string))))))


(ert-deftest ai2-collapse-imports-test ()
  (with-temp-buffer
    (let ((contents "package foo

import foo.bar
import org.allenai.something

import some.foo.bar


import java.what
")
          (expected "package foo

import foo.bar
import org.allenai.something
import some.foo.bar
import java.what
"))
      (insert contents)
      (ai2-collapse-imports)
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-collapse-imports-no-newlines-test ()
  (with-temp-buffer
    (let ((contents "package foo

import foo.bar
import org.allenai.something
import some.foo.bar
import java.what
")
          (expected "package foo

import foo.bar
import org.allenai.something
import some.foo.bar
import java.what
"))
      (insert contents)
      (ai2-collapse-imports)
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-sort-imports-test ()
  (with-temp-buffer
    (let ((contents "package foo

import foo.bar
import org.allenai.something
import some.foo.bar
import org.allenai.something
import java.what
")
          (expected "package foo

import foo.bar
import java.what
import org.allenai.something
import some.foo.bar
"))
      (insert contents)
      (ai2-sort-imports)
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-move-allenai-to-top-test ()
  (with-temp-buffer
    (let ((contents "package foo

import foo.bar
import java.what
import org.allenai.something
import some.foo.bar
")
          (expected "package foo

import org.allenai.something
import foo.bar
import java.what
import some.foo.bar
"))
      (insert contents)
      (ai2-move-allenai-to-top)
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-move-allenai-to-top-already-at-top-test ()
  (with-temp-buffer
    (let ((contents "package foo

import org.allenai.something
import org.allenai.else
import some.foo.bar
")
          (expected "package foo

import org.allenai.something
import org.allenai.else
import some.foo.bar
"))
      (insert contents)
      (ai2-move-allenai-to-top)
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-move-allenai-to-top-no-match-test ()
  (with-temp-buffer
    (let ((contents "package foo

import foo.bar
import java.what
import some.foo.bar
")
          (expected "package foo

import foo.bar
import java.what
import some.foo.bar
"))
      (insert contents)
      (ai2-move-allenai-to-top)
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-move-imports-to-bottom-test ()
  (with-temp-buffer
    (let ((contents "package foo

import org.allenai.something
import foo.bar
import java.what
import some.foo.bar
")
          (expected "package foo

import org.allenai.something
import java.what
import some.foo.bar
import foo.bar
"))
      (insert contents)
      (ai2-move-imports-to-bottom "import foo\..*")
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-move-imports-to-bottom-no-matches-test ()
  (with-temp-buffer
    (let ((contents "package foo

import org.allenai.something
import java.what
import some.foo.bar
")
          (expected "package foo

import org.allenai.something
import java.what
import some.foo.bar
"))
      (insert contents)
      (ai2-move-imports-to-bottom "import foo\..*")
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-newline-after-test ()
  (with-temp-buffer
    (let ((contents "package foo

import org.allenai.something
import java.what
import some.foo.bar
import foo.bar
")
          (expected "package foo

import org.allenai.something
import java.what

import some.foo.bar
import foo.bar
"))
      (insert contents)
      (ai2-newline-after "import java\..*")
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-newline-after-multiple-matches-test ()
  (with-temp-buffer
    (let ((contents "package foo

import org.allenai.something
import some.foo.bar
import java.what
import java.not
import scala.not
")
          (expected "package foo

import org.allenai.something
import some.foo.bar
import java.what
import java.not
import scala.not

"))
      (insert contents)
      (ai2-newline-after "\\(import java\..*\\|import scala\..*\\)")
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-newline-after-no-matches-test ()
  (with-temp-buffer
    (let ((contents "package foo

import org.allenai.something
import some.foo.bar
import foo.bar
")
          (expected "package foo

import org.allenai.something
import some.foo.bar
import foo.bar
"))
      (insert contents)
      (ai2-newline-after "import java\..*")
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-newline-after-test ()
  (with-temp-buffer
    (let ((contents "package foo

import org.allenai.something
import java.what
import some.foo.bar
import foo.bar
")
          (expected "package foo

import org.allenai.something

import java.what
import some.foo.bar
import foo.bar
"))
      (insert contents)
      (ai2-newline-before "import java\..*")
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-newline-before-no-matches-test ()
  (with-temp-buffer
    (let ((contents "package foo

import org.allenai.something
import some.foo.bar
import foo.bar
")
          (expected "package foo

import org.allenai.something
import some.foo.bar
import foo.bar
"))
      (insert contents)
      (ai2-newline-before "import java\..*")
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-orgainize-imports-no-allenai-test ()
  (with-temp-buffer
    (let ((contents "package foo

import java.what
import some.foo.bar
import foo.bar
")
          (expected "package foo

import foo.bar
import some.foo.bar

import java.what
"))
      (insert contents)
      (ai2-organize-imports)
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-orgainize-imports-test ()
  (with-temp-buffer
    (let ((contents "package foo

import java.what
import some.foo.bar
import org.allenai.foo
import org.allenai.bar.baz
import scala.concurrent.duration._
import foo.bar
import java.net.URI
import org.allenai.Model
import spray.json
")
          (expected "package foo

import org.allenai.Model
import org.allenai.bar.baz
import org.allenai.foo

import foo.bar
import some.foo.bar
import spray.json

import java.net.URI
import java.what
import scala.concurrent.duration._
"))
      (insert contents)
      (ai2-organize-imports)
      (should (string= expected (buffer-string))))))

(ert-deftest ai2-orgainize-imports-scala-no-java-test ()
  (with-temp-buffer
    (let ((contents "package foo

import org.allenai.common.Config._
import org.allenai.common.Logging
import org.allenai.scholar.pipeline.spark._
import org.apache.spark.rdd.RDD
import scala.collection.mutable
")
          (expected "package foo

import org.allenai.common.Config._
import org.allenai.common.Logging
import org.allenai.scholar.pipeline.spark._

import org.apache.spark.rdd.RDD

import scala.collection.mutable

"))
      (insert contents)
      (ai2-organize-imports)
      (should (string= expected (buffer-string))))))

