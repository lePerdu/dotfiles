;; Override package.el internals to treat OPAM packages as builtins
;; This has to be done in early-init so that it happens before
;; `package-initialize'.

(defvar opam-command
  (let ((command "~/.opam/default/bin/opam"))
    (and (file-executable-p command) command))
  "Location of OPAM executable.")

(defvar opam-site-lisp
  (and opam-command
       (let ((opam-share (car (process-lines opam-command "var" "share"))))
         (and opam-share
              (file-directory-p opam-share)
              (expand-file-name "emacs/site-lisp" opam-share))))
  "Path where OPAM EMACS files are stored.")

(defvar opam-packages
  '(dune
    dune-flymake
    merlin
    merlin-company
    merlin-iedit
    merlin-imenu
    ocamlformat
    utop)
  "Packages installed via OPAM instead of (M)ELPA.")

(define-advice package-built-in-p
    (:around (inner pkg &optional min-version) opam-packages-builtin)
  (let ((package-name (if (package-desc-p pkg) (package-desc-name pkg) pkg)))
    (or (memq package-name opam-packages)
        (funcall inner pkg min-version))))
