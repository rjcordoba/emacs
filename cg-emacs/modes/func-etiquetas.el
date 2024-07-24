;------------------------------------------------------------------
;  Archivo de configuración de Emacs - R. Córdoba García
;  Funciones para usar en modos de etiquetas.
;------------------------------------------------------------------

(defun a-apertura-html ()
  "Pone el cursor a la izquierda de la etiqueta de apertura."
  (skip-chars-backward "^<")
  (if (eq (char-after) ?/)
	  (sgml-skip-tag-backward 1)
	(backward-char)))

(defun seleccionar-tag (&optional n)
  "Selecciona la etiqueta donde está el puntero, y su contenido,
tanto si es la etiqueta de inicio como la de cierre. Con argumento
selecciona sólo el contenido."
  (interactive "P")
  (a-apertura-html)
  (push-mark nil t t)
  (sgml-skip-tag-forward 1)
  (when n
	(search-backward "<")
	(exchange-point-and-mark)
	(search-forward ">")))

(defun renom-etiqueta (nombre)
  "Cambia el nombre de las etiquetas de apertura y cierre que
estén bajo el puntero o la primera a la izquierda de él."
  (interactive "sNuevo nombre: ")
  (a-apertura-html)
  (let ((aper (point)))
	(sgml-skip-tag-forward 1)
	(backward-char)
	(backward-kill-word 1)
	(insert nombre)
	(goto-char aper))
  (forward-char)
  (kill-word 1)
  (insert nombre)
  (search-forward ">"))

(defun poner-atributo (atrib nombre)
  "Pone un atributo a elegir en la etiqueta."
  (interactive (list (read-string "Qué atributo («id» por defecto): " nil nil "id")
					 (read-string "Valor del atributo: ")))
  (a-apertura-html)
  (re-search-forward (concat atrib "\\|>"))
  (backward-char)
  (if (eq (char-after) ?>)
	  (insert " " atrib  "=\"" nombre  ?\")
	(re-search-forward "\"\\|'")
	(sel-en-pareja t)
	(delete-region (mark) (point))
	(insert nombre))
  (search-forward ">"))

(defun poner-tag (n)
  "Toma la palabra en el point o delante de él, la transforma en etiqueta y la cierra.
Con argumento pregunta qué etiqueta poner."
  (interactive "P")
  (backward-word)
  (insert "<")
  (let ((p (current-word t t)))
	(forward-word)
	(insert (con-atributo n))	
	(insert "></" p ">")
	(search-backward "<")))

(defun con-atributo (n)
  "Función auxiliar para insertar atributo en etiqueta."
  (if n
	(concat " "
			(read-string " Qué atributo («class» por defecto): " nil nil "class")
			"=\""
			(read-string " Valor del atributo: ")
			"\"")
	""))

(defun poner-entre-tag (n)
  "Envuelve el texto seleccionado entre etiqueta de apertura y cierre.
Si no hay nada seleccionado simplemente introduce las etiquetas. Con argumento
pregunta el atributo a añadir."
  (interactive "p")
  (unless (region-active-p)
	(set-mark (point)))
  (let ((tag (read-string "Qué etiqueta («span» por defecto): " nil nil "span"))
		(i (region-beginning))
		(f (region-end)))
	(goto-char f)
	(insert "</" tag ">")
	(goto-char i)
	(insert "<" tag (con-atributo n) ">")))

(defun poner-clase (nombre)
  "Pone una clase en la etiqueta."
  (interactive "sNombre de la clase: ")
  (a-apertura-html)
  (re-search-forward "class\\|>")
  (backward-char)
  (if (eq (char-after) ?>)
	  (insert " class=\"" nombre "\"")
	(re-search-forward "\".*?\"")
	(backward-char)
	(unless (eq (char-before) ?\") (insert " "))
	(insert nombre))
  (search-forward ">"))

(defun lista-dl ()
  "Inserta una lista de definición."
  (interactive)
  (insert "<dl>\n<dt></dt>\n<dd></dd>\n</dl>")
  (seleccionar-tag)
  (indent-for-tab-command)
  (pop-mark)
  (search-backward "</dt"))

(defun plantilla-html ()
  "Mete la plantilla de inicio."
  (interactive)
  (insert-file-contents (directorio-cg "plantillas/web.html") nil nil nil t))

(provide 'func-etiquetas)
