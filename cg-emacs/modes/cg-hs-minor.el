;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo Hideshow
;------------------------------------------------------------------

(cg-configs-modo
 :tabla t
 :poner
 (("C-c +" . hs-toggle-hiding)
  ("C-c C-+" . hs-show-all)
  ("C-c C-*" . hs-hide-all)
  ("C-c C-M-+" . hs-show-block)
  ("C-c C-M-*" . hs-hide-block)
  ("C-c M-+" . hs-hide-level)))

