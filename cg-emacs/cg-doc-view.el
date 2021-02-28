;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo docView
;------------------------------------------------------------------

(defun cg-doc-view ()
  "Pone los keybinding para las funciones, en la tabla local del modo mayor de doc-view."
  (poner-keys '(("C-0" . doc-view-fit-height-to-window)
				("C-=" . doc-view-fit-width-to-window)
				("C-M-0" . doc-view-fit-page-to-window)
				("M-p" . doc-view-first-page)
				("M-n" . doc-view-last-page))))

(remove-hook 'doc-view-mode-hook 'cg-doc-view)
