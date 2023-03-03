;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para lsp
;------------------------------------------------------------------

(setq gc-cons-threshold					 100000000
	  lsp-completion-provider			 :capf
	  lsp-ui-doc-position				 'at-point
	  read-process-output-max			 (* 1024 1024)
	  company-format-margin-function	 #'company-vscode-light-icons-margin)

(lsp-treemacs-sync-mode 1)
;; (lsp-toggle-symbol-highlight)

;cg-ignorar-lsp está en «variables»; indica los directorios a ignorar.
(dolist (d cg-var-ignorar-lsp) (push d lsp-file-watch-ignored-directories))

(define-key lsp-mode-map (kbd "¢") lsp-command-map)

(cg-configs-modo
 :tabla lsp-command-map
 :poner (("z" . lsp-find-declaration)
		 ("x" . lsp-find-reference)
		 ("c" . lsp-find-definition)
		 ("C" . lsp-ui-peek-find-definitions)
		 ("d" . lsp-ui-doc-mode)
		 ("f" . lsp-ui-doc-focus-frame)
		 ("F" . lsp-ui-doc-unfocus-frame)
		 ("v" . lsp-ui-doc-toggle)
		 ("f" . lsp-ivy-workspace-symbol)
		 ("d" . (λ (setq lsp-ui-doc-show-with-cursor (not lsp-ui-doc-show-with-cursor))))
		 ("." . lsp-ui-doc-focus-frame)))
