#lang racket/gui
(require "../datos.rkt")
(require "../logica.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;publico
;--------------------------------------------------------------------------------------------------------------------------------
(provide ventana-registrar)
;--------------------------------------------------------------------------------------------------------------------------------
;ventana-registrar
;--------------------------------------------------------------------------------------------------------------------------------
;variables
;--------------------------------------------------------------------------------------------------------------------------------
(define ciudad "")
(define barrio "")
;--------------------------------------------------------------------------------------------------------------------------------
(define ventana-registrar
  (new frame%[label"Aquabot"][stretchable-width #f][stretchable-height #f]))

(define list-registrar-ciudades
   (new list-box%
         [label "Ciudad:\t\t "]
         [parent ventana-registrar]
         [choices (get-ciudades-sql) ]
         [callback (lambda (c e)(set-list-barrios (send list-registrar-ciudades get-selections)))]))

(define list-registrar-barrios
   (new list-box%
         [label "Barrio:\t\t "]
         [parent ventana-registrar]
         [choices (list)]
         [callback (lambda (c e)(set! barrio (send list-registrar-barrios get-string (car (send list-registrar-ciudades get-selections)))))]))

(define txt-registrar-identidad
  (new text-field%
       [parent ventana-registrar]
       [min-height 10]
       [min-width 150]
       [label "Identidad:\t"]))

(define txt-registrar-clave
  (new text-field%
       [parent ventana-registrar]
       [min-height 10]
       [min-width 150]
       [label "Clave:\t\t"]))

(define txt-registrar-nombres
  (new text-field%
       [parent ventana-registrar]
       [min-height 10]
       [min-width 150]
       [label "Nombres:\t"]))

(define panel-regi1
  (new horizontal-panel% [parent ventana-registrar][alignment '(center center)]))

(define txt-registrar-apellido1
  (new text-field%
       [parent panel-regi1]
       [min-height 10]
       [min-width 150]
       [label "Apellido1:\t"]))

(define txt-registrar-apellido2
  (new text-field%
       [parent panel-regi1]
       [min-height 10]
       [min-width 150]
       [label "Apellido2:\t"]))

(define txt-registrar-telefono
  (new text-field%
       [parent ventana-registrar]
       [min-height 10]
       [min-width 150]
       [label "Telefono:\t"]))

(define txt-registrar-direccion
  (new text-field%
       [parent ventana-registrar]
       [min-height 10]
       [min-width 150]
       [label "Direccion:\t"]))

(new button%[parent ventana-registrar][label "Registrar"][callback (lambda (boton evento) (enviar-registro))])

(define (enviar-registro)
  (registrar-sql ciudad barrio
                 (send txt-registrar-identidad get-value)
                 (send txt-registrar-clave get-value)
                 (send txt-registrar-nombres get-value)
                 (send txt-registrar-apellido1 get-value)
                 (send txt-registrar-apellido2 get-value)
                 (send txt-registrar-telefono get-value)
                 (send txt-registrar-direccion get-value)))

(define (set-list-barrios indice)
  (set! ciudad (send list-registrar-ciudades get-string (car indice)))
  (send list-registrar-barrios set (get-barrios-sql ciudad)))
;--------------------------------------------------------------------------------------------------------------------------------