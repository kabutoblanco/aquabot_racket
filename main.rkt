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
(define ventana
  (new frame%[ label "Home"])
  )
(define titulo_menu
  (new message%
       [min-height 30]
       [min-width 300]
       [parent ventana]
       [label ""]
   )
  )
(define btn_registrar (new button%
                          [parent ventana]
                          [label "INGRESAR"]
                          [callback (lambda (boton evento)
                                    ( send ventanaIngresar show #t )
                                    )
                          ]     

                          )
)

(define btn_Registrar (new button%
                          [parent ventana]
                          (vert-margin 20)
                          [label "REGISTRAR"]
                          [callback (lambda (boton evento)
                                    ( send ventanaRegistrar show #t )
                                    )
                          ]     

                          )
)





;---------------------------------------------VENTANA INGRESAR--------------------------------------------------------------------------------------------
(define ventanaIngresar
  (new frame%[ label "Aquabot"])
  )

(define titulo
  (new message%
       [min-height 10]
       [min-width 300]
       [parent ventanaIngresar]
       [label ""]
   )
  )
(define txt_usuario (new text-field%
  [parent ventanaIngresar]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Usuario:"]
  ))

(define txt_clave (new text-field%
  [parent ventanaIngresar]
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Clave:     "]
  ))
(define botonEntrar (new button%
                          (vert-margin 20)
                          [parent ventanaIngresar]
                          [label "Entrar"]
                          [callback (lambda (boton event)
                                      ( send ventanaEntrar show #t )
                                )
                          ]
                     )
)
;-------------------------------------------VENTANA ENTRAR----------------------------------------------------------------------------------------------
  (define ventanaEntrar
  (new frame%[ label "Aquabot"])
  )
(define entrar
  (new message%
       [min-height 10]
       [min-width 300]
       [parent ventanaEntrar]
       [label ""]
   )
  )
(define btn_Perfil (new button%
                          [parent ventanaEntrar]
                          (vert-margin 15)
                          [label "Perfil"]
                          [min-width 150]
                          [callback (lambda (boton evento)
                                    ( send ventanaPerfil show #t )
                                    )
                          ]     

                          )
)



(define btn_Facturacion (new button%
                          [parent ventanaEntrar]
                          (vert-margin 10)
                          [label "Facturación"]
                          [min-width 150]
                          [callback (lambda (boton evento)
                                    ( send ventanaFacturacion show #t )
                                    )
                          ]     

                          )
)
(define btn_Recomendaciones (new button%
                          [parent ventanaEntrar]
                          (vert-margin 10)
                          [label "Recomendaciones"]
                          [min-width 150]
                          [callback (lambda (boton evento)
                                    ( send ventanaRecomendaciones show #t )
                                    )
                          ]     

                          )
)
(define btn_Estadisticas (new button%
                          [parent ventanaEntrar]
                          (vert-margin 10)
                          [label "Estadisticas"]
                          [min-width 150]
                          [callback (lambda (boton evento)
                                    ( send ventanaEstadisticas show #t )
                                    )
                          ]     

                          )
)

;-------------------------------------------VENTANA PERFIL----------------------------------------------------------------------------------------------
  (define ventanaPerfil
  (new frame%[ label "Perfil"])
  )
(define perfil
  (new message%
       [min-height 30]
       [min-width 600]
       [parent ventanaPerfil]
       [label "\tPerfil"]
   )
  )

(define txt_usu_perfil (new text-field%
  [parent ventanaPerfil]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Usuario: "]
  ))

(define txt_usu_direccion (new text-field%
  [parent ventanaPerfil]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Direccion: "]
  ))

(define txt_usu_apodo (new text-field%
  [parent ventanaPerfil]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Apodo: "]
  ))

(define txt_usu_uso (new text-field%
  [parent ventanaPerfil]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Uso: "]
  ))

(define txt_usu_clave (new text-field%
  [parent ventanaPerfil]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Clave: "]
  ))

(define txt_usu_Contador (new text-field%
  [parent ventanaPerfil]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Contador: "]
  ))


(define panel(new horizontal-panel%[parent ventanaPerfil]
[alignment'(center center)]))

(new button%[parent panel][label"Registrar perfil"])
(new button%[parent panel][label"Actualizar"])
(new button%[parent panel][label"Eliminar"])



;-------------------------------------------VENTANA ENCUESTA----------------------------------------------------------------------------------------------
 (define ventanaEncuesta
  (new frame%[ label "Encuesta"])
  )
(define Encuesta
  (new message%
       [min-height 30]
       [min-width 600]
       [parent ventanaEncuesta]
       [label ""]
   )
  )
(define txt_pregunta1_encuesta (new text-field%
  [parent ventanaEncuesta]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "¿Cuantas veces usa el baño?:"]
  ))

(define txt_pregunta2_encuesta (new text-field%
  [parent ventanaEncuesta]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "¿Cuantas libras de ropa lava día?:"]
  ))

(define txt_pregunta3_encuesta (new text-field%
  [parent ventanaEncuesta]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "¿Cuantas veces al día te cepillas los dientes?:"]
  ))

(define txt_pregunta4_encuesta (new text-field%
  [parent ventanaEncuesta]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "¿Cuantas veces sueltas el inodoro al día?:"]
  ))
(define panelEncuesta(new horizontal-panel%[parent ventanaEncuesta]
[alignment'(center center)]))

(new button%[parent panelEncuesta][label"Guardar"])
(new button%[parent panelEncuesta][label"Ver Perfil"])

;-------------------------------------------VENTANA FACTURACION----------------------------------------------------------------------------------------------
  (define ventanaFacturacion
  (new frame%[ label "Facturar"])
  )
(define facturar
  (new message%
       [min-height 30]
       [min-width 600]
       [parent ventanaFacturacion]
       [label "\tFacturar"]
   )
  )
(define txt_consumo_encuesta (new text-field%
  [parent ventanaFacturacion]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Consumo mes anterior 1:"]
  ))

(define txt_consumo2_encuesta (new text-field%
  [parent ventanaFacturacion]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Consumo mes anterior 2:"]
  ))
(define txt_consumo3_encuesta (new text-field%
  [parent ventanaFacturacion]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Consumo mes anterior 3:"]
  ))
(define txt_consumo4_encuesta (new text-field%
  [parent ventanaFacturacion]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Consumo mes anterior 4:"]
  ))
(define txt_consumo_pasado_encuesta (new text-field%
  [parent ventanaFacturacion]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Consumo mes pasado:\t"]
  ))

(define panelfact (new horizontal-panel% [parent ventanaFacturacion]
[alignment '(center center)])
  )
(new message% [parent panelfact] [label "Lectura anterior:\t"])
(new text-field% [parent panelfact] [label ""])
(new message% [parent panelfact] [label "\tUsuario mayor consumo:\t\t"])
(new text-field% [parent panelfact] [label ""])

(define panelfact1(new horizontal-panel% [parent ventanaFacturacion]
[alignment '(center center)])
  )
(new message% [parent panelfact1] [label "Lectura actual:\t"])
(new text-field% [parent panelfact1] [label ""])
(new message% [parent panelfact1] [label "\tUsuario menor consumo:\t\t"])
(new text-field% [parent panelfact1] [label ""])

(define panelfact2(new horizontal-panel% [parent ventanaFacturacion]
[alignment '(center center)])
  )
(new message% [parent panelfact2] [label "Consumo:\t\t"])
(new text-field% [parent panelfact2] [label ""])
(new message% [parent panelfact2] [label "\tValor m3:\t\t\t\t\t"])
(new text-field% [parent panelfact2] [label ""])

(define panelfact3(new horizontal-panel% [parent ventanaFacturacion]
[alignment '(center center)])
  )
(new message% [parent panelfact3] [label "Total a pagar:\t"])
(new text-field% [parent panelfact3] [label ""])




;-------------------------------------------VENTANA RECOMENDACIONES----------------------------------------------------------------------------------------------
  (define ventanaRecomendaciones
  (new frame%[ label "Recomendaciones"])
  )
(define recomendar
  (new message%
       [min-height 30]
       [min-width 600]
       [parent ventanaRecomendaciones]
       [label "\tRecomendaciones"]
   )
  )
(define txt_reco1_recomendaciones (new text-field%
  [parent ventanaRecomendaciones]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Respecto a usuario:\t\t "]
  ))

(define txt_reco2_recomendaciones (new text-field%
  [parent ventanaRecomendaciones]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Respecto a consumo:\t\t "]
  ))

(define txt_reco3_recomendaciones (new text-field%
  [parent ventanaRecomendaciones]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Respecto a habitos:\t\t "]
  ))

(define panelreco (new horizontal-panel% [parent ventanaRecomendaciones]
[alignment '(center center)])
  )

(new message% [parent panelreco] [label "Lectura anterior:\t"])
(new text-field% [parent panelreco] [label ""])
(new message% [parent panelreco] [label "\tUsuario mayor consumo:\t"])
(new text-field% [parent panelreco] [label ""])

(define panelreco1(new horizontal-panel% [parent ventanaRecomendaciones]
[alignment '(center center)])
  )
(new message% [parent panelreco1] [label "Lectura actual:\t"])
(new text-field% [parent panelreco1] [label ""])
(new message% [parent panelreco1] [label "\tUsuario menor consumo:\t"])
(new text-field% [parent panelreco1] [label ""])

(define panelreco2(new horizontal-panel% [parent ventanaRecomendaciones]
[alignment '(center center)])
  )
(new message% [parent panelreco2] [label "Consumo:\t"])
(new text-field% [parent panelreco2] [label ""])

(define panelRecomendaciones(new horizontal-panel%[parent ventanaRecomendaciones]
[alignment'(center center)]))

(new button%[parent panelRecomendaciones][label"Guardar"])
(new button%[parent panelRecomendaciones][label"Simular"])
(new button%[parent panelRecomendaciones][label"Cancelar"])


;-------------------------------------------VENTANA ESTADISTICAS----------------------------------------------------------------------------------------------
  (define ventanaEstadisticas
  (new frame%[ label "Estadisticas"])
  )
(define estadisticas
  (new message%
       [min-height 30]
       [min-width 300]
       [parent ventanaEstadisticas]
       [label "\tEstadisticas"]
   )
  )

(define txt_datos1_estadistica (new text-field%
  [parent ventanaEstadisticas]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Consumo promedio de la cuidad:"]
  ))

(define txt_datos2_estadistica (new text-field%
  [parent ventanaEstadisticas]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Esperanza de vida agua:\t\t "]
  ))

(define txt_datos3_estadistica (new text-field%
  [parent ventanaEstadisticas]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Valor m3 dentro de X años:\t "]
  ))

(define txt_datos4_estadistica (new text-field%
  [parent ventanaEstadisticas]
  (vert-margin 20)
  (horiz-margin 50)
  [min-height 10]
  [min-width 150]
  [label "Desperdicio En X meses:\t\t"]
  ))
;---------------------------------------------VENTANA REGISTRAR--------------------------------------------------------------------------------------------
(define ventanaRegistrar
  (new frame%[ label "Aquabot"])
  )
(define titulo2
  (new message%
       [min-height 30]
       [min-width 300]
       [parent ventanaRegistrar]
       [label "\tRegistrar"]
   )
  )



;==========================================================================================================================================================
; se llama a la funcion automaticamete
(send ventana show #t)
;--------------------------------------

;--------------------------------------
;logica
(define (registrar-casa barrId casaEstrato casaDireccion)
  (query-exec conexion "insert into CASAS values ('null', ?, ?, ?)" barrId casaEstrato casaDireccion))

(define (registrar-usuario casaId usuaIdentidad usuaClave usuaNombres usuaApellido1 usuaApellido2 usuaTelefono)
  (query-exec conexion "insert into USUARIOS values ('null', ?, ?, ?, ?, ?, ?, ?)" casaId usuaIdentidad usuaClave usuaNombres usuaApellido1 usuaApellido2 usuaTelefono))

(define (registrar-contador casaId contNumero)
  (query-exec conexion "insert into CONTADORES values ('null', ?, ?)" casaId contNumero))

(define (registrar-historial-contador contId histRegistroC histFechaC)
  (query-exec conexion "insert into HISTORIAL_CONTADORES values ('null', ?, ?, ?)" contId histRegistroC histFechaC))

(define (consumos contId) (query-list conexion "select histRegistroC from HISTORIAL_CONTADORES where contId = ?" contId))
(define (num_consumos contId) (query-list conexion "select count(*) from HISTORIAL_CONTADORES where contId = ?" contId))

(define x 0)
(set! x (consumos 2))
x

(define y 0)
(set! y (num_consumos 2))
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
;--------------------------------------
