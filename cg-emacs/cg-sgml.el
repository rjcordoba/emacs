;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo HTML
;------------------------------------------------------------------

(defun cerrar-etiquetas ()
  "Cerrar la etiqueta donde está el point y dejar éste enmedio."
  (interactive)
  (while
	  (progn
		(skip-chars-backward "^<")
		(if (eq (char-after) ?/)
			(or (backward-char 2) t)
		  nil)))
  (let ((pal (current-word t t)))
	(skip-chars-forward "^<\n")
    (insert "</" pal ?>)
	(search-backward "<")))

(defun a-apertura-html ()
  "Pone el cursor a la izquiera de la etiqueta de apertura."
  (skip-chars-backward "^<")
  (if (eq (char-after) ?/)
	  (sgml-skip-tag-backward 1)
	(backward-char)))

(defun seleccionar-tag (&optional n)
  "Selecciona la etiqueta donde está el puntero, y su contenido, tanto si es la etiqueta de inicio como la de cierre.
   Con argumento selecciona sólo el contenido."
  (interactive "P")
  (a-apertura-html)
  (push-mark nil t t)
  (sgml-skip-tag-forward 1)
  (when n
	(search-backward "<")
	(exchange-point-and-mark)
	(search-forward ">")))

(defun renom-etiqueta (nombre)
  "Cambia el nombre de las etiquetas de apertura y cierre que estén bajo el puntero o la primera a la izquierda de él."
  (interactive "sNuevo nombre: ")
  (a-apertura-html)
  (let ((aper (point)))
	(sgml-skip-tag-forward 1)
	(backward-char)
	(backward-kill-word 1)
	(insert nombre)
	(goto-char aper)
	(forward-char)
	(kill-word 1)
	(insert nombre)))

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

(defun poner-atributo (atrib nombre)
  "Pone un atributo a elegir en la etiqueta."
  (interactive (list (read-string "Qué atributo («id» por defecto): " nil nil "id")
					 (read-string "Nombre del atributo: ")))
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

(defun lista-dl ()
  "Inserta una lista de definición."
  (interactive)
  (insert "<dl>\n<dt></dt>\n<dd></dd>\n</dl>")
  (seleccionar-tag)
  (indent-for-tab-command)
  (pop-mark)
  (search-backward "</dt"))

(defun con-atributo (n)
  "Función auxiliar para insertar atributo en etiqueta."
  (if n
	(concat " "
			(read-string " Qué atributo («class» por defecto): " nil nil "class")
			"=\""
			(read-string " Nombre del atributo: ")
			"\"")
	""))

(defun poner-tag (n)
  "Toma la palabra en el point o tras él, la transforma en etiqueta y la cierra.
Con argumento pregunta qué etiqueta poner."
  (interactive "P")
  (forward-char)
  (backward-word)
  (insert "<")
  (let ((p (current-word)))
	(forward-word)
	(insert (con-atributo n))	
	(insert "></" p ">")
	(search-backward "<")))

(defun poner-entre-tag (n)
  "Envuelve el texto seleccionado entre etiqueta de apertura y cierre.
Si no hay nada seleccionado simplemente introduce las etiquetas. Con argumento
pregunta el atributo a añadir."
  (interactive "P")
  (unless (region-active-p)
	(set-mark (point)))
  (let ((tag (read-string " Qué etiqueta («span» por defecto): " nil nil "span"))
		(i (region-beginning))
		(f (region-end)))
	(goto-char f)
	(insert "</" tag ">")
	(goto-char i)
	(insert "<" tag (con-atributo n) ">")))

(defun plantilla-html ()
  "Mete la plantilla de inicio."
  (interactive)
  (insert-file-contents (directorio-cg "plantillas/web.html") nil nil nil t))

(cg-configs-modo
 :tabla t
 :poner
 (("C-c m" . cerrar-etiquetas)
  ("C-c h" . seleccionar-tag)
  ("C-c r" . renom-etiqueta)
  ("C-c C-c d" . lista-dl)
  ("C-c l" . poner-atributo)
  ("C-c ñ" . poner-clase)
  ("C-c i" . poner-tag)
  ("C-c j" . poner-entre-tag)
  ("M-k" . (λ (search-backward "<")))
  ("M-l" . (λ (search-forward ">")))
  ("C-c e" . plantilla-html)
  ("C-c s" . cg-servidor)))
