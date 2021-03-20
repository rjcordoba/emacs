;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Funciones generales
;------------------------------------------------------------------

(defun cg-lambda () (interactive) (insert ?λ))

(defun cg-servidor ()
  "Abre un subproceso en fondo con un servidor web; el comando está en «variables»."
  (interactive)
  (async-shell-command cg-servidor)
  (quit-window nil (get-buffer-window "*Async Shell Command*"))
  (message "Ejecutado: %s" cg-servidor))

(defun cg-vaciar-backups ()
	"Vacía el directorio donde se guardan los archivos backups."
  (interactive)
  (dolist (f (directory-files cg-backups t "!.*" t))
	(delete-file f))
  (message "Vaciado el directorio %s" cg-backups))

(defun cg-poner-menor (modo)
  "Activa el modo sin que salga el nombre en la «mode line»."
  (funcall modo)
  (setf (cdr (assoc modo minor-mode-alist)) '(nil)))

(defun otra-ventana (f v)
  "Ejecuta la función en otra ventana sin dejarla activa."
  (let ((w (selected-window))) (select-window v) (funcall f) (select-window w)))
