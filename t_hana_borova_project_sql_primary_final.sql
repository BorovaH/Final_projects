CREATE TABLE t_hana_borova_project_sql_primary_final AS
(
WITH avg_wages_per_year AS
	(SELECT
		cpay.payroll_year,
		cpib.name AS category_name,
		round(avg(cpay.value),2) AS avg_wage_per_year
	FROM czechia_payroll cpay
	LEFT JOIN czechia_payroll_industry_branch cpib 
		ON cpay.industry_branch_code = cpib.code 
	WHERE cpay.value_type_code = 5958
	AND cpib.name IS NOT NULL 
	GROUP BY cpay.payroll_year, cpib.name
	)
SELECT 
	cpd.category_code,
	cpc.name AS food_name,
	cpd.avg_price AS price,
	cpd.current_year,
	awpy. *,
	e.GDP 
FROM avg_wages_per_year awpy
LEFT JOIN 
	(SELECT  
		cp.category_code,
		round(avg(cp.value),2) AS avg_price,
		year(cp.date_from) AS current_year
	FROM czechia_price cp 
	WHERE cp.region_code IS NULL
	GROUP BY cp.category_code,YEAR(cp.date_from) 
	) cpd
ON awpy.payroll_year = cpd.current_year
LEFT JOIN czechia_price_category cpc 
	ON cpc.code = cpd.category_code 
LEFT JOIN economies e 
	ON e.`year` = awpy.payroll_year
	AND e.country = 'Czech Republic'
WHERE awpy.payroll_year >=2006 and awpy.payroll_year <=2018
ORDER BY awpy.payroll_year, cpd.current_year, cpc.name, awpy.category_name, cpd.category_code  ASC
);
