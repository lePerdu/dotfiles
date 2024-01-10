;;; auto-color-scheme.el --- D-Bus listener to change light/dark theme based on system settings

;;; Commentary:
;;
;; This package provides a D-Bus listener for
;; `org.freedesktop.portal.Settings' to synchronize EMACS to the
;; system light/dark theme.
;;
;;   (auto-color-scheme-activate)

;;; Code:

(require 'dbus)

(defvar auto-color-scheme-dark-theme nil
  "Theme to use if the system prefers dark mode.")
(defvar auto-color-scheme-light-theme nil
  "Theme to use if the system prefers light mode.")
(defvar auto-color-scheme-default-theme nil
  "Theme to use if the system has no preference.")

(defun auto-color-scheme--handle-changed (namespace key value)
  "Update the Emacs theme to match system light/dark mode.

NAMESPACE, KEY, and VALUE are provided from the D-Bus event."
  (let* ((color-scheme-value (car value))
         (emacs-theme (cond
                       ((= color-scheme-value 1) auto-color-scheme-dark-theme)
                       ((= color-scheme-value 2) auto-color-scheme-light-theme)
                       (t auto-color-scheme-default-theme))))
    (mapc #'disable-theme custom-enabled-themes)
    (when emacs-theme
      (load-theme emacs-theme t))))

(defvar dbus-color-scheme-listener nil
  "D-Bus listener handler for receiving color scheme updates.
If not NIL, this can be passed to `dbus-unregister-object' to
remove the listener.")

(defun auto-color-scheme-register ()
  "Start listening for D-Bus events for the system color scheme.

EMACS color scheme is then updated to match it."
  (interactive)
  ;; Make sure old listener is removed first
  (auto-color-scheme-deactivate)
  (setq dbus-color-scheme-listener
        (dbus-register-signal
         :session
         nil
         "/org/freedesktop/portal/desktop"
         "org.freedesktop.portal.Settings"
         "SettingChanged"
         #'auto-color-scheme--handle-changed
         :arg-namespace "org.freedesktop.appearance"
         :arg1 "color-scheme")))

(defun auto-color-scheme-deactivate ()
  "Stop listening for color scheme change events."
  (interactive)
  (when dbus-color-scheme-listener
    (dbus-unregister-object dbus-color-scheme-listener))
  (setq dbus-color-scheme-listener nil))

(defun auto-color-scheme-apply ()
  "Update the Emacs theme to match the system.

This can be used to synchronize at startup or in case Emacs gets
out of sync with the system preference."
  (interactive)
  ;; Call asynchronously in case the method takes time for some reason
  (dbus-call-method-asynchronously
   :session
   "org.freedesktop.portal.Desktop"
   "/org/freedesktop/portal/desktop"
   "org.freedesktop.portal.Settings"
   "ReadOne"
   (lambda (value)
     (auto-color-scheme--handle-changed
      "org.freedesktop.appearance" "color-scheme" value))
   "org.freedesktop.appearance"
   "color-scheme"))

(defun auto-color-scheme-activate ()
  "Synchronize the color scheme and start listening for events."
  (interactive)
  (auto-color-scheme-register)
  ;; Apply now since there isn't an event sent at startup
  (auto-color-scheme-apply))

(provide 'auto-color-scheme)

;;; auto-color-scheme.el ends here
