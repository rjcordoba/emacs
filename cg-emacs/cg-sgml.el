;------------------------------------------------------------------
;  Archivo de configuración de Emacs - R. Córdoba García
;  Utilidades para el modo HTML
;------------------------------------------------------------------

(require 'func-etiquetas)

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

(cg-configs-modo
 :tabla t
 :hook (λ (setq tab-width 2) (emmet-mode))
 :poner
 (("C-c h" . seleccionar-tag)
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
