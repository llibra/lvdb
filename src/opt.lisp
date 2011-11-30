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

(in-package :lvdb.wopt)

(defun set (opt &key (sync nil sync-p))
  (when sync-p
    (let ((v (convert-to-foreign sync :boolean)))
      (leveldb-writeoptions-set-sync opt v))))

(defun create (&rest args)
  (let ((opt (leveldb-writeoptions-create)))
    (apply #'set opt args)
    opt))

(defun destroy (opt)
  (leveldb-writeoptions-destroy opt))

(defmacro with-write-options ((var &rest args) &body body)
  `(let ((,var (create ,@args)))
     (unwind-protect (progn ,@body)
       (destroy ,var))))

(in-package :lvdb.ropt)

(defun set (opt
            &key
            (verify-checksums nil verify-checksums-p)
            (fill-cache t fill-cache-p))
  (when verify-checksums-p
    (let ((v (convert-to-foreign verify-checksums :boolean)))
      (leveldb-readoptions-set-verify-checksums opt v)))
  (when fill-cache-p
    (let ((v (convert-to-foreign fill-cache :boolean)))
      (leveldb-readoptions-set-fill-cache opt v))))

(defun create (&rest args)
  (let ((opt (leveldb-readoptions-create)))
    (apply #'set opt args)
    opt))

(defun destroy (opt)
  (leveldb-readoptions-destroy opt))

(defmacro with-read-options ((var &rest args) &body body)
  `(let ((,var (create ,@args)))
     (unwind-protect (progn ,@body)
       (destroy ,var))))
