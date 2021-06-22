;------------------------------------------------------------------ -*- lexical-binding: t -*-
;    Archivo de configuración de Emacs - R. Córdoba García
;    Variables globales
;------------------------------------------------------------------

(defun comillas-o-string (v)
  "Pone comillas para que al escribir el antiguo valor en el minibuffer salga si la variable
tenía un valor string y así no tener que ponerlas al introducir el nuevo valor."
  (when v
	(if (stringp v)
		(concat "\"" (string-trim v) "\"")
	  (format "%s" v))))

(defun cg-cargar-var ()
  "Estando en el documento donde están las variables, carga los datos de la línea
donde esté situado el cursor."
  (interactive)
  (let ((p (point)))
	(move-beginning-of-line 1)
	(cg--cargar-var (current-buffer))
	(goto-char p)))

(let ((variables-completar '()) ; Valores de las variables para usar por la función «cambiar-variable» para el completado.
	  (arch-vars (directorio-cg "plantillas/variables.el")))

  (defun cg-borrar-variable ()
	"Elimina del archivo la variable que se elija interactivamente."
	(interactive)
	(with-temp-file arch-vars
	  (insert-file-contents arch-vars)
	  (let ((nv (completing-read "Nombre de la variable: " variables-completar)))
		(if (not (re-search-forward (format "^%s" nv) nil t))
			(message "La variable «%s» no está en el archivo." nv)
		  (kill-whole-line -1)
		  (makunbound (intern (concat "cg-var-" nv)))
		  (delete (intern nv) variables-completar)
		  (message "Se ha eliminado la variable %s." nv)))))
               
	(defun cg-cambiar-variable ()
	  "Pide el nombre de la variable y el nombre del nuevo valor; cambia la línea donde esté esa variable
en el archivo donde se guardan éstas, para que la siguiente vez en cargarse dé ese valor. Cambia también el
valor en la variable para la sesión actual."
	  (interactive)
	  (let* ((var (completing-read "Nombre de la variable: " variables-completar))
			 (v (intern (concat "cg-var-" var))))
		(with-temp-file arch-vars
		  (insert-file-contents arch-vars)
		  (when (or (re-search-forward (format "^%s" var) nil t)
					(when (y-or-n-p (format "La variable %s no existe. ¿Añadirla al archivo?" var))
					  (set v nil)
					  (goto-char (point-max))
					  (insert var)
					  t))
			(mark-sexp)
			(kill-region (point) (mark))
			(insert " "
					(comillas-o-string
					 (read-minibuffer (format "Valor para la variable «%s»: " var) (comillas-o-string (symbol-value v)))))		  
			(kill-region (point) (line-end-position))
			(let ((c (read-from-minibuffer (format "Comentario/Documentación para «%s»: " var)  (get v 'variable-documentation))))
			  (unless (= (length c) 0) (insert " ;" c)))
			(when (eobp) (open-line 1))
			(cg-cargar-var)
			(message "Línea afectada: %s" (buffer-substring (line-beginning-position) (line-end-position)))))))

  (defun cg--cargar-var (b)
	"Lee una línea y carga la variable con su valor y la documentación si le hubiere.
Deja el cursor al principio de la línea siguiente de donde están los datos que carga.
Recibe de parámetro el buffer del que leer."
	(let* ((p (read b))
		   (s (intern (concat "cg-var-" (symbol-name p)))))
	  (add-to-list 'variables-completar p)
	  (set s (read b))
	  (re-search-forward "[\s\t]*[;\n]")
	  (when (eq ?\; (char-before))
		(put s 'variable-documentation (buffer-substring (point) (line-end-position)))
		(forward-line))))

  (defun cg-cargar-variables ()
	"Carga todas las variables del archivo."
	(interactive)
	(with-temp-buffer
	  (insert-file-contents arch-vars)
	  (let ((b (current-buffer)))
		(while (not (eobp))
		  (cg--cargar-var b))))))

(cg-cargar-variables)
