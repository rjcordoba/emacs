;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo Picture
;------------------------------------------------------------------

(defun cg-picture ()
  "Pone los keybinding para las funciones, en la tabla local del modo mayor."
  (interactive)
  (poner-keys '(("C-ñ" . picture-forward-column)
				("C-j" . picture-backward-column)
				("C-l" . picture-move-down)
				("C-k" . picture-move-up)
				("C-M-ñ" . picture-end-of-line)
				("C-M-j" . picture-beginning-of-line)
				("C-J" . picture-backward-clear-column)
				("C-Ñ" . picture-clear-column)
				("C-M-S-l" . picture-clear-line)
				("C-M-k" . picture-duplicate-line)
				("M-l" . picture-motion)
				("M-k" . picture-motion-reverse)
				("C-c j" . picture-movement-left)
				("C-c ñ" . picture-movement-right)
				("C-c k" . picture-movement-up)
				("C-c l" . picture-movement-down)
				("C-c i" . picture-movement-nw)
				("C-c o" . picture-movement-ne)
				("C-c ," . picture-movement-sw)
				("C-c ." . picture-movement-se)
				("C-p" . picture-clear-rectangle)
				("M-p" . picture-clear-rectangle-to-register)
				("C-P" . picture-yank-rectangle)
				("M-S-p" . picture-yank-rectangle-from-register))))

(remove-hook 'picture-mode-hook 'cg-html)
