;; -*- lexical-binding: t  -*-

;; script for running the simulation as a standalone application
;; 
;;  emacs -l ga-run-simulator.el FILE.aforth

(toggle-debug-on-error)
(load-theme 'wombat t)
(set-cursor-color "#ff4500")
(setq frame-title-format "GA144")

(require 'cl)
(require 'gv)
(put 'flet 'byte-obsolete-info nil)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq inhibit-startup-message t)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
;;(set-fringe-mode 0)
;;(kill-buffer "*scratch*")
;;(setq message-log-max nil)
;;(kill-buffer "*Messages*")

(blink-cursor-mode 0)

(when (< (length command-line-args) 3)
  (princ "Usage: ga-sim FILE.json\n" #'external-debugging-output)
  (kill-emacs))

(setq base (file-name-directory (or buffer-file-name load-file-name))
      base (file-name-directory (substring base 0 -1)))

(add-to-list 'load-path (concat base "src"))

(setq dir (nth 3 command-line-args))
(let ((file (nth 4 command-line-args)))
  (unless file
    (princ "Error: missing filename\n" #'external-debugging-output)
    (kill-emacs))
  (setq filename file))

(load "ga-loadup.el")
(ga-loadup) ;; TODO: don't loadup compiler here

(require 'json)
(defun read-json (filename)
  (let* ((json-object-type 'hash-table)
         (json-array-type 'vector)
         (json-key-type 'string))
    (princ (json-read-file filename)
           #'external-debugging-output)
    (json-read-file filename)
    ))


;;(setq ga-load-bootstream (member "--sim-bootstream" command-line-args))
;;TODO: sim bootstream if it is provided in the json
(setq ga-load-bootstream nil)

(setq ga-default-node-size 6)

;;(when (string= (file-name-extension filename) "ga")
;;  (setq bowman-format t))


(defun open-sim ()
  ;;  (find-file filename) ;; get filename from json
  ;;  get all the filenames from included files.
  (setq mode-line-format filename)  ;; ok to do here
  
  (setq ga-sim-buffer (ga-new-simulation (read-json filename)))
  ;; how to keep from scrolling down?
  ;; TODO: need to check screen size to size initial map
  (switch-to-buffer ga-sim-buffer)
  ;;(pop-to-buffer-same-window ga-sim-buffer)
  ;;(set-window-buffer (selected-window) ga-sim-buffer)
  ;;(pop-to-buffer ga-sim-buffer)

  (setq mode-line-format "Simulation")
  ;;(redraw-display)
  ;;(redraw-frame)
  (delete-other-windows)
  (message ""))


;;for some reason this must be called after some delay or the
;;map buffer will not be visible
;;the delay must be > 0.0001
;; And when running uncompiled, it needs to be even longer
;;(open-sim)
(run-at-time 0.01 nil 'open-sim)
(message "")
