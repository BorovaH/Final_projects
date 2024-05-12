CREATE TABLE t_hana_borova_project_SQL_secondary_final AS 
(
WITH europe_countries AS
	(SELECT 
		c2.country,
		c2.continent 
	FROM countries c2 
	WHERE c2.continent = 'Europe'
	)
SELECT ec.*,
	e.`year` ,
	e.GDP ,
	e.population,
	e.gini 
FROM europe_countries ec
LEFT JOIN economies e
ON e.country = ec.country
WHERE e.`year`>=2006 and e.`year`<=2018
ORDER BY e.`year` 
);
	