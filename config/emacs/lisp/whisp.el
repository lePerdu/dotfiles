;;; whisp.el --- support for Whisp language

;;; Commentary:
;;

;;; Code:

(require 'comint)

(defvar-keymap whisp-mode-map
    :doc "Keymap for Whisp mode.
All commands in `lisp-mode-shared-map' are inherited by this map."
  :parent lisp-mode-shared-map)

(defvar whisp-mode-syntax-table
  (let ((st (make-syntax-table)) char)
    (setq char ?A)
    (while (<= char ?Z)
      (modify-syntax-entry char "w" st)
      (setq char (1+ char)))

    (setq char ?a)
    (while (<= char ?z)
      (modify-syntax-entry char "w" st)
      (setq char (1+ char)))

    (setq char ?0)
    (while (<= char ?9)
      (modify-syntax-entry char "w" st)
      (setq char (1+ char)))

    (seq-doseq (char "!$%^&*-_=+|:<>/?")
      (modify-syntax-entry char "_" st))

    ;; Whitespace
    (modify-syntax-entry ?\s " " st)
    (modify-syntax-entry ?\t " " st)
                                        ; TODO Should this also count as a comment terminator?
    (modify-syntax-entry ?\r " " st)
    (modify-syntax-entry ?\f " " st)
    (modify-syntax-entry ?\n ">" st)

    ;; Comments
    (modify-syntax-entry ?\; "< " st)

    ;; Lists
    (modify-syntax-entry ?\( "()" st)
    (modify-syntax-entry ?\) ")(" st)
    (modify-syntax-entry ?. "." st)

    ;; Reader macros
    (modify-syntax-entry ?' "'" st)
    (modify-syntax-entry ?` "'" st)
    (modify-syntax-entry ?~ "'" st)
    (modify-syntax-entry ?@ "'" st)

    ;; Strings
    (modify-syntax-entry ?\" "\"" st)
    (modify-syntax-entry ?\\ "\\" st)

    st))

(defvar whisp-mode-font-lock-keywords-1
  (list
   (regexp-opt
    '("def!" "defn!" "defn-case!"
      "defsyntax!" "defmacro!" "defmacro-case!"
      "defgeneric!" "defmethod!"
      "fn" "fn-case")
    'symbols))
  "Level 1 fontification keywords.
Includes function declarations, strings, and comments.")

(defvar whisp-mode-font-lock-keywords-2
  (append
   whisp-mode-font-lock-keywords-1
   (list
    (regexp-opt
     '("nil" "true" "false"
       "do"
       "if" "when" "cond" "case" "else"
       "let" "let*" "let-if" "let-cond"
       "let-cons" "let-if-cons"
       "let-named" "for"
       "guard" "let/ec")
     'symbols)))
  "Level 2 fontification keywords.

Includes all builtin syntax keywords (including common ones
defined in the prelude).")

(defvar whisp-mode-font-lock-keywords
  whisp-mode-font-lock-keywords-2
  "Default fontification keywords.")

;; TODO Put this into a separate file/module
(define-derived-mode whisp-mode prog-mode "Whisp"
  "Major mode for Whisp."
  (setq-local comment-start ";")
  (setq font-lock-defaults
        '((whisp-mode-font-lock-keywords
           whisp-mode-font-lock-keywords-1
           whisp-mode-font-lock-keywords-2))))

(add-to-list 'auto-mode-alist
             '("\\.wh\\'" . whisp-mode))

;; Internal variable used for `run-whisp'
(defvar inferior-whisp-buffer)

(defun inferior-whisp-input-sender (proc string)
  "Remove embedded newlines in STRING, then send STRING to PROC.

\(like `comint-simple-send')

This will be replaced/removed once the Whisp REPL is able to accept multi-line
expressions."
  (comint-simple-send proc
                      (replace-regexp-in-string "\n[ \t]*" " " string)))

(define-derived-mode inferior-whisp-mode comint-mode "Inferior Whisp"
  "Major mode for interacting with an inferior Whisp process."
  (setq comint-prompt-regexp "^> *")
  (setq comint-input-sender 'inferior-whisp-input-sender))

(defcustom whisp-program-name "whisp"
  "Program invoked by the `run-whisp' command."
  :type 'string
  :group 'whisp)

(defun switch-to-whisp (eob-p)
  "Switch to the Whisp process buffer.

The Whisp process is started if not already running."
  (interactive "P")
  (if (get-buffer-process inferior-whisp-buffer)
      (let ((pop-up-frames
             ;; Open in a new frame if already open in that frame
             (or pop-up-frames
                 (get-buffer-window inferior-whisp-buffer t))))
        (pop-to-buffer inferior-whisp-buffer))
    (run-whisp whisp-program-name))
  (when eob-p
    (push-mark)
    (goto-char (point-max))))

(defun run-whisp (cmd)
  "Run an inferior Whisp process, input and output via buffer `*whisp*'.

If there is a process already running in `*whisp*', switch to
that buffer.  With argument, allows you to edit the command line,
CMD (default is value of `whisp-program-name').

Runs the hook `inferior-whisp-mode-hook' (after the
`comint-mode-hook' is run).

\(Type \\[describe-mode] in the process buffer for a list of commands.)"

  (interactive
   (list (if current-prefix-arg
             (read-string "Run Whisp: " whisp-program-name)
           whisp-program-name)))
  (if (not (comint-check-proc "*whisp*"))
      (let ((cmdlist (split-string-and-unquote cmd)))
        (setq inferior-whisp-buffer
              (apply #'make-comint "whisp" (car cmdlist) nil (cdr cmdlist)))
        (set-buffer inferior-whisp-buffer)
        (inferior-whisp-mode)))
  (setq whisp-program-name cmd)
  (pop-to-buffer inferior-whisp-buffer display-comint-buffer-action))

(defun inferior-whisp-proc ()
  (let ((proc (get-buffer-process
               (if (derived-mode-p 'inferior-whisp-mode)
				   (current-buffer)
				 inferior-whisp-buffer))))
    (or proc
	    (error "No Whisp subprocess; see variable `inferior-whisp-buffer'"))))

(defun whisp-eval-region (start end &optional and-go)
  "Send the current region to the inferior Whisp process.
Prefix argument means switch to the Whisp buffer afterwards."
  (interactive "r\nP")
  ;; Send using the custom sender since the REPL can't handle multi-line
  ;; expressions yet
  (inferior-whisp-input-sender (inferior-whisp-proc)
                               (buffer-substring start end))
  (if and-go (switch-to-whisp t)))

(defun whisp-eval-last-sexp (&optional and-go)
  "Send the previous sexp to the inferior Whisp process.

Prefix argument means switch to the Whisp buffer afterwards."
  (interactive "P")
  (whisp-eval-region (save-excursion (backward-sexp) (point)) (point) and-go))

(defun whisp-eval-form-and-next (&optional and-go)
  "Send the previous sexp to the inferior Whisp process and move to the next one.

Prefix argument means switch to the Whisp buffer afterwards."
  (interactive "P")
  ;; Move to the top form first
  (while (not (zerop (car (syntax-ppss))))
    (up-list))
  ;; Wait to switch to the inferior process buffer
  (whisp-eval-last-sexp nil)
  (forward-sexp)
  (if and-go (switch-to-whisp t)))

(defun whisp-eval-defun (&optional and-go)
  "Send the current top-level sexp to the inferior Whisp process.

Prefix argument means switch to the Whisp buffer afterwards."
  (interactive "P")
  (let ((range (save-excursion
                 (beginning-of-defun)
                 (let ((start (point)))
                   (forward-sexp)
                   (cons start (point))))
               ))
    (whisp-eval-region (car range) (cdr range) and-go)))

(defun whisp-eval-buffer (&optional and-go)
  "Send the contents of the entire buffer to the inferior Whisp process.

Prefix argument means switch to the Whisp buffer afterwards."
  (interactive "P")
  (whisp-eval-region (point-min) (point-max) and-go))

(keymap-set whisp-mode-map "C-x C-e" #'whisp-eval-last-sexp)
(keymap-set whisp-mode-map "C-M-x" #'whisp-eval-defun)
(keymap-set whisp-mode-map "C-c C-r" #'whisp-eval-region)
(keymap-set whisp-mode-map "C-c C-n" #'whisp-eval-form-and-next)
(keymap-set whisp-mode-map "C-c C-z" #'switch-to-whisp)

(provide 'whisp)

;;; whisp.el ends here
