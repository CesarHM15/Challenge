
--¿CUAL ES EL NOMBRE DEL AEROPUERTO QUE HA TENIDO MAYOR MOVIMIENTO DURANTE EL AÑO?
SELECT ID_AEROPUERTO AS ID, NOMBRE_AEROPUERTO AS AEROPUERTO, Total_Mov
FROM (SELECT vuelos.ID_AEROPUERTO,NOMBRE_AEROPUERTO, COUNT(vuelos.ID_MOVIMIENTO) Total_mov
	  FROM VUELOS
	  inner join aeropuertos on aeropuertos.ID_AEROPUERTO =VUELOS.ID_AEROPUERTO	
	  GROUP BY NOMBRE_AEROPUERTO, vuelos.ID_AEROPUERTO) 
	  AS T1
WHERE Total_mov  = (SELECT MAX(Total_mov)
				   FROM (SELECT COUNT(ID_MOVIMIENTO) Total_mov
				         FROM VUELOS
				         GROUP BY ID_AEROPUERTO) 
						 AS T2)

--ID AEROPUERTO     Total_Mov
--1	 Benito Juarez	3
--3	 La paz			3
						 
--¿CUAL ES EL NOMBRE DE LA AEROLINEA QUE HA TENIDO MAYOR NUMERO DE VUELOS DURANTE EL AÑO?

SELECT ID_AEROLINEA AS ID, NOMBRE_AEROLINEA AS AEROLINEA, Total_Vuelos
FROM (SELECT vuelos.ID_AEROLINEA,NOMBRE_AEROLINEA, COUNT(vuelos.ID_MOVIMIENTO) Total_Vuelos
	  FROM VUELOS 
	  inner join aerolineas on aerolineas.ID_AEROLINEA =VUELOS.ID_AEROLINEA	
	  WHERE ID_MOVIMIENTO =1
	  GROUP BY NOMBRE_AEROLINEA, vuelos.ID_AEROLINEA) 
	  AS T1
WHERE Total_Vuelos  = (SELECT MAX(Total_Vuelos)
				   FROM (SELECT COUNT(ID_MOVIMIENTO) Total_Vuelos
				         FROM VUELOS 
						 WHERE ID_MOVIMIENTO =1
				         GROUP BY ID_AEROLINEA ) 
						 AS T2)

--ID AEROLINEA      Total_Mov
--2	 Aeromar		3

--¿En qué día se han tenido mayor número de vuelos?

select dia, Total_vuelos 
	from (select dia, count(dia) Total_vuelos
		from vuelos
		group by dia) as t1
where Total_vuelos =
	(select max(Total_vuelos) from (
		select count(dia) Total_vuelos 
		from vuelos 
		group by dia) as t2)

--DIA			Total_Mov
--2021-05-02	6

--¿Cuales son las aerolineas que tienen mas de 2 vuelos por dia?

Select  aerolineas.ID_AEROLINEA AS ID,NOMBRE_AEROLINEA AS AEROLIENA, count(ID_MOVIMIENTO) Total_vuelos FROM VUELOS
inner join aerolineas on aerolineas.ID_AEROLINEA=vuelos.ID_AEROLINEA
where ID_MOVIMIENTO=1  
group by aerolineas.ID_AEROLINEA, NOMBRE_AEROLINEA 
having count(ID_MOVIMIENTO)>2

--Id AEROLINEA      Total_Mov
--2	 Aeromar		3

