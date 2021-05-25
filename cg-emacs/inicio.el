;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;------------------------------------------------------------------
;;Aspecto
(load-theme 'cg t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode '(9 . 9))
(add-to-list 'initial-frame-alist (quote (fullscreen . maximized)))

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

;Añade opciones a la ayuda (F1 + M-...).
(dolist (e '(("f" . find-function) ("v" . find-variable)
			 ("l" . find-library)  ("k" . find-function-on-key)))
  (define-key 'help-command (kbd (concat "M-" (car e))) (cdr e)))

(setq initial-major-mode 'fundamental-mode)
(setq delete-by-moving-to-trash t)
(setq calendar-week-start-day 1)
(setq eshell-buffer-name " *eshell*")
(setq ring-bell-function 'ignore) ;Para que no haya sonido.

;;-----------------------------------------------------------------------------------------
(add-hook 'emacs-startup-hook
 (lambda ()
   (window-configuration-to-register ?1)
   (with-current-buffer "*scratch*" (cg-esp-nom-buff))
   (global-company-mode)
;Para que no salgan los nombres de los modos en la mode line.
   (cg-quitar-nombre-minor-mode "company" "which-key")
   
  ;Para que funcione el keybinding global de Ctrl-j.
   (dolist
	   (mapa '(minibuffer-local-map
			   minibuffer-local-completion-map
			   minibuffer-local-must-match-map
			   minibuffer-local-filename-completion-map
			   minibuffer-local-filename-must-match-map
			   ivy-minibuffer-map))
	 (define-key (symbol-value mapa) (kbd "C-j") nil))))
;;-----------------------------------------------------------------------------------------

;Para que funcione el asterisco del portátil como <menu>.
(define-key local-function-key-map (kbd "<kp-multiply>") (kbd "<menu>"))

;Para añadir a cada buffer el proyecto al que pertenece.
(defvar-local cg-origen nil "Directorio raíz del proyecto o subproyecto.")
(add-hook 'find-file-hook
 (lambda ()
   (setq cg-origen (or (locate-dominating-file buffer-file-name ".git")
					   (locate-dominating-file buffer-file-name ".origen")))))

; Utilidades propias para añadir a los distintos modos. Por cada nombre «n» debe haber
; un archivo «cg-"n"» que llame al final a la función «cg-configs-modo», definida en
; «func-modos».

(require 'func-modos)

(cg-retocar-modos
 "counsel"		"dired"		"doc-view"		"emacs-lisp"
 "ibuffer"		"ielm"		"js"			"lsp"
 "org"			"php"		"picture"		"prog"
 "sgml"			"tex"		"treemacs"		"twig")
