(in-package :lvdb.db.fs)

(defun put (db opt key-fs key-len val-fs val-len)
  (with-error-pointer (err-ptr)
    (leveldb-put db opt key-fs key-len val-fs val-len err-ptr)
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
  (with-foreign-string (name-ptr name)
    (with-foreign-object (err-ptr :pointer)
      (setf (mem-aref err-ptr :pointer) (null-pointer))
      (let ((db (leveldb-open opt name-ptr err-ptr)))
        (if (null-pointer-p db)
            (let ((ptr (mem-aref err-ptr :pointer)))
              (unwind-protect (error (foreign-string-to-lisp ptr))
                (free ptr)))
            db)))))

(defun close (db)
  (leveldb-close db))

(defun put (db opt key val)
  (with-alloced-foreign-strings ((key-fs key-len (x->foreign-string key))
                                 (val-fs val-len (x->foreign-string val)))
    (lvdb.db.fs:put db opt key-fs key-len val-fs val-len)))

(defun get (db opt key &rest args)
  (with-alloced-foreign-string (key-fs key-len (x->foreign-string key))
    (apply #'lvdb.db.fs:get db opt key-fs key-len args)))
