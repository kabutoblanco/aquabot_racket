 #lang racket/gui
(require "../datos.rkt")
(require "../logica.rkt")
;--------------------------------------------------------------------------------------------------------------------------------
;publico
;--------------------------------------------------------------------------------------------------------------------------------
(provide ventana-encuestar)
;--------------------------------------------------------------------------------------------------------------------------------
;ventana-encuestar
;--------------------------------------------------------------------------------------------------------------------------------
(define ventana-encuestar
  (new frame%[label "Encuesta"][stretchable-width #f] [stretchable-height #f]))

(define Encuesta
  (new message%
       [min-height 30]
       [min-width 600]
       [parent ventana-encuestar]
       [label ""]))

(define txt_pregunta1_encuesta
  (new text-field%
       [parent ventana-encuestar]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "¿Cuantas veces usa el baño?:"]))

(define txt_pregunta2_encuesta
  (new text-field%
       [parent ventana-encuestar]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "¿Cuantas libras de ropa lava día?:"]))

(define txt_pregunta3_encuesta
  (new text-field%
       [parent ventana-encuestar]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "¿Cuantas veces al día te cepillas los dientes?:"]))

(define txt_pregunta4_encuesta
  (new text-field%
       [parent ventana-encuestar]
       (vert-margin 20)
       (horiz-margin 50)
       [min-height 10]
       [min-width 150]
       [label "¿Cuantas veces sueltas el inodoro al día?:"]))

(define panelEncuesta
  (new horizontal-panel%[parent ventana-encuestar][alignment'(center center)]))

(new button%[parent ventana-encuestar][label"Guardar"])
(new button%[parent ventana-encuestar][label"Ver Perfil"])
;--------------------------------------------------------------------------------------------------------------------------------