;------------------------------------------------------------------
;	 Archivo de configuración de Emacs - R. Córdoba García
;------------------------------------------------------------------

(require 'comandos)

;Tabla para poner kbindings con <menu> de prefijo.
(global-set-key (kbd "<menu>") (make-sparse-keymap))

(dolist (e `(

;Comentarios.
("C-c c" . comment-line)	("C-c x" . comment-dwim)    ("C-c C" . comment-kill)

;Org
("C-c M-s" . org-store-link)	("C-c M-a" . org-agenda)    ("C-c M-c" . org-capture)

;Modos
("<C-insert>" . picture-mode)	  ("<M-S-insert>" . auto-revert-mode)	 ("<M-insert>" . whitespace-mode)
("<C-S-insert>" . artist-mode)	  ("<C-M-insert>" . hl-line-mode)		 ("<C-M-S-insert>" . fundamental-mode)

;Fill.
("C-M-S-q" . set-fill-column)	 ("C-M-q" . auto-fill-mode)	   ("Ω" . paragraph-indent-minor-mode)
("C-@" . center-line)			 ("C-S-q" . fill-region)	   ("C-Ω" . fill-region-as-paragraph)

;Macros.
("C-+" . kmacro-set-counter)	  ("M-]" . kmacro-edit-lossage)			("C-M-*" . kmacro-delete-ring-head)
("C-M-]" . kbd-macro-query)		  ("<C-S-f4>" . kmacro-bind-to-key)		("<C-f3>" . kmacro-cycle-ring-next)
("M-*" . kmacro-set-format)		  ("C-*" . kmacro-add-counter)			("<C-S-f3>" . kmacro-cycle-ring-previous)
("C-]" . kmacro-edit-macro)		  ("C-M-+" . kmacro-step-edit-macro)	("<C-f4>" . apply-macro-to-region-lines)
("M-+" . kmacro-insert-counter)	  ;;F4->kmacro-end-or-call-macro		F3->kmacro-start-macro-or-insert-counter

;Copiar/Pegar
("C-z" . kill-ring-save)	("C-S-z" . kill-region)	   ("M-z" . yank)

;Deshacer.
("<C-backspace>" . undo)			("<M-backspace>" . revert-buffer)		 ("<C-M-S-backspace>" . recover-file)
("<C-M-backspace>" . normal-mode)	("<M-S-backspace>" . volver-a-backup)	 ("<C-S-backspace>" . ,(λ (undo 4)))

;Comandos.
("M-<" . eval-expression)	 ("M->" . repeat-complex-command)	 ("C-M-<" . async-shell-command);project-async-shell-command
("C->" . shell-command)		 ("C-<" . shell-command-on-region)	 ("C-|" . cg-comando-proyecto);project-shell-command

;Edición recursiva.
("C-r" . recursive-edit)	("C-S-r" . exit-recursive-edit)
("C-®" . top-level)			("C-¶" . abort-recursive-edit)

;Ispell y dabbrev.
("æ" . dabbrev-expand)	  ("C-Æ" . ispell-buffer)	 ("C-S-a" . ispell-complete-word)
("Æ" . expand-abbrev)	  ("C-æ" . ispell-word)		 ("C-S-æ" . dabbrev-completion)

;Insertar/eliminar blancos.
("C-M-SPC" . insertar-espacios)		("C-M-S-SPC" . insertar-espacios-ad)	   ("<C-S-return>" . insertar-línea-encima-debajo)
("<C-tab>" . indent-relative)		("<C-iso-lefttab>" . alinear-tab-a)		   ("<C-M-return>" . electric-indent-just-newline)
("<M-return>" . open-line)			("<C-return>" . insertar-línea-debajo)	   ("<S-return>" . insertar-línea-encima)
("<C-M-tab>" . indent-region)		("S-SPC" . delete-horizontal-space)		   ("<M-S-return>" . abrir-línea-encima)
("C-x <C-tab>" . tabify)			("C-x C-S-<iso-lefttab>" . untabify)

;Búsquedas
("C-<dead-acute>" . isearch-forward)			("C-M-<dead-diaeresis>" . isearch-backward-regexp)
("C-S-<dead-diaeresis>" . isearch-backward)		("C-M-<dead-acute>" . isearch-forward-regexp)
("M-<dead-acute>" . isearch-forward-word)		("C-{" . isearch-backward-symbol-at-point)
("M-<dead-diaeresis>" . word-search-backward)	("C-}" . isearch-forward-symbol-at-point)

;Find y grep con Dired
("C-x C-M-<dead-acute>" . find-dired)		 ("C-x C-M-S-<dead-diaeresis>" . counsel-git-grep)
("C-x ´" . grep-buscar-string)				 ("C-x C-<dead-grave>" . rgrep)
("C-x M-<dead-acute>" . find-name-dired)	 ("C-x C-<dead-acute>" . find-grep-dired)
("C-x M-<dead-acute>" . find-name-dired)

;Búsquedas con sustitución.
("C-<dead-grave>" . query-replace)			 ("M-<dead-circumflex>" . replace-regexp)
("C-<dead-circumflex>" . replace-string)	 ("M-<dead-grave>" . query-replace-regexp)

;Abrir ventanas con distintos buffers y modos. Otras funciones con menú.
("<menu> d" . abrir-Dired)		("<menu> G" . cerrar-dired)			("<menu> n" . display-line-numbers-mode)
("<menu> D" . abrir-Dired)		("<menu> f" . poner-follow)			("<menu> t" . treemacs-select-window)
("<menu> b" . abrir-Dired)		("<menu> w" . speedbar)				("<menu> l" . global-tab-line-mode)
("<menu> T" . treemacs)			("<menu> <menu>" . abrir-shell)		("<menu> g" . cerrar-shell)

;Frames.
("<menu> z" . make-frame)	   ("<menu> đ" . other-frame);Altgr f
("<menu> Z" . delete-frame)	   ("<menu> ª" . suspend-frame);Altgr F

;Archivos.
("M-f" . insert-file)		 ("C-d" . dired-jump)				("C-ª" . find-file-other-frame);Altgr F
("C-f" . counsel-find-file)	 ("M-d" . counsel-dired)			("C-S-f" . find-file-other-window)
("C-s" . save-buffer)		 ("C-S-s" . save-some-buffers)		("C-đ" . find-file-read-only-other-window)
("C-ß" . write-file)		 ("ª" . set-visited-file-name)		("đ" . find-alternate-file)

;Buffers.
("M-B" . bury-buffer)		 ("C-M-b" . kill-current-buffer)		   ("M-”" . ,(λ (switch-to-prev-buffer nil t)))
("’" . next-buffer)			 ("C-M-S-b" . kill-buffer-and-window)	   ("C-x C-b" . ,(λ (byte-compile-file (buffer-file-name))))
("”" . previous-buffer)		 ("C-M-”" . rename-buffer)				   ("C-”" . ,(λ (otra-ventana #'previous-buffer (next-window))))
("M-b" . buffer-menu)		 ("C-b" . counsel-switch-buffer)		   ("C-’" . ,(λ (otra-ventana #'next-buffer (next-window))));Altgr B
("C-x b" . eval-buffer)		 ("C-S-b" . switch-to-buffer-other-window)

;Parejas.
("M-'" . parejas)	   ("M-¡" . parejas)	  ("C-M-'" . parejas)	  ("M-?" . parejas)
("C-'" . parejas)	   ("C-¿" . parejas)	  ("M-¿" . parejas)		  ("C-M-¡" . parejas)
("C-?" . parejas)	   ("C-¡" . parejas)	  ("C-M-?" . parejas)	  ("C-M-¿" . parejas)

;Ventanas.
("C-." . other-window)		  ("C-:" . ,(λ (other-window -1)))			("M-:" . ,(λ (select-window (split-window-below))))
("C-·" . cg-swap-buffers)	  ("C-M-." . delete-other-windows)			("<menu> Q" . ,(λ (quit-window nil (previous-window))))
("·" . ace-window)			  ("C-x C-." . sel-minibuffer)				("M-." . ,(λ (select-window (split-window-right))))
("C-M-:" . delete-window)	  ("<menu> q" . cerrar-ventana)				("C-M--" . balance-windows)
("M--" . enlarge-window)	  ("C-_" . shrink-window-horizontally)		("C-M-_" . shrink-window-if-larger-than-buffer)
("M-_" . shrink-window)		  ("C--" . enlarge-window-horizontally)		("<C-dead-belowdot>" . toggle-frame-fullscreen)

;Rectángulos.
("C-p" . rectangle-mark-mode)		   ("M-P" . kill-rectangle)				("C-S-p" . delete-whitespace-rectangle)
("C-M-o" . open-rectangle)			   ("M-O" . clear-rectangle)			("C-M-p" . rectangle-number-lines)
("M-o" . yank-rectangle)			   ("C-o" . string-insert-rectangle)	("C-M-S-p" . delete-trailing-whitespace)
("C-S-o" . string-rectangle)		   ("C-M-S-o" . delete-rectangle)		("C-x M-p" . mc/mark-next-like-this)
("C-x C-M-p" . escribir-fin-líneas)	   ("C-x o" . copy-rectangle-as-kill)	("C-x M-S-p" . mc/mark-previous-like-this)
("M-p" . mc/mark-pop)

;Transposiciones.
("ŧ" . mover-párrafo-abajo)		("C-Ŧ" . mover-línea-arriba)	 ("C-t" . transpose-chars)
("Ŧ" . mover-párrafo-arriba)	("C-ŧ" . mover-línea-abajo)		 ("C-S-T" . ,(λ (transpose-chars -1)))
("M-T" . mover-palabra-atrás)	("M-t" . mover-palabra-adlt)

;Seleccionar.
("M-H" . sel-en-pareja)			("C-h" . seleccionar-palabra)		("C-S-h" . exchange-point-and-mark)
("C-M-S-h" . sel-pareja)		("C-M-h" . seleccionar-línea)

;Registros.
("C-9" . point-to-register)		  ("C-M-9" . number-to-register)	   ;("C-x 9" . window-configuration-to-register)
("C-)" . jump-to-register)		  ("C-8" . append-to-register)		   ("M-(" . window-configuration-to-register)
("M-9" . copy-to-register)		  ("C-(" . prepend-to-register)		   ("M-8" . copy-rectangle-to-register)
("M-)" . insert-register)		  ("C-M-8" . kmacro-to-register)	   ("C-M-)" . increment-register)

;Bookmarks.
("M-Ç" . bookmark-rename)	 ("C-S-ç" . bookmark-jump)		  ("C-ç" . bookmark-set);-no-overwrite)
("C-M-ç" . bookmark-save)	 ("C-M-S-ç" . bookmark-delete)	  ("M-ç" . bookmark-bmenu-list)

;Mover el cursor izquierda-derecha / J-Ñ
("C-ñ" . forward-char)			 ("C-j" . backward-char)			  ("C-M-S-j" . ,(λ (kill-line 0)))
("C-Ñ" . delete-char)			 ("C-M-Ñ" . kill-line)				  ("C-M-S-k" . ,(λ (kill-whole-line 0)))
("M-ñ" . forward-word)			 ("M-j" . backward-word)			  ("C-x j" . ,(λ (forward-whitespace -1)))
("M-Ñ" . kill-word)				 ("M-J" . backward-kill-word)		  ("C-x ñ" . forward-whitespace)
("C-M-ñ" . move-end-of-line)	 ("C-M-j" . back-to-indentation)	  ("C-S-j" . backward-delete-char)

;Mover el cursor arriba-abajo / K-L
("C-l" . next-line)				 ("C-S-l" . ,(λ (forward-line 4)))		 ("C-&" . ,(λ (move-to-window-line-top-bottom -1)))
("C-k" . previous-line)			 ("C-S-k" . ,(λ (forward-line -4)))		 ("C-ĸ" . move-to-window-line-top-bottom)
("M-l" . forward-sentence)		 ("C-M-k" . ,(λ (forward-line -8)))		 ("C-x k" . ,(λ (recenter-top-bottom 4)))
("M-k" . backward-sentence)		 ("C-M-l" . ,(λ (forward-line 8)))		 ("C-M-ł" . ,(λ (kill-whole-line 0)))
("M-L" . forward-paragraph)		 ("C-M-S-l" . borrar-línea)				 ("ĸ" . beginning-of-buffer)
("M-K" . backward-paragraph)	 ("ł" . end-of-buffer)					 ("C-ł" . recenter-top-bottom)

;Hacer scroll.
("C-M-;" . scroll-down-command)		("M-," . ,(λ (scroll-up-command 4)))
("C-M-," . scroll-up-command)		("M-;" . ,(λ (scroll-down-command 4)))
("C-×" . ,(λ (scroll-right 2)))		("C-v" . ,(λ (scroll-other-window 3)))
("C-─" . ,(λ (scroll-left 2)))		("C-V" . ,(λ (scroll-other-window-down 3)))
("C-;" . scroll-down-line)			("C-“" . ,(λ (otra-ventana '(scroll-down-command 3) (previous-window))))
("C-," . scroll-up-line)			("C-‘" . ,(λ (otra-ventana '(scroll-up-command 3) (previous-window))))

;Avy
("M-m" . avy-goto-char-timer)		("M-M" . avy-goto-line)
("M-µ" . avy-goto-char-2)			("M-º" . avy-goto-word-1)

;Case conversion
("M-U" . downcase-word)			  ("C-x M-u" . upcase-region)
("C-M-u" . capitalize-word)		  ("C-x M-U" . downcase-region)
("C-x C-M-u" . capitalize-region)

;Miscelánea
("<menu> m" . magit-status)		 ("C-x ¨" . counsel-git-grep)
("C-x {" . electric-pair-mode)	 ("C-→" . lorem-ipsum-cg) ;C-AltGr-i
("<menu> k" . ,(λ (find-file (directorio-cg "keybindings.el"))))
))
(global-set-key (kbd (car e)) (cdr e)))
