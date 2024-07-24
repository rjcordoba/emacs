;------------------------------------------------------------------
;  Archivo de configuración de Emacs - R. Córdoba García
;  Utilidades para el modo Web
;------------------------------------------------------------------

(require 'func-etiquetas)
(require 'func-php)

(setq web-mode-engines-alist
      '(("php" . "\\.phtml\\'")))

(add-to-list 'hs-special-modes-alist
             '(web-mode
               "<[^/>]*>"
               "</[^/>]*>"
               "<!--"
               sgml-skip-tag-forward
               nil))

(cg-configs-modo
 :tabla t
 :hook (λ
		(setq web-mode-markup-indent-offset 2)
		(emmet-mode)
		(hs-minor-mode 1))
 :quitar ("M-;")
 :poner
 (("C-c ;" . web-mode-comment-or-uncomment)
  ("C-c h" . seleccionar-tag)
  ("C-c r" . renom-etiqueta)
  ("C-c C-c d" . lista-dl)
  ("C-c l" . poner-atributo)
  ("C-c ñ" . poner-clase)
  ("C-c i" . poner-tag)
  ("C-c j" . poner-entre-tag)
  ("M-k" . (λ (search-backward "<")))
  ("M-l" . (λ (search-forward ">")))
  ("C-c e" . plantilla-html)
  ("C-c p" . poner-php)
  ("C-c -" . (λ (insert "->")))
  ("C-c _" . (λ (insert "=>")))
  ("C-c =" . php-echo)
  ("C-c s" . cg-servidor)))
