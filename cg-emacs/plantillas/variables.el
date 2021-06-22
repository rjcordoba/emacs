;------------------------------------------------------------------------
;  Variables para que actúen como parámetros para diferentes funciones
;  y que sean fáciles de cambiar. Las expresiones son válidas en Elisp
;  pero la expresión general no lo es; es decir, no es un archivo compilable
;------------------------------------------------------------------------

backups "~/cosas/proyectos/.backups" ;Directorio donde se guardan los archivos backup
servidor "symfony server:start" ;Para abrir servidor web
ignorar-lsp ("vendor" "var" "code-symfony") ;Directorios que no vigilará lsp

