#lang racket/gui
(require "../datos.rkt")
(require "../logica.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;publico
;--------------------------------------------------------------------------------------------------------------------------------
(provide ventana-recomendar)
;--------------------------------------------------------------------------------------------------------------------------------
;ventana-recomendar
;--------------------------------------------------------------------------------------------------------------------------------
(define ventana-recomendar
  (new frame%[label "Recomendaciones"][stretchable-width #f][stretchable-height #f]))

(define txt-recomendacion-usuario
  (new text-field%
       [parent ventana-recomendar]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Respecto a usuario:\t\t "]))

(define txt-recomendacion-consumo
  (new text-field%
       [parent ventana-recomendar]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Respecto a consumo:\t"]))

(define txt-recomendacion-habito
  (new text-field%
       [parent ventana-recomendar]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Respecto a habitos:\t\t"]))

(define panel-reco1
  (new horizontal-panel% [parent ventana-recomendar][alignment '(center center)]))

(define txt-recomendacion-lectura1
  (new text-field% [parent panel-reco1] [label "Lectura anterior:\t"]))
(define txt-recomendacion-usuario1
  (new text-field% [parent panel-reco1] [label "Usuario mayor consumo:\t"]))

(define panel-reco2
  (new horizontal-panel% [parent ventana-recomendar][alignment '(center center)]))

(define txt-recomendacion-lectura2
  (new text-field% [parent panel-reco2] [label "Lectura actual:\t\t"]))
(define txt-recomendacion-usuario2
  (new text-field% [parent panel-reco2] [label "Usuario menor consumo:\t"]))

(define txt_reco3_consumo
  (new text-field%
       [parent ventana-recomendar]
       (horiz-margin 75)
       [min-height 10]
       [min-width 75]
       [label "Consumos:"]))

(define panel-reco3
  (new horizontal-panel%[parent ventana-recomendar][alignment'(center center)]))

(new button%[parent panel-reco3][label"Simular"])
(new button%[parent panel-reco3][label"Cancelar"]) 
;--------------------------------------------------------------------------------------------------------------------------------