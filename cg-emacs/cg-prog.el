;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo prog
;------------------------------------------------------------------

(cg-configs-modo
 :tabla t
 :poner
 (("C-c +" . hs-toggle-hiding)
  ("C-c C-+" . hs-show-all)
  ("C-c C-*" . hs-hide-all)
  ("C-c M-+" . hs-hide-level))
 :hook
 (lambda ()
   (unless (eq major-mode 'emacs-lisp-mode) (lsp))
   (cg-poner-menor 'hs-minor-mode)))
