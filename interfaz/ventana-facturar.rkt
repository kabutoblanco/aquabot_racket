#lang racket/gui
(require "../datos.rkt")
(require "../logica.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;publico
;--------------------------------------------------------------------------------------------------------------------------------
(provide ventana-facturar)
(provide llenar-factura)
;--------------------------------------------------------------------------------------------------------------------------------
;ventana-facturar
;--------------------------------------------------------------------------------------------------------------------------------
(define ventana-facturar
  (new frame%[label "Facturar"][stretchable-width #f] [stretchable-height #f]))

(define panel-facturas
  (new panel%[parent ventana-facturar][horiz-margin 50][alignment '(center center)][min-width 190][min-height 100]))

(define canvas-facturas (new canvas% [parent panel-facturas]))

(define dc (send canvas-facturas get-dc))
(define blue-brush (make-object brush% "BLUE" 'solid))

(define (pintar-facturas lista dc i x)
  (cond [(null? lista) (println "ok")]
  [else (send dc set-brush blue-brush) (send dc draw-rectangle (+ x (* i 10)) (- 100 (car lista)) 30 (car lista)) (pintar-facturas (cdr lista) dc (+ i 1) (+ x 30))]))

(define txt-facturar-mes1
  (new text-field%
       [parent ventana-facturar]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes anterior 1:\t"]))

(define txt-facturar-mes2
  (new text-field%
       [parent ventana-facturar]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes anterior 2:\t"]))

(define txt-facturar-mes3
  (new text-field%
       [parent ventana-facturar]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes anterior 3:\t"]))

(define txt-facturar-mes4
  (new text-field%
       [parent ventana-facturar]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes anterior 4:\t"]))

(define txt-facturar-mes5
  (new text-field%
       [parent ventana-facturar]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes pasado:\t\t"]))

(define panel-fact1
  (new horizontal-panel% [parent ventana-facturar][alignment '(center center)]))

(define txt-facturar-lectura1
  (new text-field%
       [parent panel-fact1]
       [label "Lectura anterior:\t"]))
(define txt-facturar-usuario1
  (new text-field%
       [parent panel-fact1]
       [label "Usuario mayor consumo:\t"]))

(define panel-fact2
  (new horizontal-panel% [parent ventana-facturar][alignment '(center center)]))

(define txt-facturar-lectura2
  (new text-field% [parent panel-fact2][label "Lectura actual:\t\t"]))
(define txt-facturar-usuario2
  (new text-field% [parent panel-fact2][label "Usuario menor consumo:\t"]))

(define panel-fact3
  (new horizontal-panel% [parent ventana-facturar][alignment '(center center)]))

(define txt-facturar-consumo
  (new text-field% [parent panel-fact3][label "Consumo:\t\t\t"]))
(define txt-facturar-m3
  (new text-field% [parent panel-fact3][label "Valor m3:\t\t\t\t\t"]))

(define text-facturar-pagar
  (new text-field%
       [parent ventana-facturar]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Total a pagar:"]))


(define panel-fact4
  (new horizontal-panel% [parent ventana-facturar][alignment '(center center)]))

(new button%[parent panel-fact4][label"Simular"])
(new button%[parent panel-fact4][label"Cancelar"]) 

(define lecturas (list))
(define consumos (list))

(define (llenar-factura)
  (get-usuario-autenticado (caddr usuario-sistema) (caddddr usuario-sistema))
  (get-casa (car usuario-sistema))
  (set! lecturas (contador-registros-sql (car (get-contador-sql (car casa-sistema))) 10))
  (set! consumos (get-consumos lecturas (list)))
  (if (>= (length consumos) 1) (send txt-facturar-mes5 set-value (number->string(car consumos))) (send txt-facturar-mes5 set-value "0"))
  (if (>= (length consumos) 2) (send txt-facturar-mes1 set-value (number->string(cadr consumos))) (send txt-facturar-mes1 set-value "0"))
  (if (>= (length consumos) 3) (send txt-facturar-mes2 set-value (number->string(caddr consumos))) (send txt-facturar-mes2 set-value "0"))
  (if (>= (length consumos) 4) (send txt-facturar-mes3 set-value (number->string(cadddr consumos))) (send txt-facturar-mes3 set-value "0"))
  (if (>= (length consumos) 5) (send txt-facturar-mes4 set-value (number->string(caddddr consumos))) (send txt-facturar-mes4 set-value "0"))
  (if (>= (length lecturas) 1) (send txt-facturar-lectura1 set-value (number->string(car lecturas))) (send txt-facturar-lectura1 set-value "0"))
  (if (=  (length (get-lectura-actual (car casa-sistema))) 1) (send txt-facturar-lectura2 set-value (number->string(car (get-lectura-actual (car casa-sistema))))) (send txt-facturar-lectura2 set-value "0"))
  (send txt-facturar-consumo set-value (number->string(- (string->number(send txt-facturar-lectura2 get-value)) (string->number(send txt-facturar-lectura1 get-value)))))
  (get-usuario-consumo (car (get-contador-sql (car casa-sistema))) > 0)(send txt-facturar-usuario1 set-value (car usuario-consumo))
  (get-usuario-consumo (car (get-contador-sql (car casa-sistema))) < 0)(send txt-facturar-usuario2 set-value (car usuario-consumo))
  (send txt-facturar-m3 set-value (number->string(floor (valor-metro3 (string->number(send txt-facturar-consumo get-value)) (string->number(send txt-facturar-mes1 get-value)) (caddr casa-sistema) (consumo-actual-usuario-sql (car usuario-sistema))))))
  (send text-facturar-pagar set-value (number->string(floor(* (string->number(send txt-facturar-m3 get-value)) (string->number(send txt-facturar-consumo get-value))))))
  (send panel-facturas refresh)(sleep/yield 1)(pintar-facturas consumos dc 0 0))
;--------------------------------------------------------------------------------------------------------------------------------