;; -*- lexical-binding: t -*-
;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Funciones para los keybindings
;------------------------------------------------------------------

(require 'funciones)

(defmacro λ (&rest forms) (append '(lambda () (interactive)) forms))

(defun cg-comando-proy (n)
  "Pide un comando y lo ejecuta con el directorio del proyecto como directorio actual. Si
el argumento es 4 pide directorio en el que se ejecutará el comando. Si es mayor que 4 el
directorio actual sera el directorio del archivo actual."
  (interactive "p")
  (cg-shell-comando
   (read-from-minibuffer (colorear-consulta "Comando: "))
   (if (eq n 4)
	   (read-directory-name (colorear-consulta "Directorio: "))
	 (when (> n 4) default-directory))))

(defun grep-buscar-string (n)
  "Pide un string y un directorio y busca el string con «grep».
Con argumento lo busca en el directorio actual."
  (interactive "P")
  (cg-comando-fondo
   (concat "grep -R " (read-from-minibuffer (colorear-consulta "String a buscar: ")))
   (if n
	   default-directory
	 (read-directory-name (colorear-consulta "Directorio: ")))))

(defun otra-ventana (f v)
  "Ejecuta el form «f» en otra ventana sin dejarla activa."
  (let ((w (selected-window)))
	(select-window v)
	(if (symbolp f)
		(funcall (symbol-function f))
	  (eval f))
	(select-window w)))

(defsubst primer-arch (buffers)
  (when buffers
	(or (buffer-file-name (car buffers))
		(primer-arch (cdr buffers)))))

(let ((vent-dired nil))
  (defun abrir-Dired (n)
	"Abre una ventana a la izquierda con el buffer correspondiente según el comando; con argumento abre abajo."
	(interactive "P")
	(if (window-live-p vent-dired)
		(set-window-dedicated-p vent-dired nil)
	  (setq vent-dired (let ((lado (unless n 'left)))
						 (split-window (frame-root-window) (when lado (* (/ (frame-width) 9) 7)) lado))))
	(select-window vent-dired)
	(pcase (elt (this-command-keys) 1)
	  (?d (dired (or (file-name-directory (primer-arch (buffer-list))) "/almacenamiento/proyectos")))
	  (?D (dired (read-file-name (colorear-consulta "Directorio: "))))
	  (?b (ibuffer)))
	(set-window-dedicated-p vent-dired t)
	(setq window-size-fixed 'width))

  (defun cerrar-dired ()
	"Cierra la ventana de la izquierda abierta con «abrir-Dired»."
	(interactive)
	(if (window-live-p vent-dired)
		(delete-window vent-dired)
	  (error "La ventana dired no está abierta"))))

(let ((vent-shell nil)
	  (lateral nil))
  (defun abrir-shell (x n)
	"Abre una ventana a la derecha con el buffer correspondiente según el comando."
	(interactive "c\nP")
	(let ((abierta (window-live-p vent-shell))
		  (default-directory (or cg-origen default-directory)))
	  (when (and abierta (or (and lateral n) (not (or lateral n))))
		(cerrar-shell)
		(setq abierta nil))
	  (unless abierta
		(setq vent-shell
			  (display-buffer-in-side-window
			   (current-buffer)
			   (if n
				   '((side . bottom) (window-height . 0.37))
				 '((side . right) (window-width . 0.37))))))
	  (setq lateral (not n))
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
		(while (< 1 n)
		  (push (split-window-horizontally) v)
		  (setq n (1- n)))
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

(defun int-buffers (n)
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
  "Borra la línea donde esté el cursor y deja éste al final de
la línea anterior. Si hay texto seleccionado lo borra antes "
  (interactive)
  (if (use-region-p)
	  (backward-delete-char 1)
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

(defun escribir-fin-líneas (ini fin)
  "Pide texto y lo añade al final de las líneas seleccionadas"
  (interactive "r")
  (let ((s (read-string (colorear-cab "Texto: "))))
	(unless (use-region-p)
	  (setq ini (point))
	  (setq fin (point)))
	(goto-char fin)
	(end-of-line)
	(while (>= (point) ini)
	  (insert s)
	  (forward-line -1)
	  (end-of-line))
	(forward-line)
	(end-of-line)))

(defun volver-a-backup ()
  "Volver al archivo backup despreciando los cambios.
 No se borran los cambios hasta que se guarda."
  (interactive)
  (let ((a (file-newest-backup buffer-file-name)))
	(if a
		(insert-file-contents-literally a nil nil nil t)
	  (error " No hay backup de este archivo."))))

(defun mover-línea-arriba ()
  "Mueve la línea donde está el cursor hacia arriba."
  (interactive)
  (let ((p (point)))
	(beginning-of-line)
	(setq p (- p (point)))
	(kill-whole-line 1)
	(if (eq (point) (point-min))
		(insert "\n"))
	(forward-line -1)
	(yank)
	(forward-line -1)
	(forward-char p)))

(defun mover-línea-abajo ()
  "Mueve la línea donde está el cursor hacia abajo."
  (interactive)
  (let ((p (point)))
	(beginning-of-line)
	(setq p (- p (point)))
	(if (eq (point) (point-min))
		(progn
		  (kill-whole-line 0)
		  (kill-append "\n" t)
		  (delete-char 1))
	  (kill-whole-line -1)
	  (forward-line 1))
	(end-of-line)
	(when (eq (point) (point-max))
	  (insert "\n"))
	(yank)
	(beginning-of-line)
	(forward-char p)))

(defun comentar/descomentar-bloque (inicial final &optional línea)
  "Si el cursor se encuentra en un comentario lo elimina, tanto si es de bloque
como si es de línea. Si no está en un comentario pone comentario de bloque entre
principio y fin de la selección; si no existe selección comenta el párrafo."
  (let ((syntax (syntax-ppss))
		(p (point))
		(salto (length inicial)))
	(if (nth 4 syntax)
		(progn
		  (goto-char (nth 8 syntax))
		  (if (looking-at (string-trim inicial))
			  (progn
				(delete-char salto)
				(search-forward final)
				(delete-char (- (length final))))
			(setq salto (length línea))
			(delete-char salto))
		  (goto-char (- p salto)))
	  (when (not (use-region-p))
		(mark-paragraph))
	  (let ((end (region-end)))
		(goto-char (region-beginning))
		(insert inicial)
		(goto-char (+ end salto))
		(insert final)))))

(defun cerrar-ventana (n)
  "Para cerrar las ventanas o los buffers cuyo nombre empieza por asterisco.
Con prefijo elimina el buffer en vez de hundirlo en la lista."
  (interactive "P")
  (walk-windows
   (lambda (w)
	 (when (and (not (window-dedicated-p w)) (string-prefix-p "*" (buffer-name (window-buffer w))))
	   (quit-window n w)))
   'no nil))

(defun lorem-ipsum-cg (n)
  "Mete tantos párrafos de Lorem Ipsum como diga el argumento; lo máximo son 50."
  (interactive "p")
  (insert
   (with-temp-buffer
	 (insert-file-contents (directorio-cg "plantillas/lorem_ipsum.txt"))
	 (goto-char 1)
	 (forward-paragraph (min n 50))
	 (buffer-substring 1 (point)))))

(let (
	  (pars '((?' . ?')   (?` . ?`)    (?< . ?>)    (?« . ?»)   (?“ . ?”)   (?‘ . ?’)
			  (?¡ . ?!)   (?\" . ?\")  (?\( . ?\))  (?¿ . ??)   (?{ . ?})   (?\[ . ?\])))
	  (simbs "")
	  (er-a "No se ha encontrado símbolo de apertura.")
	  (er-c "No se ha encontrado símbolo de cierre."))

  (dolist (e pars)
	(setq simbs
		  (concat (unless (eq (car e) (cdr e)) (char-to-string (cdr e))) (char-to-string (car e)) simbs)))

  (setq simbs (concat "[" simbs "]"))

  (defun reg--letras (s) (concat (char-to-string (cdr (assq s pars))) "\\|" (char-to-string s)))

  (defun cg-inicio-nido (s)
	"Deja el point a la izquierda del símbolo «s» saltándose los
anidamientos con ese símbolo que pueda haber entre medio."
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
	"Selecciona el texto alrededor del «point» que esté entre comillas, interrogaciones...
   Con prefijo descarta los símbolos de apertura y cierre; selecciona sólo el contenido."
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
			(backward-char)
			(setq ini (1+ ini)))
		  (push-mark ini t t))
      (search-failed (error er-a))))

  (defun sel-pareja (n c1)
	"Selecciona el texto entre dos símbolos. Sin prefijo el símbolo de apertura
y cierre será el mismo. Con prefijo pide segundo símbolo para usarlo como cierre
de la selección. Con doble prefijo incluye los símbolos de apertura y cierre en la selección."
	(interactive "p\ns Símbolo: ")
	(let ((c2 (if (> n 1)
				  (read-string (colorear-cab "Segundo símbolo: "))
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
			   (?\C-\' ?\')		(201326655 ?‘)		(167  ?\`)	   (?\M-¡ ?\")
			   (?\C-\M-' ?<)	(67108927 ?«)		(?\C-¡ ?¡)	   (?\C-\M-¿ ?\[)
			   (?\C-¿ ?¿)		(?\C-\M-¡ ?\()		(?¿ ?“)		   (?\M-¿ ?{))))
	  (insert (cdr (assq s pars)))
	  (let ((f (point)))
		(goto-char p)
		(insert s)
		(goto-char f)))))

(provide 'comandos)
