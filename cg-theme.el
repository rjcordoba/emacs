;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Aspecto de la pantalla
;------------------------------------------------------------------

(deftheme cg "Cambios personales de colores")

(custom-theme-set-faces
 'cg
 '(default ((t (:foreground "WhiteSmoke" :background  "#242424" :height 106))))
 '(mode-line ((t (:foreground "#E5D3D3" :background "#010111" :overline "#010111" :font "Courier 15" :box nil))))
 '(mode-line-inactive ((t (:inherit mode-line :foreground "#555" :background "#2E2E2E" :overline nil))))
 '(mode-line-buffer-id ((t (:foreground "#F1C757"))))
 '(region ((t (:background "#748288" :foreground "#FFF"))))
 '(highlight ((t (:background "#0360AD"))))
 '(lazy-highlight ((t (:foreground "#FDF6D8" :background "#A09CF4"))))
 '(isearch ((t (:background "#32804D" :foreground "#FFF"))))
 '(vertical-border ((t (:foreground "#111"))))
 '(fringe ((t (:background "#333"))))
 '(trailing-whitespace ((t (:background "#FC2F63" :foreground "#FFF"))))
 '(escape-glyph ((t (:background "#E57f02" :foreground "#FFF"))))
 '(minibuffer-prompt ((t (:foreground "#02E290"))))
 '(cursor ((t (:background "AntiqueWhite4"))))

 '(comint-highlight-prompt ((t (:foreground "#02E290" :weight semi-bold))))
 '(eshell-prompt ((t (:foreground "#02E290" :weight semi-bold))))

 '(line-number ((t (:foreground "#607c93" :background "#272727"))))
 '(line-number-current-line ((t (:foreground "#becfd6"))))

 '(font-lock-constant-face ((t (:foreground "#F1A6FC"))))
 '(font-lock-comment-face ((t (:foreground "#AAA"))))
 '(font-lock-doc-face ((t (:foreground "#2bb52b"))))
 '(company-preview-common ((t (:foreground "#f4cdcd"))))
 '(company-scrollbar-bg ((t (:background "#30323A"))))
 '(company-scrollbar-fg ((t (:background "#484859"))))
 '(company-tooltip ((t (:background "#282930" :foreground "#CEFFF7"))))
 '(company-tooltip-annotation ((t (:foreground "#bac2c1"))))
 '(company-tooltip-annotation-selection ((t (:foreground "#edfcf9"))))
 '(company-tooltip-selection ((t (:foreground "#f7f79b" :background "#525466"))))
 '(company-tooltip-common-selection ((t (:foreground "#b1d6ce"))));
 '(company-tooltip-common ((t (:foreground "#c86067")))))

(provide-theme 'cg)
