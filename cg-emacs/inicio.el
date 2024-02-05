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
(setq desktop-dirname "~/.emacs.d/")
;(set-frame-font "Inconsolata 12" nil t t)
(set-frame-font "IBM Plex Mono 10" nil t t)
(set-fontset-font "fontset-default" '(#x0370 . #x03FF) "Liberation Mono")
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;Para que cree los backups en un directorio.
(add-to-list 'backup-directory-alist `("." . ,cg-var-backups))
;Buffer warnings al empezar sólo para errores graves.
;(setq warning-minimum-level :emergency)

;Añade opciones a la ayuda (F1 + M-...).
(dolist (e '(("f" . find-function) ("v" . find-variable)
			 ("l" . find-library)  ("k" . find-function-on-key)))
  (define-key 'help-command (kbd (concat "M-" (car e))) (cdr e)))

(setq-default
	tab-width 4
	truncate-lines t
	disabled-command-function nil ;Para que se habiliten todos los comandos y no pregunte.
	initial-major-mode 'fundamental-mode
	delete-by-moving-to-trash t
	calendar-week-start-day 1
	ring-bell-function #'ignore ;Para que no haya sonido.
	treemacs-width 43
	auto-save-default nil)

;Para sobreescribir sobre las selecciones de texto.
(delete-selection-mode t)
;;-----------------------------------------------------------------------------------------
(add-hook 'after-init-hook
  (lambda ()
	(desktop-read)
	(global-tree-sitter-mode)
	;Guarda la configuración de ventanas del frame que hay al abrir Emacs.
	(window-configuration-to-register ?1)
	(when (fboundp 'global-company-mode) (global-company-mode))
    ;Para que no salgan los nombres de los modos en la mode line.
	(cg-quitar-nombre-minor-mode "company" "counsel")

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

;Para que no salte la ventana cuando se ejecuta un comando shell de fondo.
(add-to-list 'display-buffer-alist '("\\*Async Shell Command\\*" . (display-buffer-no-window)))

;Para que al navegar adelante y atrás por los buffers no salgan los que no tengan archivo asociado.
(set-frame-parameter nil 'buffer-predicate (lambda (b) (buffer-file-name b)))

;Para que funcione el asterisco del portátil como <menu>.
(define-key local-function-key-map (kbd "<kp-multiply>") (kbd "<menu>"))

;Para añadir a cada buffer el proyecto al que pertenece.
(defvar-local cg-origen nil "Directorio raíz del proyecto o subproyecto.")
(add-hook 'find-file-hook
		  (lambda ()
			(setq cg-origen (or (locate-dominating-file buffer-file-name ".git")
								(locate-dominating-file buffer-file-name ".origen")))
			(unless cg-origen (setq cg-origen "~/"))))

;Utilidades propias para añadir a los distintos modos. Por cada nombre «n» debe haber
;un archivo «cg-"n"» que llame al final a la función «cg-configs-modo», definida en
;«func-modos».

(require 'func-modos)

(cg-retocar-modos
 "c"			 "company"		"counsel"		"css"
 "dired"		 "doc-view"		"emacs-lisp"	"emmet"
 "hs-minor"		 "ibuffer"		"ielm"			"js"
 "lsp"			 "nxml"			"org"			"php"
 "picture"		 "prog"			"sgml"			"tex"
 "treemacs"		 "typescript"	"twig"			"yaml"
 "web")
