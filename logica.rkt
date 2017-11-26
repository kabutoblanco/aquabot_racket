#lang racket
(require "datos.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;logica
;--------------------------------------------------------------------------------------------------------------------------------
(define x 0)
(set! x (consumo-actual-usuario-sql 1))
x

(define y 0)
(set! y (list(length x)))
y

(define (suma lista r)
  (if (null? lista)
      r
      (suma (cdr lista) (+ r (car lista)))))

(define e 0)
(set! e (suma x 0))

(define (media suma cantidad)
  (if (null? cantidad) 0
      (if (= (car cantidad) 0)
          0
          (/ suma (car cantidad)))))
(define z 0)
(set! z (media e y))
z

(define (varianza lista promedio cantidad r)
  (if (null? lista)
      (if (= cantidad 0)
          0
          (/ r cantidad))
      (varianza (cdr lista) promedio cantidad (+ r (expt (- (car lista) promedio) 2)))))
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
(define (mediana lista paridad n)
  (if (null? lista)
      0
      (mediana-r lista paridad n 0)))
(define t 0)
(set! t (mediana (sort x <) (modulo (car y) 2) (car y)))
t

(define moda-i (cons 0 0))

(define (contar-r lista n r)
  (if (null? lista)
      r
      (if (equal? (car lista) n)
          (contar-r (cdr lista) n (+ r 1))
          (contar-r (cdr lista) n r))))

(define (moda-r lista r)
  (if (null? lista)
      r
      (if (> (contar-r x (car lista) 0) (cdr r))
          (moda-r (cdr lista) (cons (car lista) (contar-r x (car lista) 0)))
          (moda-r (cdr lista) r))))

;media por consumo menor
(set! moda-i (moda-r (sort x <) moda-i))
moda-i

(set! moda-i (cons 0 0))

;media por consumo mayor
(set! moda-i (moda-r (sort x >) moda-i))
moda-i
;--------------------------------------------------------------------------------------------------------------------------------
