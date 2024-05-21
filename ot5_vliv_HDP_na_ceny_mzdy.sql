WITH price_growth_total AS
(
	SELECT
		hbf.current_year,
		round(((hbf2.price - hbf.price)/hbf.price)*100, 2) AS price_growth_percent
	FROM t_hana_borova_project_sql_primary_final hbf
	JOIN t_hana_borova_project_sql_primary_final hbf2
		ON hbf.food_name = hbf2.food_name 
		AND hbf.current_year = hbf2.current_year + 1
	GROUP BY hbf.current_year
),
wage_growth_total AS 
(	
	SELECT
		hbf.current_year,
		round(((hbf2.avg_wage_per_year - hbf.avg_wage_per_year)/hbf.avg_wage_per_year) * 100, 2) AS wage_growth_percent
	FROM t_hana_borova_project_sql_primary_final hbf
	JOIN t_hana_borova_project_sql_primary_final hbf2
		ON hbf.category_name = hbf2.category_name 
		AND hbf.current_year = hbf2.current_year + 1
	GROUP BY hbf.current_year
),
GDP_growth_total AS
(
	SELECT
		hbf.current_year,
		round(((hbf2.GDP - hbf.GDP)/hbf.GDP) * 100, 2) AS GDP_growth_percent
	FROM t_hana_borova_project_sql_primary_final hbf
	JOIN t_hana_borova_project_sql_primary_final hbf2
		ON hbf.category_name = hbf2.category_name 
		AND hbf.current_year = hbf2.current_year + 1
	GROUP BY hbf.current_year
)
SELECT 
	pgt.current_year,
	pgt.price_growth_percent,
	wgt.wage_growth_percent,
	ggt.GDP_growth_percent
FROM price_growth_total pgt
LEFT JOIN wage_growth_total wgt
	ON pgt.current_year = wgt.current_year
LEFT JOIN GDP_growth_total ggt
	ON ggt.current_year = pgt.current_year;