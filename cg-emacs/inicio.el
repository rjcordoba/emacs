;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;------------------------------------------------------------------
;;Aspecto
(load-theme 'cg t)
(fringe-mode '(9 . 9))
(add-to-list 'initial-frame-alist (quote (fullscreen . maximized)))
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(set-language-environment "UTF-8")
(desktop-save-mode 1)
(set-frame-font "Inconsolata 11")
(set-fontset-font "fontset-default" '(#x0370 . #x03FF) "Liberation Mono")
(setq-default tab-width 4)
(setq-default truncate-lines t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;Para que se habiliten todos los comandos y no pregunte.
(setq disabled-command-function nil)

;Para que cree los backups en un directorio.
(add-to-list 'backup-directory-alist `("." . ,cg-backups))

(add-hook 'emacs-startup-hook
 (lambda ()
   (window-configuration-to-register ?1)
   (with-current-buffer (get-buffer "*scratch*") (rename-buffer " *scratch*"))
   (global-company-mode) (setf (cdr (assoc 'company-mode minor-mode-alist)) '(nil))
  ;Para que funcione el keybinding global de Ctrl-j
   (dolist
	   (mapa '(minibuffer-local-map
			   ;; minibuffer-local-ns-map
			   minibuffer-local-completion-map
			   minibuffer-local-must-match-map
			   minibuffer-local-filename-completion-map
			   minibuffer-local-filename-must-match-map
			   ivy-minibuffer-map))
	 (define-key (symbol-value mapa) (kbd "C-j") nil))))

(setq initial-major-mode 'fundamental-mode)
(setq delete-by-moving-to-trash t)
(setq calendar-week-start-day 1)
(setq ring-bell-function 'ignore) ;Para que no haya sonido.

;Para que funcione el asterisco del portátil como <menu>.
(define-key local-function-key-map (kbd "<kp-multiply>") (kbd "<menu>"))

; Utilidades propias para añadir a los distintos modos. Por cada nombre «n» debe haber
; en archivo "cg-«n»" que llame al final a la función «cg-configs-modo», definida en
; «func-modos».

(require 'func-modos)

(cg-retocar-modos
 "dired"	  "doc-view"	"counsel"	   "ibuffer"
 "ielm"		  "lsp"		    "org"		   "php"
 "picture"	  "prog"		"sgml"  	   "tex"
 "treemacs")
