CREATE VIEW price_growth AS 
	SELECT
		hbf.food_name,
		hbf.current_year,
		hbf.price,
		hbf2.price AS price_new,
		((hbf.price - hbf2.price)/hbf2.price)*100 AS price_growth_percent
	FROM t_hana_borova_project_sql_primary_final hbf
	JOIN t_hana_borova_project_sql_primary_final hbf2
		ON hbf.food_name = hbf2.food_name 
		AND hbf.current_year = hbf2.current_year + 1
	GROUP BY hbf.food_name, hbf.current_year
;



SELECT
	pg.food_name,
	avg(pg.price_growth_percent) AS perc_total_change
FROM price_growth pg 
GROUP BY pg.food_name 
ORDER BY perc_total_change
LIMIT 1
;