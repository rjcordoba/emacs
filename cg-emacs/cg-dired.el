;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo Dired
;------------------------------------------------------------------
(setq dired-dwin-target t)

(defun cg-abrir-archivo (&optional n)
   "Abre en la ventana que se seleccione con el argumento el archivo
 indicado por el cursor en Dired. Por defecto abre en la siguiente ventana."
   (interactive "p")
   (let ((f (dired-get-file-for-visit))
		 (v (or n 1)))
    	(other-window v)
    	(find-file f)))
			   
(cg-configs-modo
 :poner
 (("C-c C-<dead-acute>" . dired-isearch-filenames)
  ("M-o" . cg-abrir-archivo)
  ("M-O" . (λ (cg-abrir-archivo -1)))))
