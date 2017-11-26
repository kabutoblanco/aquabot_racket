#lang racket
(require racket/gui/base)
(require "datos.rkt")
(provide ventana)

;--------------------------------------
;gui

(define mensaje
  (new frame%[label "error"]))

(define titulo-mensaje
  (new message%
       [min-height 30]
       [min-width 150]
       [parent mensaje]
       [label "error"]))

(define ventana
  (new frame%[label "Home"]))

(define titulo_menu
  (new message%
       [min-height 30]
       [min-width 300]
       [parent ventana]
       [label ""]))

(define btn_registrar
  (new button%
       [parent ventana]
       [label "INGRESAR"]
       [callback (lambda (boton evento) (send ventanaIngresar show #t))]))

(define btn_Registrar
  (new button%
       [parent ventana]
       (vert-margin 20)
       [label "REGISTRAR"]
       [callback (lambda (boton evento) (send ventanaRegistrar show #t))]))
;---------------------------------------------VENTANA INGRESAR--------------------------------------------------------------------------------------------
(define ventanaIngresar
  (new frame%[label "Aquabot"]))

(define titulo
  (new message%
       [min-height 10]
       [min-width 300]
       [parent ventanaIngresar]
       [label ""]))

(define txt_identidad
  (new text-field%
       [parent ventanaIngresar]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Identidad:\t"]))

(define txt_clave
  (new text-field%
       [parent ventanaIngresar]
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Clave:\t\t"]))

(define botonEntrar
  (new button%
       (vert-margin 20)
       [parent ventanaIngresar]
       [label "Entrar"]
       [callback (lambda (boton event) (verificar-perfil))]))

(define (verificar-perfil)
  (if (equal? #t (autenticar (send txt_identidad get-value) (send txt_clave get-value)))
      (abrir-perfil)
      (send mensaje show #t)))

(define (abrir-perfil) (send ventanaEntrar show #t) (send ventanaIngresar show #f) (send mensaje show #f))
;-------------------------------------------VENTANA ENTRAR----------------------------------------------------------------------------------------------
(define ventanaEntrar
  (new frame%[ label "Aquabot"]))

(define entrar
  (new message%
       [min-height 10]
       [min-width 300]
       [parent ventanaEntrar]
       [label ""]))

(define btn_Perfil
  (new button%
       [parent ventanaEntrar]
       (vert-margin 15)
       [label "Perfil"]
       [min-width 150]
       [callback (lambda (boton evento) (send ventanaPerfil show #t))]))

(define btn_Facturacion
  (new button%
       [parent ventanaEntrar]
       (vert-margin 10)
       [label "Facturación"]
       [min-width 150]
       [callback (lambda (boton evento) (send ventanaFacturacion show #t))]))

(define btn_Recomendaciones
  (new button%
       [parent ventanaEntrar]
       (vert-margin 10)
       [label "Recomendaciones"]
       [min-width 150]
       [callback (lambda (boton evento) (send ventanaRecomendaciones show #t))]))

(define btn_Estadisticas
  (new button%
       [parent ventanaEntrar]
       (vert-margin 10)
       [label "Estadisticas"]
       [min-width 150]
       [callback (lambda (boton evento) (send ventanaEstadisticas show #t))]))
;-------------------------------------------VENTANA PERFIL----------------------------------------------------------------------------------------------
(define ventanaPerfil
  (new frame%[label "Perfil"]))

(define txt_usu_identidad
  (new text-field%
       [parent ventanaPerfil]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Identidad:"]))

(define txt_usu_nombres
  (new text-field%
       [parent ventanaPerfil]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Nombres:"]))

(define txt_usu_apellidos
  (new text-field%
       [parent ventanaPerfil]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Apellidos:"]))

(define txt_usu_telefono
  (new text-field%
       [parent ventanaPerfil]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Telefono:"]))

(define panel
  (new horizontal-panel% [parent ventanaPerfil] [alignment'(center center)]))

(new button%[parent panel][label"Registrar"])
(new button%[parent panel][label"Actualizar"])
(new button%[parent panel][label"Eliminar"])
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
(define ventanaFacturacion
  (new frame%[ label "Facturar"]))

(define facturar
  (new message%
       [min-height 30]
       [min-width 600]
       [parent ventanaFacturacion]
       [label "\tFacturar"]))

(define txt_consumo_encuesta
  (new text-field%
       [parent ventanaFacturacion]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes anterior 1:"]))

(define txt_consumo2_encuesta
  (new text-field%
       [parent ventanaFacturacion]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes anterior 2:"]))

(define txt_consumo3_encuesta
  (new text-field%
       [parent ventanaFacturacion]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes anterior 3:"]))

(define txt_consumo4_encuesta
  (new text-field%
       [parent ventanaFacturacion]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes anterior 4:"]))

(define txt_consumo_pasado_encuesta
  (new text-field%
       [parent ventanaFacturacion]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "Consumo mes pasado:\t"]))

(define panelfact
  (new horizontal-panel% [parent ventanaFacturacion][alignment '(center center)]))

(new message% [parent panelfact] [label "Lectura anterior:\t"])
(new text-field% [parent panelfact] [label ""])
(new message% [parent panelfact] [label "\tUsuario mayor consumo:\t\t"])
(new text-field% [parent panelfact] [label ""])

(define panelfact1
  (new horizontal-panel% [parent ventanaFacturacion][alignment '(center center)]))

(new message% [parent panelfact1] [label "Lectura actual:\t"])
(new text-field% [parent panelfact1] [label ""])
(new message% [parent panelfact1] [label "\tUsuario menor consumo:\t\t"])
(new text-field% [parent panelfact1] [label ""])

(define panelfact2
  (new horizontal-panel% [parent ventanaFacturacion][alignment '(center center)]))

(new message% [parent panelfact2] [label "Consumo:\t\t"])
(new text-field% [parent panelfact2] [label ""])
(new message% [parent panelfact2] [label "\tValor m3:\t\t\t\t\t"])
(new text-field% [parent panelfact2] [label ""])

(define panelfact3
  (new horizontal-panel% [parent ventanaFacturacion][alignment '(center center)]))

(new message% [parent panelfact3] [label "Total a pagar:\t"])
(new text-field% [parent panelfact3] [label ""])
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
