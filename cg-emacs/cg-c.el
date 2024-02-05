;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para C
;------------------------------------------------------------------

(cg-configs-modo
 :tabla t
 :hook (λ (show-paren-mode -1))
 :poner ("C-c C-c" . (λ (comentar/descomentar-bloque "/\*" "\*/" "//"))))
