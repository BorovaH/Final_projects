WITH Year_on_year_growth_table AS 
(
	SELECT 
		hbf.category_name,
		hbf.payroll_year,
		round((hbf.avg_wage_per_year - hbf2.avg_wage_per_year)/hbf2.avg_wage_per_year *100,2) AS year_on_year_growth
	FROM t_hana_borova_project_sql_primary_final hbf 
	JOIN t_hana_borova_project_sql_primary_final hbf2 
		ON hbf.category_name = hbf2.category_name
		AND hbf.payroll_year = hbf2.payroll_year + 1
	GROUP BY hbf.category_name, hbf.payroll_year
)
SELECT *,
	CASE
		WHEN year_on_year_growth > 0 THEN 'Wages_are_rising'
		ELSE 'Wages_are_falling'
	END AS Wage_development
FROM Year_on_year_growth_table
ORDER BY payroll_year, category_name;