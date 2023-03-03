;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo Twig
;------------------------------------------------------------------

;; (add-to-list 'lsp-language-id-configuration '(twig-mode . "html"))

(defun cg-twig-code ()
  (interactive)
  (insert "{%  %}")
  (backward-char 3))

(defun cg-twig-etiqueta (s)
  "Pide nombre e inserta una etiqueta twig con ese nombre."
  (interactive "sNombre de la etiqueta: ")
  (insert (format "{%% %s %%}" s))
  (let ((p (point)))
	(insert "{% end" s " %}")
	(goto-char p)))

(defun cg-twig-block (s)
  "Pide nombre e inserta una etiqueta bloque con ese nombre."
  (interactive "sNombre del bloque: ")
  (insert (format "{%% block %s %%}{%% endblock %%}" s))
  (backward-char 14))

(cg-configs-modo
 :tabla t
 :quitar ("C-c c")
 :poner(("C-c d" . cg-twig-code)
		  ("C-c t" . cg-twig-etiqueta)
		  ("C-c b" . cg-twig-block)))
