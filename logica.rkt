#lang racket
(require "datos.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;publico
;--------------------------------------------------------------------------------------------------------------------------------
(provide caddddr cadddddr caddddddr cadddddddr valor-metro3 get-consumos)
;--------------------------------------------------------------------------------------------------------------------------------
;servicios basicos
;--------------------------------------------------------------------------------------------------------------------------------
(define (caddddr lista) (car-i lista 0 4))
(define (cadddddr lista) (car-i lista 0 5))
(define (caddddddr lista) (car-i lista 0 6))
(define (cadddddddr lista) (car-i lista 0 7))
(define (car-i lista i n) (if (= i n) (car lista) (car-i (cdr lista) (+ i 1) n)))

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

(define (varianza-r lista promedio cantidad r)
  (if (null? lista)
      (if (= cantidad 0)
          0
          (/ r cantidad))
      (varianza-r (cdr lista) promedio cantidad (+ r (expt (- (car lista) promedio) 2)))))
(define w 0)
(set! w (varianza-r x z (- (car y) 1) 0))
(println "varianza")w

;varianza
(define (varianza lista)
  (varianza-r lista (media (suma lista 0) (list (length lista))) (- (length lista) 1) 0))

;desviacion
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
;servicios funcionales
;--------------------------------------------------------------------------------------------------------------------------------
;calcular el valor en pesos colombinos del metro cubico de agua segun algunos criterios
(define (valor-metro3 consumo1 consumo2 estrato)
  (println consumo1) (println consumo2)
  (if (< consumo1 0) (set! consumo1 (+ consumo2 1)) (set consumo1 consumo1))
  (if (= consumo2 0) (set! consumo1 (+ consumo2 1)) (set consumo1 consumo1))
  (println consumo1) (println consumo2)
  (cond
    [(<= (- consumo1 consumo2) 0)  (/ (* estrato 16) 5)]
    [(<= (- consumo1 consumo2) 2)  (* (/ (- consumo1 consumo2) (* estrato 18)) 10000)]
    [(<= (- consumo1 consumo2) 5)  (* (/ (- consumo1 consumo2) (* estrato 17)) 10000)]
    [(<= (- consumo1 consumo2) 8)  (* (/ (- consumo1 consumo2) (* estrato 16)) 10000)]
    [(<= (- consumo1 consumo2) 11) (* (/ (- consumo1 consumo2) (* estrato 15)) 10000)]
    [(>  (- consumo1 consumo2) 11) (* (/ (- consumo1 consumo2) (* estrato 12)) 10000)]))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna una lista con los consumos de la 'lista'
(define (get-consumos lista lista2)
  (if (> (length lista) 1)      
      (get-consumos (cdr lista) (cons (- (car lista) (cadr lista)) lista2))
      (reverse lista2)))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna una recomendacion para usuario respecto a él
(define (get-recomendacion-usuario registros)
  (println "desviacion")
  (println (desviacion (varianza registros)))
  (println (- (car (moda-r (sort registros >) moda-i)) (desviacion (varianza registros)))))

(get-recomendacion-usuario (consumo-actual-usuario-sql 1))
;--------------------------------------------------------------------------------------------------------------------------------