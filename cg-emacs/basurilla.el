
(add-to-list 'default-frame-alist '(background-color . "#242424"))
(add-to-list 'default-frame-alist '(cursor-color . "AntiqueWhite4"))
(set-face-attribute 'mode-line-buffer-id nil :foreground "#F1C757")
(set-face-attribute 'mode-line nil :foreground "#E5D3D3" :background "#010111" :overline "#010111" :font "Courier 14" :box nil)
(set-face-attribute 'mode-line-inactive nil :foreground "#555" :background "#2E2E2E" :height 0.95 :overline nil :box nil)
(set-face-attribute 'region nil :background "#748288" :foreground "#FFF")
(set-face-attribute 'lazy-highlight nil :foreground "#FDF6D8" :background "#A09CF4")
(set-face-attribute 'isearch nil :background "#32804D" :foreground "#FFF")
(set-face-attribute 'vertical-border nil :foreground "#111")
(set-face-attribute 'fringe nil :background "#333")
(set-face-attribute 'font-lock-comment-delimiter-face nil :foreground "#AAA")
(set-face-attribute 'font-lock-comment-face nil :foreground "#AAA")


 ;; `(font-lock-keyword-face ((t (:foreground "#ffffff"))))
 ;; `(font-lock-comment-delimiter-face ((t (:foreground "#AAA"))))
 ;; `(font-lock-comment-face ((t (:foreground "#AAA")))))

;; Font lock faces
;; `(font-lock-builtin-face ((,class (:foreground "#e5786d"))))
;; `(font-lock-comment-face ((,class (:foreground "#99968b"))))
;; `(font-lock-constant-face ((,class (:foreground "#e5786d"))))
;; `(font-lock-function-name-face ((,class (:foreground "#cae682"))))
;; `(font-lock-keyword-face ((,class (:foreground "#8ac6f2" :weight bold))))
;; `(font-lock-string-face ((,class (:foreground "#95e454"))))
;; `(font-lock-type-face ((,class (:foreground "#92a65e" :weight bold))))
;; `(font-lock-variable-name-face ((,class (:foreground "#cae682"))))
;; `(font-lock-warning-face ((,class (:foreground "#ccaa8f"))))



(defmacro cg-configs-modo-2 (&rest valores)
  (let ((kq (plist-get valores :quitar))
		(kp (plist-get valores :poner)))
	(list 'progn
		  (when kq `(cg--despejar-tabla-lcl (quote ,kq)))
		  (when kp `(cg--poner-keys-lcl (quote ,kp)))
		  `(cg--prep-modo ,(plist-get valores :hook)))))

(defmacro cg-configs-modo-mp (&rest valores)
  (let ((kq (plist-get valores :quitar))
		(kp (plist-get valores :poner))
		(hk (plist-get valores :hook)))
	`(let* ((m (file-name-base load-file-name))
			(s (intern m))
			(n (substring m (1+ (cl-search "-" m))))
			(h (intern (concat n "-mode-hook")))
			(p (symbol-value (intern (concat n "-mode-map")))))
	   ,(when kq `(cg--despejar-tabla (quote ,kq) p))
	   ,(when kp `(cg--poner-keys (quote ,kp) p))
	   ,(when hk `(and (funcall ,hk) (add-hook h ,hk)))
	   (fset s ignore)
	   (remove-hook h s)
	   (message (format "cargado el archivo de configuración %s" m)))))

(defun cg--poner-keys (keys &optional map)
  (let ((mapa (or map (current-local-map)))
		(f nil))
	(dolist (i keys)
	  (setq f (cdr i))
	  (define-key mapa (kbd (car i)) (if (macrop f) (eval f) f)))))

(defun cg--despejar-tabla (keys &optional map)
  (let ((mapa (or map (current-local-map))))
	(define-key mapa (kbd "<menu>") (make-sparse-keymap))
	(dolist (i  keys)
	  (define-key mapa (kbd (concat "<menu> " i)) (local-key-binding (kbd i)))
	  (define-key mapa (kbd i) nil))))

(defmacro cg-despejar-tabla-local (&rest keys)
  "Elimina el keybinding de cada key `k` que recibe y los pone en `<menu> k`.
Para cambiar keybings en la tabla local en los que tenga conflicto con los de mi tabla global."
  `(cg-configs-modo :quitar ,keys))

(defmacro cg-poner-keys (&rest keys)
  "Recibe una alist -> (key . comando); pone los datos en la tabla local del modo activo cuando se llama a la función."
  `(cg-configs-modo :poner ,keys))

(defun cg--poner-keys-lcl (keys)
   (let ((f nil))
   (dolist (i keys)
	  (setq f (cdr i))
	  (local-set-key (kbd (car i)) (if (listp f) (eval f) f)))))

(defun cg--despejar-tabla-lcl (keys)
   (local-set-key (kbd "<menu>") (make-sparse-keymap))
   (dolist (i  keys)
	  (local-set-key (kbd (concat "<menu> " i)) (local-key-binding (kbd i)))
	  (local-unset-key (kbd i))))

(defun cg--prep-modo (&optional hook)
  (let* ((m (file-name-base load-file-name))
		 (s (intern m))
		 (h (intern (concat (substring m 3) "-mode-hook"))))
	(fset s 'ignore)
	(remove-hook h s)
	(when hook (funcall hook) (add-hook h hook))
	(message (format "cargado el archivo de configuración %s" m))))

;; :poner (("C-w" . (lambda () (interactive)(message "........z..........")))))
 ;; :hook (lambda () (setq-local xxx 8)))

(defun cerrar-ventana ()
  "Para cerrar las ventanas o los buffers que se abren sin llamarlos directamente."
  (interactive)
  (let ((v (or
		    (get-buffer-window "*Help*")
		    (get-buffer-window "*Messages*")
		    (get-buffer-window "*Backtrace*")
		    (get-buffer-window "*Compile-Log*")
			(get-buffer-window "*Warnings*")
			(get-buffer-window "*xref*")
			(and (y-or-n-p (format "¿Quitar el buffer %s? " (buffer-name (window-buffer (next-window))))) (next-window)))))
	(when v (quit-window nil v))))
