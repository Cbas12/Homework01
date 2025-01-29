SELECT 
CASE
    WHEN trip_distance <= 1 THEN '0-1'
    WHEN trip_distance <= 3 THEN '1-3'
    WHEN trip_distance <= 7 THEN '3-7'
    WHEN trip_distance <= 10 THEN '7-10'
    WHEN trip_distance > 10 THEN '10+'
    ELSE 'error!'
END AS distancias, 
COUNT(*) AS count
FROM yellow_taxi_data
WHERE lpep_pickup_datetime >= '2019-10-01 00:00:00' AND lpep_pickup_datetime < '2019-11-01 00:00:00'
GROUP BY distancias;



SELECT lpep_pickup_datetime,MAX(trip_distance) AS MAXS FROM yellow_taxi_data 
WHERE lpep_pickup_datetime >= '2019-10-01 00:00:00' AND lpep_pickup_datetime < '2019-11-01 00:00:00' 
GROUP BY lpep_pickup_datetime ORDER BY MAXS DESC LIMIT 100;



SELECT z."Zone",sum(total_amount) AS sum_t_amount
FROM yellow_taxi_data AS y 
LEFT JOIN zones AS z ON y."PULocationID"=z."LocationID"
WHERE lpep_pickup_datetime>='2019-10-18 00:00:00' AND lpep_pickup_datetime<'2019-10-19 00:00:00'
GROUP BY z."Zone" HAVING sum(total_amount)>=13000 ORDER BY sum_t_amount DESC;



SELECT ZO."Zone",MAX(tip_amount) AS total_tip
FROM yellow_taxi_data AS Y 
LEFT JOIN zones AS Z ON Y."PULocationID"=Z."LocationID"
LEFT JOIN zones AS ZO ON Y."DOLocationID"=ZO."LocationID"
WHERE lpep_pickup_datetime>='2019-10-01 00:00:00' AND lpep_pickup_datetime<'2019-11-01 00:00:00'
AND Z."Zone"='East Harlem North' GROUP BY ZO."Zone" ORDER BY total_tip DESC LIMIT 10;