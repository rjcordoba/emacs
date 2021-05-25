(setq treemacs-width                 55
	  treemacs-is-never-other-window t)

(treemacs-create-icon :file "twig.png" :fallback "html.png" :extensions ("twig"))

(cg-configs-modo
 :poner (("C-f" . treemacs-find-file)
 		 ("C-t" . treemacs-find-tag)
 		 ("C-b" . treemacs-bookmark)
		 ("C-c C-<" . treemacs-run-shell-command-for-current-node)
 		 ("C-c M-<" . treemacs-run-shell-command-in-project-root)))
