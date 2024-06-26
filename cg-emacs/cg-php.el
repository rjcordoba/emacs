;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo PHP
;------------------------------------------------------------------

(require 'func-php)

(cg-configs-modo
 :tabla t
 :hook (λ (show-paren-mode -1))
 :quitar ("C-." "C-M-h" "C-d")
 :poner
 (("C-c -" . (λ (insert "->")))
  ("C-c _" . (λ (insert "=>")))
  ("C-c =" . php-echo)
  ("C-c C-c" . (λ (comentar/descomentar-bloque "/\*" "\*/" "//")))
  ("C-c s" . cg-servidor)
  ("C-c C-p" . poner-php)))
