;------------------------------------------------------------------
;  Archivo de configuración de Emacs - R. Córdoba García
;  Utilidades para el modo HTML
;------------------------------------------------------------------

(require 'func-etiquetas)
(require 'web-mode)

(cg-configs-modo
 :tabla t
 :hook (λ (setq tab-width 2) (emmet-mode))
 :poner
 (("C-c h" . seleccionar-tag)
  ("C-c r" . renom-etiqueta)
  ("C-c C-c d" . lista-dl)
  ("C-c l" . poner-atributo)
  ("C-c ñ" . poner-clase)
  ("C-c i" . poner-tag)
  ("C-c j" . poner-entre-tag)
  ("M-k" . (λ (search-backward "<")))
  ("M-l" . (λ (search-forward ">")))
  ("C-c e" . plantilla-html)
  ("C-c s" . cg-servidor)
  ("C-c C-c" . (λ (comentar/descomentar-bloque "<!-- " " -->")))
  ("C-c C-w" . (lookup-key web-mode-map (kbd "C-c")))))
