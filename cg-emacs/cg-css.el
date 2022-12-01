;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para CSS
;------------------------------------------------------------------

(cg-configs-modo
 :poner (("C-c s" . cg-servidor)
		 ("C-c C-c" . (λ (comentar/descomentar-bloque "/\* " " \*/" "// ")))))
