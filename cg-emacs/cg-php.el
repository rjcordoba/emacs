;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo PHP
;------------------------------------------------------------------

(defun empezar-php (n)
  "Mete etiqueta PHP."
  (interactive "p")
  (insert "<?php")
  (when (> n 1)
	(insert "?>")
	(backward-char 2))
  (when (> n 4)
	(backward-kill-word 1)
	(insert "=")))

(cg-configs-modo
 :tabla t
 :quitar ("C-." "C-M-h" "C-d")
 :poner
 (("C-c -" . (λ (insert "->")))
  ("C-c _" . (λ (insert "=>")))
  ("C-c C-c" . (λ (comentar/descomentar-bloque "/\*" "\*/" "//")))
  ("C-c s" . cg-servidor)
  ("C-c e" . empezar-php)))
