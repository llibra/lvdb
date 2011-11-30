(in-package :cl-user)
(defpackage :lvdb.asdf (:use :cl :asdf))
(in-package :lvdb.asdf)

(defsystem :lvdb
  :version "0.0"
  :author "Manabu Takayama <learn.libra@gmail.com>"
  :license "MIT License"
  :depends-on (:alexandria :cffi)
  :components ((:module "src"
                        :serial t
                        :components ((:file "packages")
                                     (:file "ffi")
                                     (:file "util")
                                     (:file "opt")
                                     (:file "db")))))
