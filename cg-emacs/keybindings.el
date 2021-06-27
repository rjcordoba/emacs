;------------------------------------------------------------------
;	 Archivo de configuración de Emacs - R. Córdoba García
;------------------------------------------------------------------

(require 'comandos)

;Tabla para poner keybindings con <menu> de prefijo.
(global-set-key (kbd "<menu>") (make-sparse-keymap))

(dolist (e `(

("C-→" . lorem-ipsum-cg) ;C-AltGr-i

;Comentarios.
("C-c c" . comment-line)	("C-c x" . comment-dwim)    ("C-c C" . comment-kill)

;Org
("C-c M-s" . org-store-link)	("C-c M-a" . org-agenda)    ("C-c M-c" . org-capture)

;Modos
("<C-insert>" . picture-mode)	  ("<M-S-insert>" . auto-revert-mode)	 ("<M-insert>" . whitespace-mode)
("<C-S-insert>" . artist-mode)	  ("<C-M-insert>" . hl-line-mode)		 ("<C-M-S-insert>" . fundamental-mode)

;Fill.
("C-M-S-q" . set-fill-column)	 ("C-M-q" . auto-fill-mode)	   ("Ω" . paragraph-indent-minor-mode)
("C-@" . center-line)			 ("C-S-q" . fill-paragraph)	   ("C-Ω" . fill-region-as-paragraph)

;Macros.
("C-+" . kmacro-set-counter)		   ("M-]" . kmacro-edit-lossage)		("C-*" . kmacro-add-counter)	
("C-M-+" . kmacro-step-edit-macro)	   ("<C-S-f4>" . kmacro-bind-to-key)	("<C-f3>" . kmacro-cycle-ring-next)
("C-M-*" . kmacro-delete-ring-head)	   ("M-+" . kmacro-insert-counter)		("<C-S-f3>" . kmacro-cycle-ring-previous) 
("C-]" . kmacro-edit-macro)			   ("C-M-]" . kbd-macro-query)			("<C-f4>" . apply-macro-to-region-lines)
("M-*" . kmacro-set-format)

;copiar/pegar
("C-z" . kill-ring-save)	("C-S-z" . kill-region)	   ("M-z" . yank)

;Deshacer.
("<C-backspace>" . undo)			("<M-backspace>" . revert-buffer)		 ("<C-M-S-backspace>" . recover-file)
("<C-M-backspace>" . normal-mode)	("<M-S-backspace>" . volver-a-backup)	 ("<C-S-backspace>" . ,(λ (undo 4)))

;Comandos.
("M-<" . eval-expression)	 ("M->" . repeat-complex-command)	 ("C-M-<" . async-shell-command)
("C->" . shell-command)		 ("C-<" . shell-command-on-region)

;Edición recursiva.
("C-r" . recursive-edit)	("C-S-r" . exit-recursive-edit)
("C-®" . top-level)			("C-¶" . abort-recursive-edit)

;Ispell.
("æ" . dabbrev-expand)	  ("C-Æ" . ispell-buffer)	 ("C-æ" . ispell-word)
("Æ" . expand-abbrev)	  ("C-S-a" . ispell-complete-word)

;Insertar/eliminar blancos.
("C-M-SPC" . insertar-espacios)			  ("C-M-S-SPC" . insertar-espacios-ad)
("<C-tab>" . indent-relative)			  ("<C-iso-lefttab>" . alinear-tab-a)
("<M-return>" . open-line)				  ("<C-return>" . insertar-línea-debajo)
("<M-S-return>" . split-line)			  ("M-S-SPC" . delete-horizontal-space)
("<S-return>" . insertar-línea-encima)	  ("<C-S-return>" . insertar-línea-encima-debajo)
("C-x <C-tab>" . tabify)				  ("C-x <C-S-iso-lefttab>" . untabify)
("<C-M-tab>" . indent-region)			  ("<C-M-return>" . electric-indent-just-newline)

;Búsquedas y búsquedas con sustitución.
("<C-dead-acute>" . isearch-forward)		 ("<C-S-dead-diaeresis>" . isearch-backward)
("<C-dead-grave>" . query-replace)			 ("<M-dead-acute>" . isearch-forward-word)
("<M-dead-grave>" . query-replace-regexp)	 ("<M-dead-diaeresis>" . word-search-backward)
("<C-dead-circumflex>" . replace-string)	 ("<C-M-dead-acute>" . isearch-forward-regexp)
("<M-dead-circumflex>" . replace-regexp)	 ("<C-M-dead-diaeresis>" . isearch-backward-regexp)

;Abrir ventanas con distintos buffers y modos. Otras funciones con menú.
("<menu> d" . abrir-Dired)		   ("<menu> G" . cerrar-dired)		("<menu> n" . display-line-numbers-mode)
("<menu> D" . abrir-Dired)		   ("<menu> f" . poner-follow)		("<menu> t" . treemacs-select-window)
("<menu> b" . abrir-Dired)		   ("<menu> w" . speedbar)			("<menu> l" . global-tab-line-mode)
("<menu> <menu>" . abrir-shell)	   ("<menu> T" . treemacs)			("<menu> g" . cerrar-shell)

;Frames.
("<menu> z" . make-frame)	   ("<menu> đ" . other-frame);Altgr f
("<menu> Z" . delete-frame)	   ("<menu> ª" . suspend-frame);Altgr F

;Archivos.
("M-f" . insert-file)	  ("C-d" . dired-jump)				("C-ª" . find-file-other-frame);Altgr F	  
("C-f" . find-file)		  ("đ" . find-alternate-file)		("C-S-f" . find-file-other-window)
("C-s" . save-buffer)	  ("C-S-s" . save-some-buffers)		("C-đ" . find-file-read-only-other-window)
("C-ß" . write-file)	  ("ª" . set-visited-file-name)

;Buffers.
("C-”" . kill-current-buffer)	 ("C-S-b" . switch-to-buffer-other-window)
("’" . next-buffer)				 ("C-b" . counsel-switch-buffer)		
("”" . previous-buffer)			 ("C-’" . kill-buffer-and-window);Altgr B
("M-b" . buffer-menu)			 ("M-”" . ,(λ (switch-to-prev-buffer nil t)))
("C-x b" . eval-buffer)			 ("C-x C-b" . ,(λ (byte-compile-file (buffer-file-name))))
("M-B" . bury-buffer)			 ("C-M-b" . ,(λ (otra-ventana 'previous-buffer (next-window))))
("C-M-”" . rename-buffer)		 ("C-M-S-b" . ,(λ (otra-ventana 'next-buffer (next-window))))

;Parejas.
("M-'" . parejas)	   ("M-¡" . parejas)	  ("C-M-'" . parejas)	 ("M-?" . parejas)
("C-'" . parejas)	   ("C-¿" . parejas)	  ("M-¿" . parejas)		 ("C-M-¡" . parejas)
("C-?" . parejas)	   ("C-¡" . parejas)	  ("C-M-?" . parejas)	 ("C-M-¿" . parejas)

;Ventanas.
("C-." . other-window)			  ("C-:" . ,(λ (other-window -1)))
("C-·" . int-buffers)			  ("M-:" . ,(λ (select-window (split-window-below))))
("·" . ace-window)				  ("<menu> Q" . ,(λ (quit-window nil (previous-window))))
("C-M-:" . delete-window)		  ("M-." . ,(λ (select-window (split-window-right))))
("C-x C-." . sel-minibuffer)	  ("C-M-." . delete-other-windows)
("<menu> q" . cerrar-ventana)

("M--" . enlarge-window)	   ("C-_" . shrink-window-horizontally)
("M-_" . shrink-window)		   ("C--" . enlarge-window-horizontally)
("C-M--" . balance-windows)	   ("<C-dead-belowdot>" . toggle-frame-fullscreen)
("C-M-_" . shrink-window-if-larger-than-buffer)

;Rectángulos.
("C-p" . rectangle-mark-mode)			   ("M-P" . kill-rectangle)
("C-o" . string-insert-rectangle)		   ("M-O" . clear-rectangle)
("C-S-p" . delete-whitespace-rectangle)	   ("C-M-p" . rectangle-number-lines)
("C-S-o" . string-rectangle)			   ("C-M-o" . open-rectangle)
("M-p" . copy-rectangle-as-kill)		   ("C-M-S-p" . delete-trailing-whitespace)
("M-o" . yank-rectangle)				   ("C-M-S-o" . delete-rectangle)

;Transposiciones.
("C-S-t" . transpose-lines)			 ("C-ŧ" . mover-línea)
("C-M-t" . transpose-paragraphs)	 ("C-Ŧ" . ,(λ (mover-línea -1)))
("C-M-S-t" . ,(λ (transpose-paragraphs -1)))

;Seleccionar.
("M-H" . sel-en-pareja)			("C-h" . seleccionar-palabra)
("C-M-S-h" . sel-pareja)		("C-S-h" . exchange-point-and-mark)
("C-M-h" . seleccionar-líneas)

;Registros.
("C-9" . point-to-register)		  ("C-x 9" . window-configuration-to-register)
("C-)" . jump-to-register)		  ("C-8" . append-to-register)
("M-9" . copy-to-register)		  ("C-(" . prepend-to-register)
("M-)" . insert-register)		  ("M-8" . copy-rectangle-to-register)
("C-M-9" . number-to-register)	  ("M-(" . window-configuration-to-register)
("C-M-)" . increment-register)	  ("C-M-8" . kmacro-to-register)

;Bookmarks.
("M-Ç" . bookmark-rename)	 ("C-S-ç" . bookmark-jump)		  ("C-ç" . bookmark-set-no-overwrite)
("C-M-ç" . bookmark-save)	 ("C-M-S-ç" . bookmark-delete)	  ("M-ç" . bookmark-bmenu-list)

;Mover el cursor izquierda-derecha / J-Ñ
("C-ñ" . forward-char)			 ("C-j" . backward-char)
("C-Ñ" . delete-char)			 ("C-S-j" . backward-delete-char)
("M-ñ" . forward-word)			 ("M-j" . backward-word)
("M-Ñ" . kill-word)				 ("M-J" . backward-kill-word)
("C-M-ñ" . move-end-of-line)	 ("C-M-j" . back-to-indentation)
("C-M-Ñ" . kill-line)			 ("C-M-S-j" . ,(λ (kill-line 0)))
("C-x ñ" . forward-whitespace)	 ("C-x j" . ,(λ (forward-whitespace -1)))

;Mover el cursor arriba-abajo / K-L
("C-l" . next-line)				 ("C-S-l" . ,(λ (forward-line 4)))
("C-k" . previous-line)			 ("C-S-k" . ,(λ (forward-line -4)))
("M-l" . forward-sentence)		 ("C-M-k" . ,(λ (forward-line -8)))
("M-k" . backward-sentence)		 ("C-M-l" . ,(λ (forward-line 8)))
("M-L" . forward-paragraph)		 ("C-&" . ,(λ (move-to-window-line-top-bottom -1)))
("M-K" . backward-paragraph)	 ("C-ĸ" . move-to-window-line-top-bottom)
("ĸ" . beginning-of-buffer)		 ("C-M-S-l" . borrar-línea)
("C-ł" . recenter-top-bottom)	 ("C-M-ł" . ,(λ (kill-whole-line 0)))
("ł" . end-of-buffer)            ("C-M-S-k" . ,(λ (recenter-top-bottom 4)))

;Avy
("M-m" . avy-goto-char-timer)		("M-M" . avy-goto-line)
("M-µ" . avy-goto-char-2)			("M-º" . avy-goto-word-1)

;Hacer scroll.
("C-M-;" . scroll-down-command)		("M-," . ,(λ (scroll-up-command 4)))
("C-M-," . scroll-up-command)	 	("M-;" . ,(λ (scroll-down-command 4)))
("C-×" . scroll-right)			 	("C-v" . ,(λ (scroll-other-window 3)))
("C-─" . scroll-left)	 		 	("C-S-v" . ,(λ (scroll-other-window-down 3)))
("C-;" . scroll-down-line)			("C-," . scroll-up-line)))

(global-set-key (kbd (car e)) (cdr e)))
