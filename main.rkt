#lang racket
(require racket/gui/base)
(require db)

;--------------------------------------
;conexion base datos
(define conexion
  (mysql-connect #:server "localhost"
                 #:port 1520
                 #:database "aquabot"
                 #:user "root"))
;--------------------------------------

;--------------------------------------
;gui
;--------------------------------------

;--------------------------------------
;logica
(query-rows conexion "select * from USUARIOS")
;--------------------------------------