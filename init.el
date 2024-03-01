;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Archivo de inicio
;------------------------------------------------------------------

(defconst directorio-configs (concat (file-name-directory load-file-name) "cg-emacs/")
  "Directorio donde están los archivos de configuración")
(add-to-list 'load-path directorio-configs)

(defun directorio-cg (d)
  "Para ser llamada cada vez que se quiera acceder a un archivo;
 pone el directorio donde están las configuraciones."
  (concat directorio-configs d))

(load "cg-variables")
(load "funciones")
(load "inicio")
(load "keybindings") 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company-tabnine nyan-mode treemacs-magit magit lsp-java emmet-mode tree-sitter tree-sitter-langs ts-comint typescript-mode lsp-python-ms helm-lsp multiple-cursors lsp-mode json-mode lsp-ui yasnippet treemacs which-key dap-mode lsp-ivy lsp-treemacs flycheck company php-mode yaml-mode web-mode twig-mode treemacs-icons-dired counsel)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
