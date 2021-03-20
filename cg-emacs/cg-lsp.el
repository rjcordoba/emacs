(setq gc-cons-threshold			   100000000
	  ;; company-idle-delay		   0.2
	  lsp-completion-provider 	   :capf
	  lsp-ui-doc-enable 		   nil
	  read-process-output-max	   (* 1024 1024))

(lsp-treemacs-sync-mode 1)
(lsp-toggle-symbol-highlight)

(dolist (d cg-ignorar-lsp) (push d lsp-file-watch-ignored-directories))

(define-key lsp-mode-map (kbd "¢") lsp-command-map)

(cg-configs-modo
 :tabla lsp-command-map
 :poner (("c" . lsp-find-definition)
		 ("x" . lsp-find-reference)
		 ("z" . lsp-find-declaration)
		 ("v" . lsp-ui-doc-mode)
		 ("f" . lsp-ivy-workspace-symbol)
		 ("." . lsp-ui-doc-focus-frame)))
