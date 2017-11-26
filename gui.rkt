#lang racket
(require racket/gui/base)
(require "datos.rkt")
(require "logica.rkt")
(provide ventana)
;--------------------------------------------------------------------------------------------------------------------------------
;gui
;--------------------------------------------------------------------------------------------------------------------------------
(define mensaje
  (new frame%[label "error"]))

(define contenido-mensaje
  (new message%
       [min-height 30]
       [min-width 150]
       [parent mensaje]
       [label "error"]))

(define ventana
  (new frame%[label "Home"]))

(new message%
     [min-height 30]
     [min-width 300]
     [parent ventana]
     [label ""])

(new button%
     [parent ventana]
     [label "INGRESAR"]
     [callback (lambda (boton evento) (send ventana-ingresar show #t))])

(new button%
     [parent ventana]
     (vert-margin 20)
     [label "REGISTRAR"]
     [callback (lambda (boton evento) (send ventanaRegistrar show #t))])
;---------------------------------------------VENTANA INGRESAR--------------------------------------------------------------------------------------------
(define ventana-ingresar
  (new frame%[label "Aquabot"]))

(new message%
     [min-height 10]
     [min-width 300]
     [parent ventana-ingresar]
     [label ""])

(define txt-ingresar-identidad
  (new text-field%
       [parent ventana-ingresar]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Identidad:\t"]))

(define txt-ingresar-clave
  (new text-field%
       [parent ventana-ingresar]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Clave:\t\t"]))

(define botonEntrar
  (new button%
       (vert-margin 20)
       [parent ventana-ingresar]
       [label "Entrar"]
       [callback (lambda (boton event) (verificar-perfil))]))

(define (verificar-perfil)
  (if (equal? #t (autenticar (send txt-ingresar-identidad get-value) (send txt-ingresar-clave get-value)))
      (abrir-perfil)
      (send mensaje show #t)))

(define (abrir-perfil) (send ventana-entrar show #t) (send ventana-ingresar show #f) (send mensaje show #f))
;-------------------------------------------VENTANA ENTRAR----------------------------------------------------------------------------------------------
(define ventana-entrar
  (new frame%[label "Aquabot"]))

(new button%
     [parent ventana-entrar]
     [label "Perfil"]
     (vert-margin 10)
     (horiz-margin 50)
     [min-width 150]
     [callback (lambda (boton evento) (send ventana-perfil show #t) (llenar-perfil))])

(new button%
     [parent ventana-entrar]
     [label "Facturación"]
     (vert-margin 10)
     (horiz-margin 50)
     [min-width 150]
     [callback (lambda (boton evento) (send ventana-facturacion show #t) (llenar-factura))])

(new button%
     [parent ventana-entrar]
     [label "Recomendaciones"]
     (vert-margin 10)
     (horiz-margin 50)
     [min-width 150]
     [callback (lambda (boton evento) (send ventanaRecomendaciones show #t))])

(new button%
     [parent ventana-entrar]
     [label "Estadisticas"]
     (vert-margin 10)
     (horiz-margin 50)
     [min-width 150]
     [callback (lambda (boton evento) (send ventanaEstadisticas show #t))])

(define (llenar-perfil)
  (get-usuario-autenticado (send txt-ingresar-identidad get-value) (send txt-ingresar-clave get-value))
  (get-casa (car usuario-sistema))
  (send txt-perfil-identidad set-value (number->string (caddr usuario-sistema)))
  (send txt-perfil-nombres set-value (cadddr usuario-sistema))
  (send txt-perfil-apellidos set-value (string-append (caddddr usuario-sistema) " " (cadddddr usuario-sistema)))
  (send txt-perfil-telefono set-value (number->string (caddddddr usuario-sistema)))
  (send txt-perfil-estrato set-value (number->string (caddr casa-sistema)))
  (send txt-perfil-direccion set-value (cadddr casa-sistema)))

(define lecturas (list))
(define consumos (list))

(define (llenar-factura)
  (get-usuario-autenticado (send txt-ingresar-identidad get-value) (send txt-ingresar-clave get-value))
  (get-casa (car usuario-sistema))
  (set! lecturas (contador-consumos-sql (car (get-contador-sql (car casa-sistema))) 10))
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
  (send txt-facturar-m3 set-value (number->string(floor (valor-metro3 (string->number(send txt-facturar-consumo get-value)) (string->number(send txt-facturar-mes1 get-value)) (caddr casa-sistema)))))
  (send text-facturar-pagar set-value (number->string(floor(* (string->number(send txt-facturar-m3 get-value)) (string->number(send txt-facturar-consumo get-value)))))))
;-------------------------------------------VENTANA PERFIL----------------------------------------------------------------------------------------------
(define ventana-perfil
  (new frame%[label "Perfil"]))

(define txt-perfil-identidad
  (new text-field%
       [parent ventana-perfil]
       (vert-margin 10)
       (horiz-margin 50)
       [min-height 10]
       [min-width 250]
       [label "Identidad:\t"]))

(define txt-perfil-nombres
  (new text-field%
       [parent ventana-perfil]
       (vert-margin 10)
       (horiz-margin 50)
       [min-height 10]
       [min-width 250]
       [label "Nombres:\t"]))

(define txt-perfil-apellidos
  (new text-field%
       [parent ventana-perfil]
       (vert-margin 10)
       (horiz-margin 50)
       [min-height 10]
       [min-width 250]
       [label "Apellidos:\t"]))

(define txt-perfil-telefono
  (new text-field%
       [parent ventana-perfil]
       (vert-margin 10)
       (horiz-margin 50)
       [min-height 10]
       [min-width 250]
       [label "Telefono:\t"]))

(define txt-perfil-estrato
  (new text-field%
       [parent ventana-perfil]
       (vert-margin 10)
       (horiz-margin 50)
       [min-height 10]
       [min-width 250]
       [label "Estrato:\t"]))

(define txt-perfil-direccion
  (new text-field%
       [parent ventana-perfil]
       (vert-margin 10)
       (horiz-margin 50)
       [min-height 10]
       [min-width 250]
       [label "Direccion:\t"]))

(define panel
  (new horizontal-panel% [parent ventana-perfil][alignment'(center center)]))

(new button%[parent panel][label "Actualizar"])
(new button%[parent panel][label "Eliminar"])
;-------------------------------------------VENTANA ENCUESTA----------------------------------------------------------------------------------------------
(define ventanaEncuesta
  (new frame%[label "Encuesta"]))

(define Encuesta
  (new message%
       [min-height 30]
       [min-width 600]
       [parent ventanaEncuesta]
       [label ""]))

(define txt_pregunta1_encuesta
  (new text-field%
       [parent ventanaEncuesta]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "¿Cuantas veces usa el baño?:"]))

(define txt_pregunta2_encuesta
  (new text-field%
       [parent ventanaEncuesta]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "¿Cuantas libras de ropa lava día?:"]))

(define txt_pregunta3_encuesta
  (new text-field%
       [parent ventanaEncuesta]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "¿Cuantas veces al día te cepillas los dientes?:"]))

(define txt_pregunta4_encuesta
  (new text-field%
       [parent ventanaEncuesta]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "¿Cuantas veces sueltas el inodoro al día?:"]))

(define panelEncuesta
  (new horizontal-panel%[parent ventanaEncuesta][alignment'(center center)]))

(new button%[parent panelEncuesta][label"Guardar"])
(new button%[parent panelEncuesta][label"Ver Perfil"])
;-------------------------------------------VENTANA FACTURACION----------------------------------------------------------------------------------------------
(define ventana-facturacion
  (new frame%[label "Facturar"]))

(define txt-facturar-mes1
  (new text-field%
       [parent ventana-facturacion]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes anterior 1:\t"]))

(define txt-facturar-mes2
  (new text-field%
       [parent ventana-facturacion]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes anterior 2:\t"]))

(define txt-facturar-mes3
  (new text-field%
       [parent ventana-facturacion]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes anterior 3:\t"]))

(define txt-facturar-mes4
  (new text-field%
       [parent ventana-facturacion]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes anterior 4:\t"]))

(define txt-facturar-mes5
  (new text-field%
       [parent ventana-facturacion]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes pasado:\t\t"]))

(define panel-fact1
  (new horizontal-panel% [parent ventana-facturacion][alignment '(center center)]))

(define txt-facturar-lectura1
  (new text-field%
       [parent panel-fact1]
       [label "Lectura anterior:\t"]))
(define txt-facturar-usuario1
  (new text-field%
       [parent panel-fact1]
       [label "Usuario mayor consumo:\t"]))

(define panel-fact2
  (new horizontal-panel% [parent ventana-facturacion][alignment '(center center)]))

(define txt-facturar-lectura2
  (new text-field% [parent panel-fact2][label "Lectura actual:\t\t"]))
(define txt-facturar-usuario2
  (new text-field% [parent panel-fact2][label "Usuario menor consumo:\t"]))

(define panel-fact3
  (new horizontal-panel% [parent ventana-facturacion][alignment '(center center)]))

(define txt-facturar-consumo
  (new text-field% [parent panel-fact3][label "Consumo:\t\t\t"]))
(define txt-facturar-m3
  (new text-field% [parent panel-fact3][label "Valor m3:\t\t\t\t\t"]))

(define text-facturar-pagar
  (new text-field%
       [parent ventana-facturacion]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Total a pagar:"]))
;-------------------------------------------VENTANA RECOMENDACIONES----------------------------------------------------------------------------------------------
(define ventanaRecomendaciones
  (new frame%[ label "Recomendaciones"]))

(define recomendar
  (new message%
       [min-height 30]
       [min-width 600]
       [parent ventanaRecomendaciones]
       [label "\tRecomendaciones"]))

(define txt_reco1_recomendaciones
  (new text-field%
       [parent ventanaRecomendaciones]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Respecto a usuario:\t\t "]))

(define txt_reco2_recomendaciones
  (new text-field%
       [parent ventanaRecomendaciones]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Respecto a consumo:\t\t"]))

(define txt_reco3_recomendaciones
  (new text-field%
       [parent ventanaRecomendaciones]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Respecto a habitos:\t\t"]))

(define panelreco
  (new horizontal-panel% [parent ventanaRecomendaciones][alignment '(center center)]))

(new message% [parent panelreco] [label "Lectura anterior:\t"])
(new text-field% [parent panelreco] [label ""])
(new message% [parent panelreco] [label "\tUsuario mayor consumo:\t"])
(new text-field% [parent panelreco] [label ""])

(define panelreco1
  (new horizontal-panel% [parent ventanaRecomendaciones][alignment '(center center)]))

(new message% [parent panelreco1] [label "Lectura actual:\t"])
(new text-field% [parent panelreco1] [label ""])
(new message% [parent panelreco1] [label "\tUsuario menor consumo:\t"])
(new text-field% [parent panelreco1] [label ""])

(define panelreco2
  (new horizontal-panel% [parent ventanaRecomendaciones][alignment '(center center)]))

(new message% [parent panelreco2] [label "Consumo:\t"])
(new text-field% [parent panelreco2] [label ""])

(define panelRecomendaciones
  (new horizontal-panel%[parent ventanaRecomendaciones][alignment'(center center)]))

(new button%[parent panelRecomendaciones][label"Guardar"])
(new button%[parent panelRecomendaciones][label"Simular"])
(new button%[parent panelRecomendaciones][label"Cancelar"])
;-------------------------------------------VENTANA ESTADISTICAS----------------------------------------------------------------------------------------------
(define ventanaEstadisticas
  (new frame%[ label "Estadisticas"]))

(define estadisticas
  (new message%
       [min-height 30]
       [min-width 300]
       [parent ventanaEstadisticas]
       [label "\tEstadisticas"]))

(define txt_datos1_estadistica
  (new text-field%
       [parent ventanaEstadisticas]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo promedio de la cuidad:"]))

(define txt_datos2_estadistica
  (new text-field%
       [parent ventanaEstadisticas]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Esperanza de vida agua:\t\t"]))

(define txt_datos3_estadistica
  (new text-field%
       [parent ventanaEstadisticas]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Valor m3 dentro de X años:\t"]))

(define txt_datos4_estadistica
  (new text-field%
       [parent ventanaEstadisticas]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Desperdicio en x meses:\t\t"]))
;---------------------------------------------VENTANA REGISTRAR--------------------------------------------------------------------------------------------
(define ventanaRegistrar
  (new frame%[label "Aquabot"]))

(define titulo2
  (new message%
       [min-height 30]
       [min-width 300]
       [parent ventanaRegistrar]
       [label "\tRegistrar"]))
;==========================================================================================================================================================
;--------------------------------------
