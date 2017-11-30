#lang racket/gui
(require "ventana-registrar.rkt")
(require "ventana-facturar.rkt")
(require "ventana-recomendar.rkt")
(require "ventana-estadistica.rkt")
(require "../datos.rkt")
(require "../logica.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;publico
;--------------------------------------------------------------------------------------------------------------------------------
(provide ventana-menu)
;--------------------------------------------------------------------------------------------------------------------------------
;ventana-menu
;--------------------------------------------------------------------------------------------------------------------------------
(define ventana-menu
  (new frame%[label "Aquabot"][stretchable-width #f] [stretchable-height #f]))

(new button%
     [parent ventana-menu]
     [label "Perfil"]
     (vert-margin 10)
     (horiz-margin 50)
     [min-width 150]
     [callback (lambda (boton evento) (send ventana-registrar show #t) (nueva-configuracion 2) (limpiar-ventana) (llenar-perfil))])

(new button%
     [parent ventana-menu]
     [label "Facturación"]
     (vert-margin 10)
     (horiz-margin 50)
     [min-width 150]
     [callback (lambda (boton evento) (send ventana-facturar show #t) (llenar-factura))])

(new button%
     [parent ventana-menu]
     [label "Recomendaciones"]
     (vert-margin 10)
     (horiz-margin 50)
     [min-width 150]
     [callback (lambda (boton evento) (send ventana-recomendar show #t) (llenar-recomendar))])

(new button%
     [parent ventana-menu]
     [label "Estadisticas"]
     (vert-margin 10)
     (horiz-margin 50)
     [min-width 150]
     [callback (lambda (boton evento) (send ventana-estadistica show #t) (llenar-estadistica))])
;--------------------------------------------------------------------------------------------------------------------------------