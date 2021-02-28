;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo iBuffer
;------------------------------------------------------------------

(defun cg-ibuffer ()
  "Pone los keybinding para las funciones, en la tabla local del modo mayor."
  (interactive)
  (poner-keys'(("<f5>" 'ibuffer-update))))

(remove-hook 'ibuffer-mode-hook 'cg-ibuffer)
