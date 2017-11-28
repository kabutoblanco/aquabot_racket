#lang racket/gui
(require "../datos.rkt")
(require "ventana-menu.rkt")
(require "ventana-mensaje.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;publico
;--------------------------------------------------------------------------------------------------------------------------------
(provide ventana-ingresar)
;--------------------------------------------------------------------------------------------------------------------------------
;ventana-ingresar
;--------------------------------------------------------------------------------------------------------------------------------
(define ventana-ingresar
  (new frame%[label "Aquabot"][stretchable-width #f] [stretchable-height #f]))

(new message%
     [min-height 10]
     [min-width 300]
     [parent ventana-ingresar]
     [label ""])

(define txt-ingresar-identidad
  (new text-field%
       [parent ventana-ingresar]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Identidad:\t"]))

(define txt-ingresar-clave
  (new text-field%
       [parent ventana-ingresar]
       [style '(single password)]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]       
       [label "Clave:\t\t"]))

(new button%
       (vert-margin 20)
       [parent ventana-ingresar]
       [label "Entrar"]
       [callback (lambda (boton event) (verificar-perfil))])

(define (verificar-perfil)
  (if (equal? #t (autenticar (send txt-ingresar-identidad get-value) (send txt-ingresar-clave get-value)))
      (abrir-perfil)
      (abrir-mensaje "usuario erroneo")))

(define (abrir-perfil)
  (get-usuario-autenticado (send txt-ingresar-identidad get-value) (send txt-ingresar-clave get-value))
  (send ventana-menu show #t)
  (send ventana-ingresar show #f))
;--------------------------------------------------------------------------------------------------------------------------------