WITH price_growth_total AS
(
	SELECT
		hbf.food_name,
		hbf.current_year,
		round(((hbf.price - hbf2.price)/hbf2.price) *100, 2) AS price_growth_percent
	FROM t_hana_borova_project_sql_primary_final hbf
	JOIN t_hana_borova_project_sql_primary_final hbf2
		ON hbf.food_name = hbf2.food_name 
		AND hbf.current_year = hbf2.current_year + 1
	GROUP BY hbf.food_name, hbf.current_year
),
wage_growth_total AS 
(
	SELECT
		hbf.category_name,
		hbf.current_year,
		round(((hbf.avg_wage_per_year - hbf2.avg_wage_per_year)/hbf2.avg_wage_per_year)* 100, 2) AS wage_growth_percent
	FROM t_hana_borova_project_sql_primary_final hbf
	JOIN t_hana_borova_project_sql_primary_final hbf2
		ON hbf.category_name = hbf2.category_name 
		AND hbf.current_year = hbf2.current_year + 1
	GROUP BY hbf.category_name, hbf.current_year
)
SELECT 
	pgt.current_year,
	round(avg(pgt.price_growth_percent),2) AS price_growth_perc,
	round(avg(wgt.wage_growth_percent),2) AS wage_growth_perc,
	round(avg(pgt.price_growth_percent) - avg(wgt.wage_growth_percent),2) AS difference,
	CASE 
		WHEN (avg(pgt.price_growth_percent) - avg(wgt.wage_growth_percent)) >=10 THEN 'higher_then_10%'
		ELSE 'lower_then_10%'
	END AS price_wage_diff
FROM price_growth_total pgt
LEFT JOIN wage_growth_total wgt
	ON pgt.current_year = wgt.current_year
GROUP BY pgt.current_year;
;