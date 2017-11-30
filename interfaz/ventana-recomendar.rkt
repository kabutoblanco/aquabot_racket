#lang racket/gui
(require "../datos.rkt")
(require "../logica.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;publico
;--------------------------------------------------------------------------------------------------------------------------------
(provide ventana-recomendar llenar-recomendar)
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
       [label "Respecto a usuario:\t\t"]))

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

(define txt-recomendacion-actual
  (new text-field%
       [parent ventana-recomendar]
       (horiz-margin 75)
       [min-height 10]
       [min-width 75]
       [label "Consumo:"]))

(define panel-reco3
  (new horizontal-panel%[parent ventana-recomendar][alignment'(center center)]))

(define lecturas (list))
(define consumos (list))

(define (llenar-recomendar)
  (set! lecturas (contador-registros-sql (car (get-contador-sql (car casa-sistema))) 10))
  (send txt-recomendacion-usuario set-value (get-recomendacion-usuario (consumo-actual-usuario-sql (car usuario-sistema)) (car casa-sistema)))
  (send txt-recomendacion-consumo set-value (get-recomendacion-consumo (consumo-actual-usuario-sql (car usuario-sistema))))
  (send txt-recomendacion-habito  set-value (get-recomendacion-habitos (get-suma-locaciones-id-sql (car usuario-sistema))))
  (if (>= (length lecturas) 1) (send txt-recomendacion-lectura1 set-value (number->string(car lecturas))) (send txt-recomendacion-lectura1 set-value "0"))
  (if (=  (length (get-lectura-actual (car casa-sistema))) 1) (send txt-recomendacion-lectura2 set-value (number->string(car (get-lectura-actual (car casa-sistema))))) (send txt-recomendacion-lectura2 set-value "0"))
  (get-usuario-consumo (car (get-contador-sql (car casa-sistema))) > 0)(send txt-recomendacion-usuario1 set-value (car usuario-consumo))
  (get-usuario-consumo (car (get-contador-sql (car casa-sistema))) < 0)(send txt-recomendacion-usuario2 set-value (car usuario-consumo))
  (send txt-recomendacion-actual set-value (number->string(- (string->number(send txt-recomendacion-lectura2 get-value)) (string->number(send txt-recomendacion-lectura1 get-value))))))

(new button%[parent panel-reco3][label"Simular"])
(new button%[parent panel-reco3][label"Cancelar"]) 
;--------------------------------------------------------------------------------------------------------------------------------