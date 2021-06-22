;; (setq treemacs-is-never-other-window t)

(treemacs-create-icon :file "twig.png" :fallback "html.png" :extensions ("twig"))

(cg-configs-modo
 :quitar ("C-k")
 :poner (("C-f" . treemacs-find-file)
 		 ("C-t" . treemacs-find-tag)
 		 ("C-b" . treemacs-bookmark)
		 ("C-c k" . treemacs-previous-project)
		 ("C-c C-<" . treemacs-run-shell-command-for-current-node)
 		 ("C-c M-<" . treemacs-run-shell-command-in-project-root)))
