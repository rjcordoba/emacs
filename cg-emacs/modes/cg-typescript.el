;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo Typescript
;------------------------------------------------------------------
(setq ts-comando-comp "tsc %s --target \"ES6\" --outDir \"../js\" --removeComments")
(cg-configs-modo
 :tabla t
 :hook #'tree-sitter-hl-mode
 :poner
 (("C-c s" . cg-servidor)
  ("<C-f5>" . (λ (cg-shell-comando "tsc")))
  ("<f5>" . (λ (cg-shell-comando (format ts-comando-comp buffer-file-name) default-directory)))))
