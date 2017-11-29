#lang racket
(require "datos.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;publico
;--------------------------------------------------------------------------------------------------------------------------------
(provide caddddr cadddddr caddddddr cadddddddr valor-metro3 get-consumos get-string get-recomendacion-consumo
         get-recomendacion-habitos)
;--------------------------------------------------------------------------------------------------------------------------------
;servicios basicos
;--------------------------------------------------------------------------------------------------------------------------------
(define (caddddr lista) (car-i lista 4))
(define (cadddddr lista) (car-i lista 5))
(define (caddddddr lista) (car-i lista 6))
(define (cadddddddr lista) (car-i lista 7))
;--------------------------------------------------------------------------------------------------------------------------------
(define (car-i-r lista i n) (if (= i n) (car lista) (car-i-r (cdr lista) (+ i 1) n)))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna el n-esimo elemento de una 'lista'
(define (car-i lista n) (car-i-r lista 0 n))
;--------------------------------------------------------------------------------------------------------------------------------
(define (indice-r lista x i bool)
  (if (or (null? lista) (equal? bool #t))
      i
      (if (= (car lista) x)
          (indice-r (cdr lista) (car lista) (+ i 1) #t)
          (indice-r (cdr lista) x (+ i 1) bool))))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna la primera ocurrencia del elemento mayor
(define (max-i lista) (indice-r lista (get-item lista >) -1 #f))
;retorna la primera ocurrencia del elemento menor
(define (min-i lista) (indice-r lista (get-item lista <) -1 #f))
;--------------------------------------------------------------------------------------------------------------------------------
(define (get-item-r lista x tipo)
  (if (null? lista)
      x
      (if (tipo (car lista) x)
          (get-item-r (cdr lista) (car lista) tipo)
          (get-item-r (cdr lista) x tipo))))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna el indice de una 'lista' segun sea el tipo (> o <)
(define (get-item lista tipo) (get-item-r lista (car lista) tipo))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna el valor string de una 'valor'
(define (get-string valor)
  (if (number? valor) (number->string valor) (valor)))
;--------------------------------------------------------------------------------------------------------------------------------
(define (suma-r lista r)
  (if (null? lista)
      r
      (suma-r (cdr lista) (+ r (car lista)))))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna la suma de los elementos de una 'lista'
(define (suma lista) (suma-r lista 0))
;--------------------------------------------------------------------------------------------------------------------------------
(define (media-r suma cantidad)
  (if (null? cantidad) 0
      (if (= cantidad 0)
          0
          (/ suma cantidad))))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna la media de los elementos de una 'lista'
(define (media lista) (media-r (suma lista) (length lista)))
;--------------------------------------------------------------------------------------------------------------------------------
(define (varianza-r lista media cantidad r)
  (if (null? lista)
      (if (= cantidad 0)
          0
          (/ r cantidad))
      (varianza-r (cdr lista) media cantidad (+ r (expt (- (car lista) media) 2)))))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna la varianza de los elementos de una 'lista'
(define (varianza lista)
  (varianza-r lista (media lista) (- (length lista) 1) 0))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna la desviacion de los elementos de una 'lista'
(define (desviacion varianza) (sqrt varianza))
;--------------------------------------------------------------------------------------------------------------------------------
(define (mediana-r lista paridad n i)
  (if (= paridad 0)
      (if (= (- (floor (/ n 2)) 1) i)
          (/ (+ (car lista) (car (cdr lista))) 2)
          (mediana-r (cdr lista) paridad n (+ i 1)))
      (if (= (floor (/ n 2)) i)
          (car lista)
          (mediana-r (cdr lista) paridad n (+ i 1)))
      ))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna la mediana de los elementos de una 'lista'
(define (mediana lista paridad n)
  (if (null? lista)
      0
      (mediana-r lista paridad n 0)))
;--------------------------------------------------------------------------------------------------------------------------------
(define (contar-r lista n r)
  (if (null? lista)
      r
      (if (equal? (car lista) n)
          (contar-r (cdr lista) n (+ r 1))
          (contar-r (cdr lista) n r))))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna el numero de los elementos de una 'lista'
(define (contar lista n) (contar-r lista n 0))
;--------------------------------------------------------------------------------------------------------------------------------
(define (moda-r lista lista2 r tipo)
  (if (null? lista)
      r
      (if (and (> (contar lista2 (car lista)) (car r)) (tipo (car lista) (cadr r)))
          (moda-r (cdr lista) lista2 (list (contar lista2 (car lista)) (car lista)) tipo)
          (moda-r (cdr lista) lista2 r tipo))))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna la moda de los elementos de una 'lista'
(define (moda lista tipo) (moda-r (sort lista tipo) lista (list 0 (car (filter max lista))) tipo))
;--------------------------------------------------------------------------------------------------------------------------------
;servicios funcionales
;--------------------------------------------------------------------------------------------------------------------------------
;calcular el valor en pesos colombianos del metro cubico de agua segun algunos criterios
(define (valor-metro3 consumo1 consumo2 estrato)
  (println (media (consumos-mes-sql 5)))
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
(define (get-recomendacion-consumo registros)
  (define porc-consumo (* 100 (/ (media registros) (car (moda (consumos-mes-actual-sql) >=)))))
  (cond
    [(< porc-consumo 10) "Estas ahorrando mucho ¡Excelente!"]
    [(< porc-consumo 30) "Ahorrando bien ¡Sigue así!"]
    [(< porc-consumo 50) "Vas mejorando en tu ahorro ¡Bien!"]
    [(< porc-consumo 70) "Vamos lento pero ahorras... bueno"]
    [(< porc-consumo 90) "Estas descuidando tu agua ¡Ojo!"]
    [(< porc-consumo 100) "Empeoraste ahorrando ¡Cuidado!"]
    [(> porc-consumo 101) "Mira el valor de tu factura ¡Te lo advertí!"]))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna una recomendacion para usuario respecto a consumo
(define (get-recomendacion-habitos registros)
  (define loca-general (get-suma-locaciones-sql))
  (define coci-general (list (* 100 (/ (car registros)(car loca-general)))(* 100 (/ (cadr registros)(cadr loca-general)))(* 100 (/ (caddr registros)(caddr loca-general)))(* 100 (/ (cadddr registros)(cadddr loca-general)))))
  (define indice (max-i coci-general))
  (cond
    [(< (car-i coci-general indice) 25)(string-append "Gastas poco en " (get-string-locacion (+ indice 1)))]
    [(< (car-i coci-general indice) 50)(string-append "Gastas un poquito en " (get-string-locacion (+ indice 1)))]
    [(< (car-i coci-general indice) 75)(string-append "Casi no ahorras en " (get-string-locacion (+ indice 1)))]
    [(< (car-i coci-general indice) 100)(string-append "Practicamente no ahorras en " (get-string-locacion (+ indice 1)))]
    [(> (car-i coci-general indice) 101)(string-append "Gastas mucho en " (get-string-locacion (+ indice 1)))]))

(define (get-string-locacion locacion)
  (cond
    [(= locacion 1) "la tina"]
    [(= locacion 2) "el lava platos"]
    [(= locacion 3) "el lava manos"]
    [(= locacion 4) "el inodoro"]))
;--------------------------------------------------------------------------------------------------------------------------------