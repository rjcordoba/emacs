;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Funciones generales
;------------------------------------------------------------------

(defun cg-lambda () (interactive) (insert ?λ))

(defgroup cg-faces nil "Faces para usar en funciones propias."
  :group 'faces-group)

(defface cg-cabecera
  '((t :foreground "#e59544"))
  "Color para presentar mensajes en el minibuffer."
  :group 'cg-faces)

(defface cg-consulta
  '((t :foreground "#0ed6be"))
  "Color para pedir texto en el minibuffer."
  :group 'cg-faces)

(defun colorear-cab (s)
  "Devuelve el string «s» con el estilo «cg-cabecera»."
  (put-text-property 0 (length s) 'face 'cg-cabecera s)
  s)

(defun colorear-consulta (s)
  "Devuelve el string «s» con el estilo «cg-consulta»."
  (put-text-property 0 (length s) 'face 'cg-consulta s)
  s)

(defun cg-comando-fondo (c &optional d)
  "Ejecuta comando shell asíncrono. Llama a la función cg-comando."
  (cg-comando c t d))

(defun cg-shell-comando (c &optional d)
  "Ejecuta comando shell síncrono. Llama a la función cg-comando."
  (cg-comando c nil d))

(defun cg-comando (c async &optional d)
  "Ejecuta de fonde el comando que se mete como argumento. Si se mete argumento d lo toma
como directorio actual. Si no toma como directorio el del proyecto. En caso de que éste no
existiera, y como último recurso, pregunta el directorio en el que se ejecutará el comando."
  (let ((default-directory (or d cg-origen (read-directory-name "Directorio: "))))
	(if async (async-shell-command c) (shell-command c)))
  (message "%s %s" (colorear-cab "Ejecutado:") c))

(defun cg-vaciar-backups ()
	"Vacía el directorio donde se guardan los archivos backups."
  (interactive)
  (dolist (f (directory-files cg-var-backups t "!.*" t))
	(delete-file f))
  (message "Vaciado el directorio %s" cg-var-backups))

(defun cg-poner-menor (modo)
  "Activa el modo sin que salga el nombre en la «mode line»."
  (funcall modo)
  (setf (cdr (assoc modo minor-mode-alist)) '(nil)))

(defun cg-esp-nom-buff ()
  "Cambia el nombre del buffer actual añadiendo un espacio al inicio."
  (let ((n (buffer-name)))
	(when (not (string-prefix-p " " n))
	  (rename-buffer (concat " " n)))))

(defmacro cg-quitar-nombre-minor-mode (&rest modos)
  `(dolist (n (quote ,modos))
	 (setf (cdr (assoc (intern (concat n "-mode")) minor-mode-alist)) '(nil))))

;------------------------------------------------------------------------------------------

(defun cg-servidor ()
  "Abre un subproceso de fondo con un servidor web; el comando está en «variables»."
  (interactive)
  (cg-comando-fondo cg-var-servidor))

(provide 'funciones)
