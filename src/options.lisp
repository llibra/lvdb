(in-package :lvdb.opt)

(defun set (opt
            &key
            (create-if-missing nil create-if-missing-p))
  (when create-if-missing-p
    (let ((v (convert-to-foreign create-if-missing :boolean)))
      (leveldb-options-set-create-if-missing opt v))))

(defun create (&rest args)
  (let ((opt (leveldb-options-create)))
    (apply #'set opt args)
    opt))

(defun destroy (opt)
  (leveldb-options-destroy opt))

(defmacro with-options ((var &rest args) &body body)
  `(let ((,var (create ,@args)))
     (unwind-protect (progn ,@body)
       (destroy ,var))))
