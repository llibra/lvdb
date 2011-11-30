(in-package :lvdb.db.fs)

(defun put (db opt key-fs key-len val-fs val-len)
  (with-error-pointer (err-ptr)
    (leveldb-put db opt key-fs key-len val-fs val-len err-ptr)
    (handle-error-pointer err-ptr)
    (values)))

(defun delete (db opt key-fs key-len)
  (with-error-pointer (err-ptr)
    (leveldb-delete db opt key-fs key-len err-ptr)
    (handle-error-pointer err-ptr)
    (values)))

(defun get (db opt key-fs key-len &key (as 'string))
  (with-foreign-object (val-len-ptr 'size_t)
    (with-error-pointer (err-ptr)
      (let ((val-ptr (leveldb-get db opt key-fs key-len val-len-ptr err-ptr)))
        (handle-error-pointer err-ptr)
        (with-malloced-pointer (val-ptr)
          (let ((val-len (mem-aref val-len-ptr 'size_t)))
            (foreign-string->x as val-ptr val-len)))))))

(in-package :lvdb.db)

(defun open (opt name)
  (with-foreign-string (name-fs name)
    (with-error-pointer (err-ptr)
      (prog1 (leveldb-open opt name-fs err-ptr)
        (handle-error-pointer err-ptr)))))

(defun close (db)
  (leveldb-close db))

(defun put (db opt key val)
  (with-alloced-foreign-strings ((key-fs key-len (x->foreign-string key))
                                 (val-fs val-len (x->foreign-string val)))
    (lvdb.db.fs:put db opt key-fs key-len val-fs val-len)))

(defun delete (db opt key)
  (with-alloced-foreign-string (key-fs key-len (x->foreign-string key))
    (lvdb.db.fs:delete db opt key-fs key-len)))

(defun get (db opt key &rest args)
  (with-alloced-foreign-string (key-fs key-len (x->foreign-string key))
    (apply #'lvdb.db.fs:get db opt key-fs key-len args)))
