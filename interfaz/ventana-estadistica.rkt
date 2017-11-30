#lang racket/gui
(require "../datos.rkt")
(require "../logica.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;publico
;--------------------------------------------------------------------------------------------------------------------------------
(provide ventana-estadistica llenar-estadistica)
;--------------------------------------------------------------------------------------------------------------------------------
;ventana-estadistica
;--------------------------------------------------------------------------------------------------------------------------------
(define ventana-estadistica
  (new frame%[ label "Estadistica"][stretchable-width #f] [stretchable-height #f]))

(define txt-estadistica-ciudad
  (new text-field%
       [parent ventana-estadistica]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo promedio de la cuidad:\t"]))

(define txt-estadistica-vida
  (new text-field%
       [parent ventana-estadistica]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Esperanza de vida agua:\t\t\t"]))

(define txt-estadistica-valor
  (new text-field%
       [parent ventana-estadistica]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Valor m3 dentro de 10 años:\t\t"]))

(define txt-estadistica-desperdicio
  (new text-field%
       [parent ventana-estadistica]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Desperdicio ultimo mes:\t\t\t"]))

(define (llenar-estadistica)
  (send txt-estadistica-ciudad set-value (number->string(floor (get-promedio-ciudad (car casa-sistema)))))
  (send txt-estadistica-vida set-value (number->string(floor (get-vida-agua))))
  (send txt-estadistica-valor set-value (number->string(floor (/ (string->number (send txt-estadistica-vida get-value)) (* 10 10)))))
  (send txt-estadistica-desperdicio set-value (number->string(floor (get-desperdicio-mes (consumos-mes-sql 1))))))
;--------------------------------------------------------------------------------------------------------------------------------