#lang racket/gui
(require "../datos.rkt")
(require "../logica.rkt")
(require "ventana-ingresar.rkt")
(require "ventana-registrar.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;publico
;--------------------------------------------------------------------------------------------------------------------------------
(provide ventana)
;--------------------------------------------------------------------------------------------------------------------------------
;ventana-principal
;--------------------------------------------------------------------------------------------------------------------------------
(define ventana
  (new frame%[label "Home"][stretchable-width #f][min-width 300][min-height 30][stretchable-height #f]))

(new button%
     [parent ventana]
     (vert-margin 10)
     [label "INGRESAR"]
     [callback (lambda (boton evento) (send ventana-ingresar show #t))])

(new button%
     [parent ventana]
     (vert-margin 10)
     [label "REGISTRAR"]
     [callback (lambda (boton evento) (send ventana-registrar show #t))])
;--------------------------------------------------------------------------------------------------------------------------------