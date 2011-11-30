(defpackage :leveldb.ffi
  (:nicknames :lvdb.ffi)
  (:use :cl :cffi)
  (:export :size_t

           :free

           :leveldb-options-create :leveldb-options-destroy
           :leveldb-options-set-create-if-missing

           :leveldb-writeoptions-create :leveldb-writeoptions-destroy
           :leveldb-writeoptions-set-sync

           :leveldb-readoptions-create :leveldb-readoptions-destroy
           :leveldb-readoptions-set-verify-checksums
           :leveldb-readoptions-set-fill-cache

           :leveldb-open :leveldb-close :leveldb-put :leveldb-get))

(defpackage :leveldb.utilities
  (:nicknames :leveldb.util :lvdb.util)
  (:use :cl :cffi :lvdb.ffi)
  (:export :with-error-pointer :with-malloced-pointer :handle-error-pointer
           :with-alloced-foreign-string :with-alloced-foreign-strings))

(defpackage :leveldb.conversion
  (:nicknames :leveldb.conv :lvdb.conv)
  (:use :cl :cffi :lvdb.ffi)
  (:export :x->foreign-string :foreign-string->x))

(defpackage :leveldb.options
  (:nicknames :leveldb.opt :lvdb.opt)
  (:use :cl :cffi :lvdb.ffi)
  (:shadow :set)
  (:export :set :create :destroy :with-options))

(defpackage :leveldb.write-options
  (:nicknames :leveldb.writeopt :lvdb.writeopt :lvdb.wopt)
  (:use :cl :cffi :lvdb.ffi)
  (:shadow :set)
  (:export :set :create :destroy :with-write-options))

(defpackage :leveldb.read-options
  (:nicknames :leveldb.readopt :lvdb.readopt :lvdb.ropt)
  (:use :cl :cffi :lvdb.ffi)
  (:shadow :set)
  (:export :set :create :destroy :with-read-options))

(defpackage :leveldb.database
  (:nicknames :leveldb.db :lvdb.db)
  (:use :cl :cffi :lvdb.ffi :lvdb.util :lvdb.conv)
  (:shadow :close :get :open)
  (:export :open :close :put :get))

(defpackage :leveldb.database.foreign-string
  (:nicknames :leveldb.db.fs :lvdb.db.fs)
  (:use :cl :cffi :lvdb.ffi :lvdb.util :lvdb.conv)
  (:shadow :get)
  (:export :put :get))
