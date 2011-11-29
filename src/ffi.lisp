(in-package :lvdb.ffi)

(define-foreign-library libleveldb
  (:unix "libleveldb.so.0"))

(use-foreign-library libleveldb)

(defcfun "leveldb_options_create" :pointer)

(defcfun "leveldb_options_destroy" :void
  (options :pointer))

(defcfun "leveldb_options_set_create_if_missing" :void
  (opt :pointer)
  (v :uchar))

(defcfun "leveldb_open" :pointer
  (options :pointer)
  (name :pointer)
  (errptr :pointer))

(defcfun "leveldb_close" :void
  (db :pointer))

(defcfun "free" :void
  (ptr :pointer))
