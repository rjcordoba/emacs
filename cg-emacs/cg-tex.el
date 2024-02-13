;; -*- lexical-binding: t -*-
;------------------------------------------------------------------
;    Archivo de configuración de Emacs - R. Córdoba García
;    Utilidades para el modo TeX
;------------------------------------------------------------------

(setq tex-default-mode 'plain-tex-mode)
(declare-function doc-view-fit-height-to-window "tex-mode")
(declare-function tex-buffer "tex-mode")
(declare-function tex-compile "tex-mode")

(setq tex-run-command "xetex")
(setq tex-print-file-extension ".pdf")
(setq tex-dvi-view-command "xdg-open")
(defconst cg-tex-principal "documento.tex" "Archivo TeX principal, por el que empezará la compilación.")

(defun cg-tex-insertar-macro ()
  "Pregunta por nombre y número e inserta secuencia de control con parámetros según el número seleccionado."
  (interactive)
  (let ((nombre (read-string " Nombre de secuencia: "))
		(num (string-to-number (read-string " Número de argumentos: "))))
	(insert "\\def\\" nombre)
	(dotimes (i num)
	  (insert "#" (number-to-string (1+ i))))
	(insert "{}") (backward-char)))

(defun cg-tex-math ()
  "Pone símbolos de dólar para entrar en math mode."
  (interactive)
  (insert "$  $")
  (backward-char 2))

(defun cg-tex-math-display ()
  "Pone símbolos de dólar para entrar en display math mode."
  (interactive)
  (insert "$$  $$")
  (backward-char 3))

(let ((ventanta-pdf)) ;;Ventana que muestra el pdf.
  (defun cg-tex-mover-documento (f)
	"Auxiliar para mover el documento pdf sin estar en la ventana que lo muestra."
	(if (window-live-p ventana-pdf) (otra-ventana f ventanta-pdf) (error "No está establecido el escritorio TeX.")))

  (defun cg-tex-conf-escritorio ()
	"Pone las ventanas para establecer un escritorio de trabajo para TeX."
	(interactive)
	(let ((d (or tex-main-file (setq tex-main-file (concat cg-origen "/" cg-tex-principal)))))
	  (delete-other-windows)
	  (setq ventanta-pdf (select-window (split-window nil -126 t)))
	  (switch-to-buffer "*tex-shell*")
	  (set-window-dedicated-p (split-window nil -18 'below) 'dedicada)
	  (find-file (concat tex-main-file tex-print-file-extension))
	  (set-window-dedicated-p (selected-window) 'dedicada)
	  (auto-revert-mode)
	  (if (> (buffer-size) 0) (doc-view-fit-height-to-window))
	  (other-window -1)
	  (select-window (split-window-below))
	  (find-file d)
	  (find-file (concat cg-origen "/formato.tex"))
	  (auto-fill-mode -1)
	  (other-window -1))))

(defun cg-tex-compilar ()
  "Compila el archivo con XeTeX."
  (interactive)
  (if (use-region-p)
	  (tex-buffer)
	  (tex-compile cg-origen (concat "xetex " cg-tex-principal))))

(cg-configs-modo
 :poner
 (("C-j" . nil)
  ("<C-return>" . nil)
  ("C-c m" . cg-tex-insertar-macro)
  ("C-0" . cg-tex-math)
  ("C-=" . cg-tex-math-display)
  ("C-c j" . tex-terminate-paragraph)
  ("C-c v" . tex-validate-region)
  ("<f5>" . cg-tex-compilar)
  ("S-<f5>" . tex-file)
  ("C-<f5>" . cg-tex-conf-escritorio)
  ("C-c f" . tex-feed-input)
  ("<up>" . (λ (cg-tex-mover-documento 'doc-view-previous-page)))
  ("<down>" . (λ (cg-tex-mover-documento 'doc-view-next-page)))
  ("M-<up>" . (λ (cg-tex-mover-documento 'doc-view-first-page)))
  ("M-<down>" . (λ (cg-tex-mover-documento 'doc-view-last-page)))
  ("C-c k" . (λ (search-backward "$")))
  ("C-c l" . (λ (search-forward "$")))
  ("M-k" . (λ (cg-inicio-nido ?{)))
  ("M-l" . (λ (cg-fin-nido ?{))))
 :añadir-hook
 (lambda ()
   (setq fill-column 100)
   (auto-fill-mode)))
