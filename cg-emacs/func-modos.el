;--------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Funciones para configuraciones personales de modos mayores.
;	 Archivo para que esté en el mismo sitio toda la lógica de
;	 cómo se cargan las configuraciones personales de los modos..
;--------------------------------------------------------------------

(defun cg--poner-keys (keys map)
  (let ((mapa (or map (current-local-map)))
		(f nil))
	(dolist (i keys)
	  (setq f (cdr i))
	  (define-key mapa (kbd (car i)) (if (macrop f) (eval f) f)))))

(defun cg--despejar-tabla (keys map)
  (let ((mapa (or map (current-local-map))))
	(define-key mapa (kbd "<menu>") (make-sparse-keymap))
	(dolist (i  keys)
	  (define-key mapa (kbd (concat "<menu> " i)) (local-key-binding (kbd i)))
	  (define-key mapa (kbd i) nil))))

(defmacro cg-retocar-modos (&rest modos)
  `(dolist (i (quote ,modos))
	 (let* ((n (concat "cg-" i))
			(f (intern n)))
	   (autoload f n)
	   (add-hook (intern (concat i "-mode-hook")) f))))

(defmacro cg-configs-modo (&rest valores)
  (let ((kq (plist-get valores :quitar))
		(kp (plist-get valores :poner))
		(hk (plist-get valores :hook))
		(tb (plist-get valores :tabla)))
	`(let* ((m (file-name-base load-file-name))
			(s (intern m))
			(n (substring m (1+ (cl-search "-" m))))
			(h (intern (concat n "-mode-hook")))
			(p ,(when tb
				  (if (eq tb t) `(symbol-value (intern (concat n "-mode-map"))) tb))))
	   ,(when kq `(cg--despejar-tabla (quote ,kq) p))
	   ,(when kp `(cg--poner-keys (quote ,kp) p))
	   ,(when hk `(and (funcall ,hk) (add-hook h ,hk)))
	   (fset s #'ignore)
	   (remove-hook h s)
	   (message (format "cargado el archivo de configuración %s" m)))))

(provide 'func-modos)
