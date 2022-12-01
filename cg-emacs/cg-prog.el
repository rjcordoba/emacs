;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo prog
;------------------------------------------------------------------

(defvar modos-sin-lsp
  '(emacs-lisp-mode web-mode)
  "Modos donde no se pondrá servidor de lenguaje.")

(cg-configs-modo
 :tabla t
 :poner
 (("C-c +" . hs-toggle-hiding)
  ("C-c C-+" . hs-show-all)
  ("C-c C-*" . hs-hide-all)
  ("C-c M-+" . hs-hide-level)
  ("M-l" . forward-list)
  ("M-k" . backward-list))
 :hook
 (lambda ()
   (unless (member major-mode modos-sin-lsp) (lsp))
   (cg-poner-menor 'hs-minor-mode)))
