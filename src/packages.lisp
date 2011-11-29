(defpackage :leveldb.ffi
  (:nicknames :lvdb.ffi)
  (:use :cl :cffi)
  (:export :free

           :leveldb-options-create :leveldb-options-destroy
           :leveldb-options-set-create-if-missing
           :leveldb-open :leveldb-close))

(defpackage :leveldb.options
  (:nicknames :lvdb.opt)
  (:use :cl :cffi :lvdb.ffi)
  (:shadow :set)
  (:export :set :create :destroy :with-options))

(defpackage :leveldb.database
  (:nicknames :lvdb.db)
  (:use :cl :cffi :lvdb.ffi)
  (:shadow :open :close)
  (:export :open :close))
