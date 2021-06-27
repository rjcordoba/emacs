;------------------------------------------------------------------------
;  Variables para que actúen como parámetros para diferentes funciones y
;  que sean fáciles de cambiar. Las expresiones individuales del archivo
;  son válidas en Elisp pero gramaticalmente no es correcto; es decir, no
;  es un ejecutable ni compilable.
; ------------------------------------------------------------------------

backups "~/cosas/proyectos/.backups" ;Directorio donde se guardan los archivos backup
servidor "symfony server:start" ;Para abrir servidor web
ignorar-lsp ("vendor" "var" "code-symfony") ;Directorios que no vigilará lsp
