;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo Python
;------------------------------------------------------------------

(require 'lsp-pyright)

(defun cg-compile-python (n)
  (interactive "P")
  (if n
	  (compile (concat "python3 " buffer-file-name) t)
	(let ((default-directory (cg-project-root)))
	  (compile "python3 main.py" t))))

(cg-configs-modo
 :tabla t
 :poner (("C-c C-s" . (λ (insert (make-string 6 ?\")) (backward-char 3)))
		 ("<f5>" . cg-compile-python)
		 ("S-<f5>" . python-shell-send-buffer)
		 ("C-<f1>" . run-python))
 :hook (λ (lsp)))
