(in-package :lvdb.conv)

(defgeneric x->foreign-string (x)
  (:documentation "Converts X to a foreign string.

If you would like to support a new user-defined data structure, define a method
for the data structure. Each method is required to return a allocated foreign
string and the length of it."))

(defmethod x->foreign-string ((s string))
  (foreign-string-alloc s :null-terminated-p nil))

(defgeneric foreign-string->x (type fs len)
  (:documentation "Converts a foreign string to a Lisp object.

If you would like to support a new user-defined data structure, define a method
for the data structure. Each method is required to return a Lisp object."))

(defmethod foreign-string->x ((type (eql 'string)) fs len)
  (foreign-string-to-lisp fs :count len))
