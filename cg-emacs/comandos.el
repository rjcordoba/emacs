;; -*- lexical-binding: t -*-
;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Funciones para los keybindings
;------------------------------------------------------------------

(defmacro λ (&rest forms) (append '(lambda () (interactive)) forms))

(defsubst primer-arch (buffers)
  (or (buffer-file-name (car buffers)) (primer-arch (cdr buffers))))

(let ((vent-dired nil))
  (defun abrir-Dired (&optional n)
	"Abre una ventana a la izquierda con el buffer correspondiente según el comando; con argumento abre abajo."
	(interactive "P")
	(unless (window-live-p vent-dired)
	  (setq vent-dired (let ((lado (unless n 'left))) (split-window (frame-root-window) (when lado (* (/ (frame-width) 9) 7)) lado))))
	(select-window vent-dired)
	(pcase (elt (this-command-keys) 1)
	  (?d (dired (or (file-name-directory (primer-arch (buffer-list))) "/almacenamiento/proyectos")))
	  (?D (dired (read-file-name "Directorio: ")))
	  (?b (ibuffer)))
	(setq window-size-fixed 'width))

  (defun cerrar-dired ()
	"Cierra la ventana de la izquierda abierta con «abrir-Dired»."
	(interactive)
	(if (window-live-p vent-dired) (delete-window vent-dired) (error "La ventana dired no está abierta"))))

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
		(?t (let ((b (get-buffer " *terminal*"))) (if b (switch-to-buffer b) (term "/bin/bash") (rename-buffer " *terminal*"))))
		(?S (let ((display-buffer-overriding-action '(display-buffer-same-window . nil))) (shell " *shell*")))
		(?s (let ((b (get-buffer " *eshell*"))) (if b (switch-to-buffer b) (eshell) (rename-buffer " *eshell*"))))
		(?a (let ((b (get-buffer " *ielm*"))) (if b (switch-to-buffer b) (ielm) (rename-buffer " *ielm*"))))
		(?A (switch-to-buffer " *scratch*"))
		(?> (switch-to-buffer "*Async Shell Command*"))
 		(?< (switch-to-buffer "*Shell Command Output*"))
		(?m (switch-to-buffer (messages-buffer)))
		(_ (unless abierta (delete-window vent-shell))
		   (setq abierta 'err)
		   (error "%c no abre ningún buffer en la ventana." (elt (this-command-keys) 2))))
	  (unless (eq abierta 'err) (set-window-dedicated-p vent-shell t) (setq window-size-fixed 'width))))

  (defun cerrar-shell ()
	"Cierra la ventana de la derecha abierta con «abrir-shell»."
	(interactive)
	(if (window-live-p vent-shell) (delete-window vent-shell) (error "La ventana shell no está abierta"))))

(let ((v nil))
  (defun poner-follow (n)
	"Abre otras ventanas y pone follow mode o lo quita y cierra las ventanas que se habían abierto anteriormente con este comando.
Sin argumento abre una nueva ventana; con él abre el número que se indique."
	(interactive "p")
	(follow-mode 'toggle)
	(if follow-mode
		(dotimes (n n) (push (split-window-horizontally) v))
    (dolist (i v) (delete-window i)))
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
	(end-of-line) (insert s) (goto-char pos)
	(beginning-of-line) (setq pos (- pos (point))) (insert s) (forward-char pos)))

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
  (skip-chars-backward "^[\s\t\n]") (delete-horizontal-space) (indent-relative))

(defun borrar-línea ()
  "Si hay texto seleccionado lo borra; si no borra la línea donde esté
   el cursor y deja éste al final de la línea anterior."
  (interactive)
  (if (use-region-p) (backward-delete-char-untabify 1 t) (kill-whole-line -1)))

(defun seleccionar-líneas (n)
  "Selecciona la línea actual. Con argumento selecciona n líneas empezando desde la actual."
  (interactive "p")
  (set-mark (line-beginning-position))
  (move-end-of-line n))

(defun seleccionar-palabra ()
  "Selecciona la palabra actual."
  (interactive)
  (forward-char) (backward-word) (mark-word) (exchange-point-and-mark))

(defun sel-en-pareja (&optional n)
  "Selecciona el texto alrededor del point que esté entre comillas, interrogaciones...
   Con prefijo pregunta el símbolo inicial desde el que se seleccionará."
  (interactive "p")
  (let ((simbs "'`«“<‘¡\"(¿{[?\x00") (pila (list)) (busq nil) (c nil) (cc nil))
	(if (= n 16)
		(let ((char (read-string " Símbolo a buscar: ")))
		  (while (not (and (= (length char) 1) (seq-contains-p simbs (string-to-char char))))
			(setq char (read-string " Entrada incorrecta. Símbolo: ")))
		  (search-backward char) (forward-char))
	  (skip-chars-backward (concat "^" simbs)))
	(setq c (preceding-char))
	(push-mark nil t t)
	(push c pila)
	(setq cc (pcase c
			   (?\x00 (error " Principio de buffer"))
			   (?` ?`)
			   (?« ?»)
			   (?“ ?”)
			   (?< ?>)
			   (?‘ ?’)
			   (?¡ ?!)
			   (?' ?')
			   (?\" ?\")
			   (?\( ?\))
			   (?¿ ??)
			   (?{ ?})
			   (?\[ ?\])))
	(setq busq (concat (char-to-string c) "\\|" (char-to-string cc)))
	(while pila
	  (re-search-forward busq)
	  (if (eq cc (preceding-char)) (pop pila) (push c pila))))
  (when (= n 4) (exchange-point-and-mark))
  (backward-char))

(defun sel-pareja (n c1)
  "Selecciona el texto entre dos símbolos."
  (interactive "p\ns Símbolo: ")
  (let ((c2 (if (> n 1) (read-string " Segundo símbolo: ") c1)))
  	(search-backward c1) (forward-char) (push-mark (point) t t) (search-forward c2)
	(when (> n 4) (exchange-point-and-mark))
	(backward-char)))

(defun abrir-cerrar (a c)
  "Función auxiliar para 'parejas'"
  (let ((p (if (use-region-p) (prog1 (region-beginning) (goto-char (region-end))) (point))))
		(insert c) (goto-char p) (insert a)))

(defun parejas (&optional n)
  "Para poner paréntesis, llaves..."
  (interactive "P")
  (when n (insert "=") (if (eq ?\s (char-after (- (point) 2))) (insert ?\s)))
  (pcase (elt (this-command-keys) 0)
    (?\C-\' (abrir-cerrar ?\' ?\'))
    (201326655 (abrir-cerrar ?‘ ?’));?\C-\M-?
    (167 (abrir-cerrar ?\` ?\`));M-'
    (?\M-¡ (abrir-cerrar ?\" ?\"))
    (?¿ (abrir-cerrar ?“ ?”));?\M-?
    (?\C-\M-' (abrir-cerrar ?< ?>))
    (67108927 (abrir-cerrar ?« ?»));C-?
    (?\C-¡ (abrir-cerrar ?¡ ?!))
    (?\C-¿ (abrir-cerrar ?¿ ?\?))
    (?\C-\M-¡ (abrir-cerrar ?\( ?\)))
    (?\C-\M-¿ (abrir-cerrar ?\[ ?\]))
    (?\M-¿ (abrir-cerrar ?{ ?}))))

(defun volver-a-backup ()
  "Volver al archivo backup despreciando los cambios.
 No se borran los cambios hasta que se guarda."
  (interactive)
  (let ((a (file-newest-backup buffer-file-name)))
	(if a (insert-file-contents-literally a nil nil nil t) (message " No hay backup de este archivo."))))

(defun mover-línea (n)
  "Mueve la línea donde está el cursor hacia abajo si n es positivo y hacia arriba si es negativo."
    (interactive "p")
	(let ((p (point)))
	  (beginning-of-line)
	  (setq p (- p (point)))
	  (kill-line) (backward-delete-char 1) (forward-line n)
	  (end-of-line) (insert "\n") (yank) (move-beginning-of-line 1) (forward-char p)))

(defun cerrar-ventana (n)
  "Para cerrar las ventanas o los buffers que se abren sin llamarlos directamente."
  (interactive "p")
  (dolist (i (window-list))
	(when (string-prefix-p "*" (buffer-name (window-buffer i))) (quit-window (> n 1) i))))

(defun lorem-ipsum-cg (n)
  "Mete tantos párrafos de Lorem Ipsum como diga el argumento; lo máximo son 25."
  (interactive "p")
  (insert
   (with-temp-buffer
	 (insert-file-contents (directorio-cg "plantillas/lorem_ipsum.txt"))
	 (goto-char 1)
	 (forward-paragraph (min n 25))
	 (buffer-substring 1 (point)))))

;;-----------------------------------------------------------------------------

(provide 'comandos)
