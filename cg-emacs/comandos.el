;; -*- lexical-binding: t -*-
;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Funciones para los keybindings
;------------------------------------------------------------------

(defmacro λ (&rest forms) (append '(lambda () (interactive)) forms))

(defsubst primer-arch (buffers)
  (or (buffer-file-name (car buffers))
	  (primer-arch (cdr buffers))))

(let ((vent-dired nil))
  (defun abrir-Dired (&optional n)
	"Abre una ventana a la izquierda con el buffer correspondiente según el comando; con argumento abre abajo."
	(interactive "P")
	(if (window-live-p vent-dired)
		(set-window-dedicated-p vent-dired nil)
	  (setq vent-dired (let ((lado (unless n 'left))) (split-window (frame-root-window) (when lado (* (/ (frame-width) 9) 7)) lado))))
	(select-window vent-dired)
	(pcase (elt (this-command-keys) 1)
	  (?d (dired (or (file-name-directory (primer-arch (buffer-list))) "/almacenamiento/proyectos")))
	  (?D (dired (read-file-name "Directorio: ")))
	  (?b (ibuffer)))
	(set-window-dedicated-p vent-dired t)
	(setq window-size-fixed 'width))

  (defun cerrar-dired ()
	"Cierra la ventana de la izquierda abierta con «abrir-Dired»."
	(interactive)
	(if (window-live-p vent-dired)
		(delete-window vent-dired)
	  (error "La ventana dired no está abierta"))))

(let ((vent-shell nil))
  (defun abrir-shell (x)
	"Abre una ventana a la derecha con el buffer correspondiente según el comando."
	(interactive "c")
	(let ((abierta (window-live-p vent-shell))
		  (default-directory (or cg-origen default-directory)))
	  (unless abierta
		(setq vent-shell (display-buffer-in-side-window (current-buffer) '((side . right) (window-width . 0.37)))))
	  (set-window-dedicated-p (select-window vent-shell) nil)
	  (pcase x
		(?t (term "/bin/bash"))
		(?S (let ((display-buffer-overriding-action '(display-buffer-same-window . nil))) (shell)))
		(?s (eshell))
		(?a (ielm))
		(?A (switch-to-buffer "*scratch*"))
		(?> (switch-to-buffer "*Async Shell Command*"))
 		(?< (switch-to-buffer "*Shell Command Output*"))
		(?m (switch-to-buffer (messages-buffer)))
		(_ (unless abierta (delete-window vent-shell))
		   (setq abierta 'err)
		   (error "«%c» no abre ningún buffer en la ventana." (elt (this-command-keys) 2))))
	  (unless (eq abierta 'err)
		(set-window-dedicated-p vent-shell t)
		(setq window-size-fixed 'width))))

  (defun cerrar-shell ()
	"Cierra la ventana de la derecha abierta con «abrir-shell»."
	(interactive)
	(if (window-live-p vent-shell)
		(delete-window vent-shell)
	  (error "La ventana shell no está abierta"))))

(let ((v nil))
  (defun poner-follow (n)
	"Abre otras ventanas y pone follow mode o lo quita.
Cierra las ventanas que se habían abierto anteriormente con este comando.
Sin argumento abre una nueva ventana; con él abre el número que se indique."
	(interactive "p")
	(setq n (max n 2))
	(if (follow-mode 'toggle)
		(while (< 1 n) (push (split-window-horizontally) v) (setq n (1- n)))
      (dolist (i v) (delete-window i))
	  (setq v nil))
	(balance-windows)))

(defun intercambiar-buffers (vent-1 vent-2)
  "Intercambia los buffers de la ventanas vent-1 y vent-2."
  (if (and (window-live-p vent-1) (window-live-p vent-2))
	  (let ((prev (window-prev-buffers vent-1))
			(buf (window-buffer vent-1))
			(next (window-next-buffers vent-1)))
		(set-window-prev-buffers vent-1 (window-prev-buffers vent-2))
		(set-window-buffer vent-1 (window-buffer vent-2))
		(set-window-next-buffers vent-1 (window-next-buffers vent-2))
		(set-window-prev-buffers vent-2 prev)
		(set-window-buffer vent-2 buf)
		(set-window-next-buffers vent-2 next))
	(error " No son dos ventanas visibles.")))

(defun int-buffers (&optional n)
  "Intercambia los buffers de la ventana actual y la siguiente; con argumento, con la anterior."
  (interactive "P")
  (intercambiar-buffers (selected-window) (if n (next-window) (previous-window))))

(defun sel-minibuffer ()
  "Selecciona el minibuffer si está activo (si he salido por error)."
  (interactive)
  (if (active-minibuffer-window)
	  (select-window (active-minibuffer-window))
	(error "El minibuffer no está activo")))

(defun insertar-línea-encima (n)
  "Inserta líneas encima de en la que está el cursor."
  (interactive "p")
  (let ((pos (point)))
	(beginning-of-line)
	(setq pos (- pos (point)))
	(insert (make-string (abs n) ?\n))
	(forward-char pos)))

(defun insertar-línea-debajo (n)
  "Inserta líneas debajo de en la que está el cursor. Si está enmedio de una línea no la corta."
  (interactive "p")
  (let ((pos (point)))
	(end-of-line)
	(insert (make-string (abs n) ?\n))
	(goto-char pos)))

(defun insertar-línea-encima-debajo (n)
  "Inserta líneas encima y debajo de en la que está el cursor."
  (interactive "p")
  (let ((s (make-string (abs n) ?\n))
		(pos (point)))
	(end-of-line)
	(insert s)
	(goto-char pos)
	(beginning-of-line)
	(setq pos (- pos (point)))
	(insert s)
	(forward-char pos)))

(defun insertar-espacios (n)
  "Inserta espacios sin mover el cursor."
  (interactive "p")
  (let ((pos (point)))
	(insert (make-string (abs n) ?\s))
	(goto-char pos)))

(defun insertar-espacios-ad (n)
  "Inserta espacios delante y detrás del cursor."
  (interactive "p")
  (let ((pos (point))
		(s (make-string (abs n) ?\s)))
	(insert s)
	(goto-char pos)
	(insert s)))

(defun alinear-tab-a ()
  "Tabula respecto a la línea de arriba a partir de los espacios anteriores a la posición del cursor."
  (interactive)
  (skip-chars-backward "^[\s\t\n]")
  (delete-horizontal-space)
  (indent-relative))

(defun borrar-línea ()
  "Si hay texto seleccionado lo borra; si no borra la línea donde esté
   el cursor y deja éste al final de la línea anterior."
  (interactive)
  (if (use-region-p)
	  (backward-delete-char-untabify 1 t)
	(kill-whole-line -1)))

(defun seleccionar-líneas (n)
  "Selecciona la línea actual. Con argumento selecciona n líneas empezando desde la actual."
  (interactive "p")
  (set-mark (line-beginning-position))
  (move-end-of-line n))

(defun seleccionar-palabra ()
  "Selecciona la palabra actual."
  (interactive)
  (forward-char)
  (backward-word)
  (mark-word)
  (exchange-point-and-mark))

(defun volver-a-backup ()
  "Volver al archivo backup despreciando los cambios.
 No se borran los cambios hasta que se guarda."
  (interactive)
  (let ((a (file-newest-backup buffer-file-name)))
	(if a
		(insert-file-contents-literally a nil nil nil t)
	  (error " No hay backup de este archivo."))))

(defun mover-línea (n)
  "Mueve la línea donde está el cursor hacia abajo si n es positivo y hacia arriba si es negativo."
  (interactive "p")
  (let ((p (point)))
	(beginning-of-line)
	(setq p (- p (point)))
	(kill-line)
	(backward-delete-char 1)
	(forward-line n)
	(end-of-line)
	(insert "\n")
	(yank)
	(move-beginning-of-line 1)
	(forward-char p)))

(defun cerrar-ventana (n)
  "Para cerrar las ventanas o los buffers que se abren sin llamarlos directamente.
Con prefijo elimina el buffer en vez de hundirlo en la lista."
  (interactive "P")
  (walk-windows
   (lambda (w)
	 (when (and (not (window-dedicated-p w)) (string-prefix-p "*" (buffer-name (window-buffer w))))
	   (quit-window n w)))
   'no nil))

(defun lorem-ipsum-cg (n)
  "Mete tantos párrafos de Lorem Ipsum como diga el argumento; lo máximo son 25."
  (interactive "p")
  (insert
   (with-temp-buffer
	 (insert-file-contents (directorio-cg "plantillas/lorem_ipsum.txt"))
	 (goto-char 1)
	 (forward-paragraph (min n 25))
	 (buffer-substring 1 (point)))))

(let (
	  (pars '((?' . ?')   (?` . ?`)    (?< . ?>)    (?« . ?»)   (?“ . ?”)   (?‘ . ?’)
			  (?¡ . ?!)   (?\" . ?\")  (?\( . ?\))  (?¿ . ??)   (?{ . ?})   (?\[ . ?\])))
	  (simbs "")
	  (er-a)
	  (er-c))

  (let ((e "No se ha encontrado símbolo de "))
	(setq er-a (concat e "apertura")
		  er-c (concat e "cierre")))

  (dolist (e pars)
	(setq simbs
		  (concat (unless (eq (car e) (cdr e)) (char-to-string (cdr e))) (char-to-string (car e)) simbs)))

  (setq simbs (concat "[" simbs "]"))

  (defun reg--letras (s) (concat (char-to-string (cdr (assq s pars))) "\\|" (char-to-string s)))

  (defun cg-inicio-nido (s)
	"Deja el point a la izquierda del símbolo «s» saltándose los
anidamientoscon ese símbolo que pueda haber entre medio."
	(let ((pila nil)
		  (ss (reg--letras s)))
	  (push t pila)
	  (while pila
		(re-search-backward ss)
		(if (eq s (following-char))
			(pop pila)
		  (push t pila)))))

  (defun cg-fin-nido (s &optional p)
	"Deja el point a la derecha del símbolo pareja de «s», saltándose
 los anidamientos con ese símbolo que pueda haber entre medio."
	(let* ((pila nil)
		   (ss (reg--letras s))
		   (s2 (string-to-char ss)))
	  (goto-char (or p (point)))
	  (push t pila)
	  (while pila
		(re-search-forward ss)
		(if (eq s2 (preceding-char))
			(pop pila)
		  (push t pila)))))

  (defun sel-en-pareja (n)
	"Selecciona el texto alrededor del point que esté entre comillas, interrogaciones...
   Con prefijo pregunta el símbolo inicial desde el que se seleccionará."
	(interactive "P")
	(condition-case nil
		(let ((pos (point))
			  (ini))
		  (re-search-backward simbs)
		  (while (not (assq (following-char) pars))
			(cg-inicio-nido (car (rassq (following-char) pars)))
			(re-search-backward simbs))
		  (setq ini (point))
		  (condition-case nil
			  (cg-fin-nido (following-char) pos)
			(search-failed (error er-c)))
		  (when n
			(forward-char)
			(setq ini (1- ini)))
		  (push-mark ini t t))
      (search-failed (error er-a))))

  (defun sel-pareja (n c1)
	"Selecciona el texto entre dos símbolos. Sin prefijo el símbolo de apertura
y cierre será el mismo. Con prefijo pide segundo símbolo para usarlo como cierre
de la selección. Con doble prefijo incluye los símbolos de apertura y cierre en la selección."
	(interactive "p\ns Símbolo: ")
	(let ((c2 (if (> n 1)
				  (read-string "Segundo símbolo: ")
				c1)))
	  (condition-case nil
  		  (search-backward c1)
		(search-failed (error er-a)))
	  (forward-char)
	  (push-mark (point) t t)
	  (condition-case nil
		  (search-forward c2)
		(search-failed (error er-c)))
	  (when (> n 4)
		(exchange-point-and-mark))
	  (backward-char)))

  (defun parejas (n)
	"Para poner paréntesis, llaves, interrogaciones..."
	(interactive "P")
	(when n
	  (insert "=")
	  (when (eq ?\s (char-before (1- (point))))
		(insert ?\s)))
	(let ((p (if (use-region-p)
				 (prog1
					 (region-beginning)
				   (goto-char (region-end)))
			   (point)))
		  (s (pcase (elt (this-command-keys) 0)
			   (?\C-\' ?\')		(201326655	?‘)		(167  ?\`)	   (?\M-¡ ?\")
			   (?\C-\M-' ?<)	(67108927 ?«)		(?\C-¡ ?¡)	   (?\C-\M-¿ ?\[)
			   (?\C-¿ ?¿)		(?\C-\M-¡ ?\()		(?¿ ?“)		   (?\M-¿ ?{))))
	  (insert (cdr (assq s pars)))
	  (goto-char p)
	  (insert s))))

(provide 'comandos)
