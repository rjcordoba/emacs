;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para Ivy
;------------------------------------------------------------------

(setf (cdr (assoc 'counsel-mode minor-mode-alist)) '(""))

(cg-configs-modo
  :poner (("C-x C-f" . counsel-git-grep)))