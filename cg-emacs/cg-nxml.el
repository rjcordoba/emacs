;------------------------------------------------------------------
;  Archivo de configuración de Emacs - R. Córdoba García
;  Utilidades para el modo nXML
;------------------------------------------------------------------

(require 'func-etiquetas)
(require 'web-mode)

(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "<[^/>]*>"
               "</[^/>]*>"
               "<!--"
               sgml-skip-tag-forward
               nil))

(defun plantilla-xml ()
  "Mete la plantilla de inicio."
  (interactive)
  (insert "<?xml version=\"1.0\"?>\n"))

(cg-configs-modo
 :tabla t
 :hook (λ
		(setq tab-width 2 nxml-child-indent 2)
		(emmet-mode)
		(lsp)
		(hs-minor-mode 1))
 :poner
 (("C-c h" . seleccionar-tag)
  ("C-c DEL" . sgml-delete-tag)
  ("C-c r" . renom-etiqueta)
  ("C-c l" . poner-atributo)
  ("C-c i" . poner-tag)
  ("C-c j" . poner-entre-tag)
  ("M-k" . (λ (search-backward "<")))
  ("M-l" . (λ (search-forward ">")))
  ("C-c e" . plantilla-xml)
  ("C-c C-c" . (λ (comentar/descomentar-bloque "<!-- " " -->")))
  ("C-c C-w" . (lookup-key web-mode-map (kbd "C-c")))))
