;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo HTML
;------------------------------------------------------------------

(defun con-atributo (n)
  "Función auxiliar para insertar atributo en etiqueta."
  (if (> n 1)
	  (concat " " (read-string " Qué atributo («class» por defecto): " nil nil "class") "=\"" (read-string " Nombre del atributo: ") "\"") ""))

(defun cerrar-etiquetas ()
  "Cerrar la etiqueta donde está el point y dejar éste enmedio."
  (interactive)
  (while (progn (skip-chars-backward "^<")
				(if (eq (char-after) ?/) (or (backward-char 2) t) nil)))
  (let ((pal (current-word t t)))
	(skip-chars-forward "^<\n")
    (insert "</" pal ?>)(backward-word)(backward-char 2)))

(defun a-apertura-html ()
  "Pone el cursor a la izquiera de la etiqueta de apertura."
  (skip-chars-backward "^<")
  (if (eq (char-after) ?/) (sgml-skip-tag-backward 1) (backward-char)))

(defun seleccionar-tag (&optional n)
  "Selecciona la etiqueta donde está el puntero, y su contenido, tanto si es la etiqueta de inicio como la de cierre.
   Con argumento selecciona sólo el contenido."
  (interactive "p")
  (a-apertura-html)
  (push-mark nil t t)
  (sgml-skip-tag-forward 1)
  (unless (= n 1) (search-backward "<") (exchange-point-and-mark) (search-forward ">")))

(defun renom-etiqueta ()
  "Cambia el nombre de las etiquetas de apertura y cierre que estén bajo el puntero o la primera a la izquierda de él."
  (interactive)
  (a-apertura-html)
  (let ((aper (point))
		(nombre (read-string " Nuevo nombre: ")))
	(sgml-skip-tag-forward 1) (backward-char) (backward-kill-word 1) (insert nombre)
	(goto-char aper) (forward-char) (kill-word 1) (insert nombre)))

(defun poner-clase ()
  "Pone una clase en la etiqueta."
  (interactive)
  (a-apertura-html)
  (re-search-forward "class\\|>")
  (backward-char)
  (let ((nombre (read-string " Nombre de la clase: ")))
	(if (eq (char-after) ?>)
		(insert " class=\"" nombre "\"")
	  (re-search-forward "\".*?\"") (backward-char) (unless (eq (char-before) ?\") (insert " ")) (insert nombre)))
  (search-forward ">"))

(defun poner-atributo ()
  "Pone un atributo a elegir en la etiqueta."
  (interactive)
  (a-apertura-html)
  (let ((atrib (read-string " Qué atributo («id» por defecto): " nil nil "id"))
		(nomb (read-string " Nombre del atributo: ")))
	  (re-search-forward (concat atrib "\\|>")) (backward-char)
	(if (eq (char-after) ?>)
		(insert " " atrib  "=\"" nomb  ?\")
	  (search-forward "\"") (kill-word 1) (insert nomb)))
	  (search-forward ">"))

(defun lista-dl ()
  "Inserta una lista de definición."
  (interactive)
  (insert "<dl>\n<dt></dt>\n<dd></dd>\n</dl>")
  (seleccionar-tag)
  (indent-for-tab-command)
  (pop-mark)
  (search-backward "</dt"))

(defun poner-tag (&optional n)
  "Toma la última palabra o la palabra seleccionada, la transforma en etiqueta y la cierra."
  (interactive "p")
  (unless (use-region-p) (set-mark (point)) (backward-word))
  (kill-region t t t)
  (insert "<") (yank) (insert (con-atributo n))
  (insert "></") (yank) (insert ">") (backward-word) (backward-char 2)
  (pop kill-ring) (pop-mark) (pop-mark))

(defun poner-entre-tag (&optional n)
  (interactive "p")
  (unless (region-active-p) (set-mark (point)))
  (let ((tag (read-string " Qué etiqueta («span» por defecto): " nil nil "span"))
		(i (region-beginning))
		(f (region-end)))
	(goto-char f) (insert "</" tag ">")
	(goto-char i) (insert "<" tag (con-atributo n) ">")))

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
  ("C-c e" . plantilla-html)))
