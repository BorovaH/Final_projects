SELECT 
	hbf.food_name,
	(SELECT  
		DISTINCT (max(hbf.current_year)) 
	FROM t_hana_borova_project_sql_primary_final hbf) AS max_min_year ,
	round((avg(hbf.avg_wage_per_year) * 12)/avg(hbf.price), 2) AS max_possible_puchase
FROM t_hana_borova_project_sql_primary_final hbf
WHERE hbf.current_year  = 
		(SELECT 
			MAX(hbf.current_year) 
		FROM t_hana_borova_project_sql_primary_final hbf)
	AND (hbf.food_name = 'Mléko polotučné pasterované' OR hbf.food_name = 'Chléb konzumní kmínový')
GROUP BY hbf.food_name, hbf.current_year 
UNION
SELECT 
	hbf.food_name, 
	(SELECT  
	 	DISTINCT (min(hbf.current_year)) 
	 FROM t_hana_borova_project_sql_primary_final hbf) as max_min_year,
	round((avg(hbf.avg_wage_per_year) *12) /avg(hbf.price), 2) as max_possible_puchase
FROM t_hana_borova_project_sql_primary_final hbf
WHERE hbf.current_year = 
		(SELECT 
			min(hbf.current_year) 
		FROM t_hana_borova_project_sql_primary_final hbf) 
	AND (hbf.food_name = 'Mléko polotučné pasterované' OR hbf.food_name = 'Chléb konzumní kmínový')
GROUP BY hbf.food_name, hbf.current_year ;