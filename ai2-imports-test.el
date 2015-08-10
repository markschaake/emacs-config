(load-file "./ai2-imports.el")

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

