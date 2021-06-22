;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Configuraciones para el modo elisp.
;------------------------------------------------------------------
(cg-configs-modo
 :poner (("C-c p" . show-paren-mode)
		 ("C-c j" . backward-sexp)
		 ("C-c ñ" . forward-sexp)
		 ("C-c k" . (λ (search-backward "(")))
		 ("C-c l" . (λ (search-forward ")")))
 		 ("C-c f" . find-function-at-point)
		 ("C-c v" . find-variable-at-point)))
