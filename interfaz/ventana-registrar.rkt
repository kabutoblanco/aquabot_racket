#lang racket/gui
(require "../datos.rkt")
(require "../logica.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;publico
;--------------------------------------------------------------------------------------------------------------------------------
(provide ventana-registrar nueva-configuracion llenar-perfil limpiar-ventana)
;--------------------------------------------------------------------------------------------------------------------------------
;ventana-registrar
;--------------------------------------------------------------------------------------------------------------------------------
;variables
;--------------------------------------------------------------------------------------------------------------------------------
(define configurar 0)
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
         [callback (lambda (c e)(set-txt-barrios (send list-registrar-barrios get-selections)))]))

(define panel-regi0
  (new horizontal-panel% [parent ventana-registrar][alignment '(center center)]))

(define txt-registrar-ciudad
  (new text-field%
       [parent panel-regi0]
       [min-height 10]
       [min-width 150]
       [enabled #f]
       [label "Ciudad:\t\t"]))

(define txt-registrar-barrio
  (new text-field%
       [parent panel-regi0]
       [min-height 10]
       [min-width 150]
       [enabled #f]
       [label "Barrio:\t"]))

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

(define txt-registrar-estrato
  (new text-field%
       [parent ventana-registrar]
       [min-height 10]
       [min-width 150]
       [label "Estrato:\t"]))

(define txt-registrar-direccion
  (new text-field%
       [parent ventana-registrar]
       [min-height 10]
       [min-width 150]
       [label "Direccion:\t"]))

(define boton-perfil
  (new button%[parent ventana-registrar][label "Registrar"][callback (lambda (boton evento) (enviar-configuracion))]))

(define (enviar-registro)
  (registrar-sql ciudad barrio
                 (string->number (send txt-registrar-identidad get-value))
                 (send txt-registrar-clave get-value)
                 (send txt-registrar-nombres get-value)
                 (send txt-registrar-apellido1 get-value)
                 (send txt-registrar-apellido2 get-value)
                 (string->number (send txt-registrar-telefono get-value))
                 (send txt-registrar-direccion get-value)))

(define (actualizar-perfil)
  (actualizar-usuario
   (car usuario-sistema)
   (send txt-registrar-ciudad get-value)
   (send txt-registrar-barrio get-value)
   (string->number(send txt-registrar-identidad get-value))
   (send txt-registrar-clave get-value)
   (send txt-registrar-nombres get-value)
   (send txt-registrar-apellido1 get-value)
   (send txt-registrar-apellido2 get-value)
   (string->number(send txt-registrar-telefono get-value))
   (send txt-registrar-direccion get-value)))

(define (enviar-configuracion)
  (cond
    [(= configurar 1) (enviar-registro)]
    [(= configurar 2) (actualizar-perfil)]))

(define (nueva-configuracion valor)
  (set! configurar valor)
  (cond
    [(= valor 1) (configurar-registro)]
    [(= valor 2) (configurar-perfil)]))

(define (configurar-registro)
  (send boton-perfil set-label "Registrar"))
(define (configurar-perfil)
  (send boton-perfil set-label "Actualizar"))

(define (set-list-barrios indice)
  (set! ciudad (send list-registrar-ciudades get-string (car indice)))
  (send txt-registrar-ciudad set-value ciudad)
  (send list-registrar-barrios set (get-barrios-sql ciudad)))

(define (set-txt-barrios indice)
  (set! barrio (send list-registrar-barrios get-string (car indice)))
  (send txt-registrar-barrio set-value barrio))

(define (llenar-perfil)
  (get-usuario-autenticado (caddr usuario-sistema) (caddddr usuario-sistema))
  (get-casa (car usuario-sistema))
  (define ciudad (get-ciudad (car casa-sistema)))
  (send txt-registrar-ciudad set-value (car ciudad))
  (send txt-registrar-barrio set-value (cadr ciudad))
  (send txt-registrar-identidad set-value (number->string (caddr usuario-sistema)))
  (send txt-registrar-nombres set-value (caddddr usuario-sistema))
  (send txt-registrar-apellido1 set-value (cadddddr usuario-sistema))
  (send txt-registrar-apellido2 set-value (caddddddr usuario-sistema))
  (send txt-registrar-telefono set-value (number->string (cadddddddr usuario-sistema)))
  (send txt-registrar-estrato set-value (number->string (caddr casa-sistema)))
  (send txt-registrar-direccion set-value (cadddr casa-sistema)))

(define (limpiar-ventana)
  (send txt-registrar-ciudad set-value "")
  (send txt-registrar-barrio set-value "")
  (send txt-registrar-identidad set-value "")
  (send txt-registrar-nombres set-value "")
  (send txt-registrar-apellido1 set-value "")
  (send txt-registrar-apellido2 set-value "")
  (send txt-registrar-telefono set-value "")
  (send txt-registrar-estrato set-value "")
  (send txt-registrar-direccion set-value ""))
;--------------------------------------------------------------------------------------------------------------------------------