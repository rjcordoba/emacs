;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Archivo de inicio
;------------------------------------------------------------------

(defmacro λ (&rest forms) (append '(lambda () (interactive)) forms))

(defconst directorio-configs (concat (file-name-directory load-file-name) "cg-emacs/") "Directorio donde están los archivos de configuración")
(add-to-list 'load-path directorio-configs)

(defun directorio-cg (d)
  "Para ser llamada cada vez que se quiera acceder a un archivo; pone el directorio donde están las configuraciones."
  (concat directorio-configs d))

(load "variables")
(load "funciones")
(load "inicio")
(load "keybindings") 

;;Variables-parámetros-------------------------------------------------

(defconst cg-ignorar-lsp '("vendor" "var" "code-symfony")) ;Directorios que no vigilará lsp

;;---------------------------------------------------------------------


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(treemacs which-key dap-mode lsp-ivy lsp-treemacs flycheck company php-mode lsp-mode yaml-mode web-mode twig-mode treemacs-icons-dired counsel)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
