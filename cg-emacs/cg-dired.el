;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo Dired
;------------------------------------------------------------------

(eval-when-compile
  (require 'funciones))

(defun cg-abrir-archivo (&optional n)
  (interactive "p")
  "Abre en la ventana que se seleccione con el argumento el archivo indicado por el cursor en Dired.
Por defecto abre en la siguiente ventana."
  (let ((f (dired-get-file-for-visit)))
  (other-window n) (find-file f)))
			   
(defun cg-dired ()
  "Pone los keybinding para las funciones, en la tabla local del modo mayor."
  (interactive)
  (poner-keys'(("M-o" . cg-abrir-archivo)
			   ("M-O" . (λ (cg-abrir-archivo -1))))))

(remove-hook 'dired-mode-hook 'cg-dired)

 
