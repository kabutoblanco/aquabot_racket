#lang racket/gui
(require "../datos.rkt")
(require "../logica.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;publico
;--------------------------------------------------------------------------------------------------------------------------------
(provide ventana-perfil)
(provide llenar-perfil)
;--------------------------------------------------------------------------------------------------------------------------------
;variables
;--------------------------------------------------------------------------------------------------------------------------------
(define ciudad "")
(define barrio "")
;--------------------------------------------------------------------------------------------------------------------------------
;ventana-perfil
;--------------------------------------------------------------------------------------------------------------------------------
(define ventana-perfil
  (new frame%[label "Perfil"][stretchable-width #f] [stretchable-height #f]))

(define list-registrar-ciudades
   (new list-box%
         [label "Ciudad:\t\t "]
         [parent ventana-perfil]
         [choices (get-ciudades-sql) ]
         [callback (lambda (c e)(set-list-barrios (send list-registrar-ciudades get-selections)))]))

(define list-registrar-barrios
   (new list-box%
         [label "Barrio:\t\t "]
         [parent ventana-perfil]
         [choices (list)]
         [callback (lambda (c e)(set! barrio (send list-registrar-barrios get-string (car (send list-registrar-ciudades get-selections)))))]))

(define txt-perfil-identidad
  (new text-field%
       [parent ventana-perfil]
       (horiz-margin 50)
       [min-height 10]
       [min-width 250]
       [label "Identidad:\t"]))

(define txt-perfil-nombres
  (new text-field%
       [parent ventana-perfil]
       (horiz-margin 50)
       [min-height 10]
       [min-width 250]
       [label "Nombres:\t"]))

(define txt-perfil-apellidos
  (new text-field%
       [parent ventana-perfil]
       (horiz-margin 50)
       [min-height 10]
       [min-width 250]
       [label "Apellidos:\t"]))

(define txt-perfil-telefono
  (new text-field%
       [parent ventana-perfil]
       (horiz-margin 50)
       [min-height 10]
       [min-width 250]
       [label "Telefono:\t"]))

(define txt-perfil-estrato
  (new text-field%
       [parent ventana-perfil]
       (horiz-margin 50)
       [min-height 10]
       [min-width 250]
       [label "Estrato:\t"]))

(define txt-perfil-direccion
  (new text-field%
       [parent ventana-perfil]
       (horiz-margin 50)
       [min-height 10]
       [min-width 250]
       [label "Direccion:\t"]))

(define panel
  (new horizontal-panel% [parent ventana-perfil][alignment'(center center)]))

(new button%[parent panel][label "Actualizar"][callback (lambda (boton evento)(actualizar-perfil))])
;--------------------------------------------------------------------------------------------------------------------------------
;configuracion-ventana
;--------------------------------------------------------------------------------------------------------------------------------
(define (actualizar-perfil)
  (define apellidos (string-split (send txt-perfil-apellidos get-value) " "))
  (actualizar-usuario
   (car usuario-sistema)
   (string->number(send txt-perfil-identidad get-value))
   (send txt-perfil-nombres get-value)
   (car apellidos)
   (cadr apellidos)
   (string->number(send txt-perfil-telefono get-value))
   (send txt-perfil-direccion get-value)))

(define (llenar-perfil)
  (get-usuario-autenticado (caddr usuario-sistema) (caddddr usuario-sistema))
  (get-casa (car usuario-sistema))
  (send txt-perfil-identidad set-value (number->string (caddr usuario-sistema)))
  (send txt-perfil-nombres set-value (caddddr usuario-sistema))
  (send txt-perfil-apellidos set-value (string-append (cadddddr usuario-sistema) " " (caddddddr usuario-sistema)))
  (send txt-perfil-telefono set-value (number->string (cadddddddr usuario-sistema)))
  (send txt-perfil-estrato set-value (number->string (caddr casa-sistema)))
  (send txt-perfil-direccion set-value (cadddr casa-sistema)))

(define (set-list-barrios indice)
  (set! ciudad (send list-registrar-ciudades get-string (car indice)))
  (send list-registrar-barrios set (get-barrios-sql ciudad)))
;--------------------------------------------------------------------------------------------------------------------------------