;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para counsel
;------------------------------------------------------------------

(define-key ivy-minibuffer-map (kbd "C-j") nil)

(cg-configs-modo
  :poner (("C-x C-f" . counsel-git-grep)))
