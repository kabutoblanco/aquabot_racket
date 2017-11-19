#lang racket
(require racket/gui/base)
(require db)

;--------------------------------------
;conexion base datos
(define conexion
  (mysql-connect #:server "localhost"
                 #:port 1520
                 #:database "aquabot"
                 #:user "root"))
;--------------------------------------

;--------------------------------------
;gui
;--------------------------------------

;--------------------------------------
;logica
(define (consumos contId) (query-list conexion "select histRegistro from HISTORIALES where contId = contId"))
(define (num_consumos contId) (query-list conexion "select count(*) from HISTORIALES where contId = contId"))

(define x 0)
(set! x (consumos 1))
x

(define y 0)
(set! y (num_consumos 1))

(define (suma lista r) (if (null? lista) r (suma (cdr lista) (+ r (car lista)))))

(define e 0)
(set! e (suma x 0))

(define (media suma cantidad) (/ suma (car cantidad)))
(define z 0)
(set! z (media e y))
z

(define (varianza lista promedio cantidad r) (if (null? lista) (/ r cantidad) (varianza (cdr lista) promedio cantidad (+ r (expt (- (car lista) promedio) 2)))))
(define w 0)
(set! w (varianza x z (- (car y) 1) 0))
w

(define (desviacion varianza) (sqrt varianza))
(define q 0)
(set! q (desviacion w))
q

(define (mediana-r lista paridad n i)
  (if (= paridad 0)
      (if (= (- (floor (/ n 2)) 1) i)
          (/ (+ (car lista) (car (cdr lista))) 2)
          (mediana-r (cdr lista) paridad n (+ i 1)))
      (if (= (floor (/ n 2)) i)
          (car lista)
          (mediana-r (cdr lista) paridad n (+ i 1)))
      ))
(define (mediana lista paridad n) (if (null? lista) (0) (mediana-r lista paridad n 0)))
(define t 0)
(set! t (mediana (sort x <) (modulo (car y) 2) (car y)))
t
;--------------------------------------
