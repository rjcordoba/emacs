 ;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo Emmet
;------------------------------------------------------------------

(cg-configs-modo
 :tabla emmet-mode-keymap
 :quitar ("C-j" "<C-return>" "C-c C-c")
 :poner
 (("C-c m" . emmet-expand-line)
  ("C-c w" . emmet-wrap-with-markup)
  ("C-c C-k" . emmet-prev-edit-point)
  ("C-c C-l" . emmet-next-edit-point)))
