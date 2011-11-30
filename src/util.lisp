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

(defmacro with-alloced-foreign-string ((var len-var form) &body body)
  `(multiple-value-bind (,var ,len-var) ,form
     (unwind-protect (progn ,@body) (foreign-free ,var))))

(defmacro with-alloced-foreign-strings (bindings &body body)
  (destructuring-bind (binding . rest) bindings
    (if rest
        `(with-alloced-foreign-string ,binding
           (with-alloced-foreign-strings ,rest ,@body))
        `(with-alloced-foreign-string ,binding ,@body))))
