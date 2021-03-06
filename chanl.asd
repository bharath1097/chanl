;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;;
;;;; Copyright © 2009 Josh Marchan, Adlai Chandrasekhar
;;;;
;;;; Another System Definition
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(asdf:defsystem chanl
  :name "chanl"
  :maintainer "Josh Marchan"
  :author "Josh Marchan"
  :description "Communicating Sequential Process support for Common Lisp"
  :depends-on (:bordeaux-threads)
  :components
  ((:module "src"
            :serial t
            :components ((:file "trivial-cas")
                         (:file "package")
                         (:file "utils")
                         (:file "threads")
                         (:file "queues")
                         (:file "channels")
                         (:file "select")))))

(asdf:defsystem chanl.examples
  :name "chanl examples"
  :maintainer "Adlai Chandrasekhar"
  :author "Josh Marchan"
  :description "Examples of how to use chanl"
  :depends-on (:chanl)
  :serial t
  :components
  ((:module "examples"
            :serial t
            :components ((:file "package")
                         (:file "utils")
                         (:file "conditions")
                         (:file "sieve")
                         (:file "futures")))))

(asdf:defsystem chanl.tests
  :name "chanl tests"
  :description "Unit Tests for the ChanL library and its examples"
  :depends-on (:chanl :fiveam)
  :serial t
  :components
  ((:module "tests"
            :serial t
            :components ((:file "setup-tests")
                         (:file "threads")
                         (:file "queues")
                         (:file "channels")
                         (:file "select")))))

(defmethod asdf:perform ((op asdf:test-op) (system (eql (asdf:find-system :chanl))))
  (format t "~2&*******************~@
                ** Loading tests **~@
                *******************~%")
  (asdf:oos 'asdf:load-op :chanl.tests)
  (asdf:oos 'asdf:test-op :chanl.tests))
