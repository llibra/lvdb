(in-package :lvdb.ffi)

(define-foreign-library libleveldb
  (:unix "libleveldb.so.0"))

(use-foreign-library libleveldb)

(defctype size_t #+x86-64 :uint64 #-x86-64 :uint32)

(defcfun "leveldb_options_create" :pointer)

(defcfun "leveldb_options_destroy" :void
  (options :pointer))

(defcfun "leveldb_options_set_create_if_missing" :void
  (opt :pointer)
  (v :uchar))

(defcfun "leveldb_writeoptions_create" :pointer)

(defcfun "leveldb_writeoptions_destroy" :void
  (opt :pointer))

(defcfun "leveldb_writeoptions_set_sync" :void
  (opt :pointer)
  (v :uchar))

(defcfun "leveldb_readoptions_create" :pointer)

(defcfun "leveldb_readoptions_destroy" :void
  (opt :pointer))

(defcfun "leveldb_readoptions_set_verify_checksums" :void
  (opt :pointer)
  (v :uchar))

(defcfun "leveldb_readoptions_set_fill_cache" :void
  (opt :pointer)
  (v :uchar))

(defcfun "leveldb_open" :pointer
  (options :pointer)
  (name :pointer)
  (errptr :pointer))

(defcfun "leveldb_close" :void
  (db :pointer))

(defcfun "leveldb_put" :void
  (db :pointer)
  (options :pointer)
  (key :pointer)
  (keylen size_t)
  (val :pointer)
  (vallen size_t)
  (errptr :pointer))

(defcfun "leveldb_delete" :void
  (db :pointer)
  (options :pointer)
  (key :pointer)
  (keylen size_t)
  (errptr :pointer))

(defcfun "leveldb_get" :pointer
  (db :pointer)
  (options :pointer)
  (key :pointer)
  (keylen size_t)
  (vallen :pointer)
  (errptr :pointer))

(defcfun "free" :void
  (ptr :pointer))
