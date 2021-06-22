;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo PHP
;------------------------------------------------------------------

(cg-configs-modo
 :quitar ("C-." "C-M-h")
 :poner
 (("C-c -" . (λ (insert "->")))
  ("C-c _" . (λ (insert "=>")))
  ("C-c s" . cg-servidor)))
