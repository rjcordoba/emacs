;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Variables globales
;------------------------------------------------------------------

(defvar variables-completar () "valores de las variables para usar por la función «cambiar-variable» para el completado.")

(dolist (elemento
		 '((cg-backups "~/cosas/proyectos/.backups") ; Directorio donde se guardan los archivos backup
		   (cg-proyecto "~/cosas/proyectos/yamm") ;Dirección del proyecto actual
		   (cg-servidor "sudo systemctl start mariadb; sudo systemctl start apache2") ;Para abrir servidor web
		   (cg-tex-principal "documento.tex"))) ;Archivo principal para las compilaciones de TeX
  (set (car elemento) (cadr elemento))
  (push (symbol-name (car elemento)) variables-completar))

;;Variables-parámetros-------------------------------------------------

(defconst cg-ignorar-lsp '("vendor" "var" "code-symfony")) ;Directorios que no vigilará lsp

;;---------------------------------------------------------------------

(defun comillas-o-string (v)
  (if (stringp v) (concat "\"" v "\"") (number-to-string v)))

(defun cambiar-valor (var valor)
  "Quita el valor que había en la variable «var» y pone «valor»."
  (set (intern var) valor)
  (setq valor (comillas-o-string valor))
  (let ((directorio (directorio-cg "variables.el")))
	(with-temp-file directorio
	  (insert-file-contents directorio)
	  (search-forward var)
	  (let ((p (point)))
		(skip-chars-forward "^)")
		(delete-region p (point))
		(insert ?\s valor)))
	(message "Puesto en la variable «%s» el valor %s" var valor)))

(defun cg-cambiar-variable (&optional var)
  "Pide el nombre de la variable si no se suministra (por ejemplo si se llama interactivamente);
   pide luego el nombre del nuevo valor y llama a «cambiar-valor»."
  (interactive)
  (cambiar-valor (or var (completing-read " Nombre de la variable: " variables-completar))
					 (read-minibuffer " Valor para la variable: " (comillas-o-string (eval (intern var))))))

