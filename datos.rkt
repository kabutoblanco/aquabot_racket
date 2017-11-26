#lang racket
(require racket/gui/base)
(require db)
;--------------------------------------------------------------------------------------------------------------------------------
;variables y servicios que proveé
;--------------------------------------------------------------------------------------------------------------------------------
(provide conexion autenticar registrar-sql get-usuario-id get-usuario-autenticado usuario-sistema usuario-foraneo usuario-consumo
         contador-consumos-sql get-usuario-?-desperdicio-sql get-usuario-consumo contadores-consumos-sql consumo-actual-usuario-sql
         casa-sistema get-casa get-contador-sql get-lectura-actual)
;--------------------------------------------------------------------------------------------------------------------------------
;conexion
;--------------------------------------------------------------------------------------------------------------------------------
(define conexion
  (mysql-connect #:server "localhost"
                 #:port 1520
                 #:database "aquabot"
                 #:user "root"))
;--------------------------------------------------------------------------------------------------------------------------------
;variables globales
;--------------------------------------------------------------------------------------------------------------------------------
(define i 0)
(define casa-sistema (list))
(define usuario-sistema (list))
(define usuario-foraneo (list))
(define usuario-consumo (cons 0 0))
;--------------------------------------------------------------------------------------------------------------------------------
;servicios
;--------------------------------------------------------------------------------------------------------------------------------
(define (autenticar-sql identidad clave)
  (query-rows conexion "select * from USUARIOS where usuaIdentidad = ? and usuaClave = ?" identidad clave))
;retorna un booleano para autenticar un usuario
(define (autenticar identidad clave)
  (if (null? (autenticar-sql identidad clave)) #f #t))
;--------------------------------------------------------------------------------------------------------------------------------
;registra un usuario
(define (registrar-sql ciudad barrio identidad clave nombres apellido1 apellido2 telefono direccion)
  (query-list conexion "select crearUsuario(?, ?, ?, ?, ?, ?, ?, ?, ?)" ciudad barrio identidad clave nombres apellido1 apellido2 telefono direccion))
;--------------------------------------------------------------------------------------------------------------------------------
(define (get-usuario-id-sql id)
  (in-query conexion "select * from USUARIOS where usuaId = ?" id))
;modifica la variable 'usuario-foraneo' por aquel que queremos buscar
(define (get-usuario-id id)
  (for ([(usuaId casaId usuaIdentidad usuaClave usuaNombres usuaApellido1 usuaApellido2 usuaTelefono) (get-usuario-id-sql id)])
    (set! usuario-foraneo (append (list usuaIdentidad) (list usuaNombres) (list usuaApellido1) (list usuaApellido2) (list usuaTelefono)))))
;--------------------------------------------------------------------------------------------------------------------------------
(define (get-usuario-autenticado-sql identidad clave)
  (in-query conexion "select * from USUARIOS where usuaIdentidad = ? and usuaClave = ?" identidad clave))
;modifica la variable 'usuario-sistema' por aquel que ingreso al sistema
(define (get-usuario-autenticado identidad clave)
  (for ([(usuaId casaId usuaIdentidad usuaClave usuaNombres usuaApellido1 usuaApellido2 usuaTelefono) (get-usuario-autenticado-sql identidad clave)])
    (set! usuario-sistema (append (list usuaId) (list casaId) (list usuaIdentidad) (list usuaNombres) (list usuaApellido1) (list usuaApellido2) (list usuaTelefono)))))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna una lista con los consumos de un contador en los ultimos 'limite' mes
(define (contador-consumos-sql contId limite)
  (query-list conexion "select consumo from (select year(histFechaC) as anio, month(histFechaC) as mes, histRegistroC as consumo from HISTORIAL_CONTADORES where contId = ? order by anio desc, mes desc limit ?) as CONSUMOS" contId limite))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna una lista con el id del usuario que desperdicio mucha/poca agua de un registro en los sensores segun el 'tipo' dado
(define (get-usuario-?-desperdicio-sql contId tipo)
  (if (equal? tipo >)
  (query-list conexion "select usuaId from (select usuaId, max(consRegistroH) from HISTORIAL_CONSUMOS inner join SENSORES on HISTORIAL_CONSUMOS.sensId = SENSORES.sensId where year(consFechaH) = year(curdate()) and month(consFechaH) = month(curdate()) and SENSORES.contId = ?) as mayor" contId)
  (query-list conexion "select usuaId from (select usuaId, min(consRegistroH) from HISTORIAL_CONSUMOS inner join SENSORES on HISTORIAL_CONSUMOS.sensId = SENSORES.sensId where year(consFechaH) = year(curdate()) and month(consFechaH) = month(curdate()) and SENSORES.contId = ?) as mayor" contId)))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna una lista con los consumos de los sensores del mes actual de un usuario especifico
(define (consumo-actual-usuario-sql id)
  (query-list conexion "select consRegistroH from HISTORIAL_CONSUMOS where year(consFechaH) = year(curdate()) and month(consFechaH) = month(curdate()) and usuaId = ?" id))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna una lista con los consumos de los sensores en los ultimos 'limite' mes
(define (consumos-mes-sql limite)
  (query-list conexion "select sum(consRegistroH) from HISTORIAL_CONSUMOS group by year(consFechaH), month(consFechaH)  order by year(consFechaH) asc, month(consFechaH) asc limit ?" limite))
;--------------------------------------------------------------------------------------------------------------------------------
(define (get-usuario-consumos-sql contId)
  (in-query conexion "select usuaNombres, sum(consRegistroH) as suma from (HISTORIAL_CONSUMOS inner join SENSORES on HISTORIAL_CONSUMOS.sensId = SENSORES.sensId) inner join USUARIOS on HISTORIAL_CONSUMOS.usuaId = USUARIOS.usuaId where year(consFechaH) = year(curdate()) and month(consFechaH) = month(curdate()) and SENSORES.contId = ? group by USUARIOS.usuaId order by suma desc" contId))

(define (get-usuario-consumos-count-sql contId)
  (query-list conexion "select count(*) from (select usuaId from HISTORIAL_CONSUMOS inner join SENSORES on HISTORIAL_CONSUMOS.sensId = SENSORES.sensId where year(consFechaH) = year(curdate()) and month(consFechaH) = month(curdate()) and SENSORES.contId = ? group by usuaId) as CONSUMOS" contId))
;modifica la variable 'usuario-consumo' por aquel usuario que haya consumido mas/menos en el mes actual segun el 'tipo' dado
(define (get-usuario-consumo contId tipo cont)
  (if (equal? tipo <)
      (set! cont (- (car (get-usuario-consumos-count-sql contId)) 1))
      (set! cont 0))
  (for ([(usuaNombres suma) (get-usuario-consumos-sql contId)]) 
    (if (= i cont) (set! usuario-consumo (cons usuaNombres suma)) (+ 0 0)) (set! i (+ i 1))) (set! i 0))
;--------------------------------------------------------------------------------------------------------------------------------
;retorna una lista con los consumos de todos los contadores
(define (contadores-consumos-sql limite)
  (query-list conexion "SELECT consumo from (SELECT YEAR(histFechaC) as anio ,MONTH(histFechaC) as mes, histRegistroC as consumo FROM HISTORIAL_CONTADORES ORDER BY anio ASC, mes ASC LIMIT ?) as CONSUMOS" limite))
;--------------------------------------------------------------------------------------------------------------------------------
(define (get-casa-sql id)
  (in-query conexion "select CASAS.casaId, barrId, casaEstrato, casaDireccion from CASAS inner join USUARIOS on CASAS.casaId = USUARIOS.casaId where usuaId = ?" id))
;modifica la variable 'casa-sistema'
(define (get-casa id)
  (for ([(casaId barrId casaEstrato casaDireccion) (get-casa-sql id)])
    (set! casa-sistema (append (list casaId) (list barrId) (list casaEstrato) (list casaDireccion)))))
;--------------------------------------------------------------------------------------------------------------------------------
(define (get-contador-sql id)
  (query-list conexion "select contId from CONTADORES where casaId = ?" id))
(define (get-lectura-actual id)
  (query-list conexion "select contRegistro from CONTADORES where casaId = ?" id))
;--------------------------------------------------------------------------------------------------------------------------------