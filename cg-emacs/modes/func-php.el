;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Funciones para modos que usen PHP
;------------------------------------------------------------------

(defun poner-php (n)
  "Mete etiqueta PHP."
  (interactive "p")
  (insert "<?php  ?>")
  (backward-char 3)  
  (when (> n 1)
	(delete-horizontal-space)
	(newline 2)
	(backward-char))
  (when (> n 4)
	(kill-line 2)))

(defun php-echo ()
  (interactive)
  (insert "<?=  ?>")
  (backward-char 3))

(provide 'func-php)
