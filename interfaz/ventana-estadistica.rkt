#lang racket/gui
(require "../datos.rkt")
(require "../logica.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;publico
;--------------------------------------------------------------------------------------------------------------------------------
(provide ventana-estadistica)
;--------------------------------------------------------------------------------------------------------------------------------
;ventana-estadistica
;--------------------------------------------------------------------------------------------------------------------------------
(define ventana-estadistica
  (new frame%[ label "Estadisticas"][stretchable-width #f] [stretchable-height #f]))

(define estadisticas
  (new message%
       [min-height 30]
       [min-width 300]
       [parent ventana-estadistica]
       [label "\tEstadisticas"]))

(define txt_datos1_estadistica
  (new text-field%
       [parent ventana-estadistica]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo promedio de la cuidad:"]))

(define txt_datos2_estadistica
  (new text-field%
       [parent ventana-estadistica]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Esperanza de vida agua:\t\t"]))

(define txt_datos3_estadistica
  (new text-field%
       [parent ventana-estadistica]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Valor m3 dentro de X años:\t"]))

(define txt_datos4_estadistica
  (new text-field%
       [parent ventana-estadistica]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Desperdicio en x meses:\t\t"]))
;--------------------------------------------------------------------------------------------------------------------------------