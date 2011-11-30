(in-package :lvdb.util)

(defmacro with-error-pointer ((var) &body body)
  `(with-foreign-object (,var :pointer)
     (setf (mem-aref ,var :pointer) (null-pointer))
     ,@body))

(defmacro with-malloced-pointer ((ptr) &body body)
  `(unwind-protect (progn ,@body)
     (free ,ptr)))

(defun handle-error-pointer (err-ptr)
  (let ((ptr (mem-aref err-ptr :pointer)))
    (unless (null-pointer-p ptr)
      (with-malloced-pointer (ptr)
        (error (foreign-string-to-lisp ptr))))))
