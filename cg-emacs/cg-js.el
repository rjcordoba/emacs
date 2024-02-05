;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo Javascript
;------------------------------------------------------------------

(cg-configs-modo
 :quitar ("M-.")
 :hook (λ (show-paren-mode -1) (tree-sitter-hl-mode))
 :poner (("C-c s" . cg-servidor)
		 ("C-c C-c" . (λ (comentar/descomentar-bloque "/\*" "\*/" "//")))))
