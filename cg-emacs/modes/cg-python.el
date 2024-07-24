;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo Python
;------------------------------------------------------------------

(require 'lsp-pyright)

(defun cg-send-region ()
  (unless (use-region-p)
	(seleccionar-línea 1))
  (python-shell-send-region (region-beginning) (region-end)))

(cg-configs-modo
 :tabla t
 :poner (("C-c s" . (λ (insert (make-string 6 ?\")) (backward-char 3)))
		 ("<f5>" . (λ (let ((default-directory (cg-project-root)))
						(compile "python3 main.py" t))))
		 ("<S-f5>" . (compile (concat "python3 " buffer-file-name) t))
		 ("<f6>" . cg-send-region)
		 ("S-<f6>" . python-shell-send-buffer)
		 ("C-<f1>" . run-python))
 :hook (λ (lsp)))
