# Final_projects

Naše analytické oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jsme se dohodli, že se pokusíme odpovědět na pár definovaných výzkumných otázek, 
které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. 
Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.


Datové sady, které je možné použít pro získání vhodného datového podkladu

Primární tabulky:
czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
czechia_payroll_calculation – Číselník kalkulací v tabulce mezd.
czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd.
czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd.
czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd.
czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.
Číselníky sdílených informací o ČR:

czechia_region – Číselník krajů České republiky dle normy CZ-NUTS 2.
czechia_district – Číselník okresů České republiky dle normy LAU.

Dodatečné tabulky:
countries - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.


Tvorba finalni tabulky

Prvním krokem tohoto projektu byla tvorba základní tabulky, ze které následně budou vycházet odpovědi na kladné otázky. Zdrojem byli tabulky czechia payroll a czechia price.

Tabulka czechia payroll:
	Odsud byli vybrány sloupce:
		payroll year 
		výpočet průměrné mezdy za daný rok (tabulka obsahovala průměrné hodnoty za kvartál). 
	Dále bylo potřeba vyfiltrovat pouze mzdy zaměstnanců (které jsou v tabulce pod kódem 5958). 
	K této tabulce jsem připojila pomocnou tabulku czechia_payroll_industry_branch, díky níž jsem získala názvy jednotlivých průmyslových odvětví. 
	Dále jsem odstranila nulové hodnoty ve sloupci industry branch name.
	
Tabulka czechia_price:
	Tuto tabulku jsem připojila k tabulce czechia payroll na základě roku. Mezi těmito tabulkami nebylo jiné propojení. Bylo potřeba upravit datum ve sloupci date_from a následně 
	šla napojit na czechia_payroll.
	Bylo nutné zafiltrovat sloupec region code - brala jsem pouze Null hodnoty, abych zamezila duplicitním záznamům. Null hodnota ve sloupci značila přůměr za danou kategorii a datum
	zprůměrováno za všechny regiony.
	Sloupec price obsahuje výpočet průměrné roční hodnoty za danou kategorii.
	K této tabulce byla následně připojena tabulka czechia_price_category, ze které jsme získali název kategorie potravin.
	
Jako poslední byla napojena tabulka economies.
	Ta byla napojena na základě roku.
	Z ní byl vybrán pouze sloupec GDP a to pouze pro Českou republiku.
	
Následně bylo nutné sjednotit data na základně společných let. Každá z tabulek obsahovala data za různé časové období. Pomocí funkcí min/max jsem si pro každou tabullku zjistila
počáteční a konečný rok. Z toho pak vyšlo, že bude potřeba mou výslednou tabulku omezit na roky 2006 až 2018.

Na základě této tabulky jsem pak mohla odpovídat na následující výzkzmné otázky:

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
	Z dat vyšlo, že mzdy v průběhu let nemají pouze rostoucí trend. Mezi lety 2009 až 2016 v některých odvětvích mzdy také klesaly. Z dat vyšlo, že nejhůře na tom byl rok 2013, 
	ve kterém klesly mzdy celkem v 11 odvětvích. Nejvíce zasaženo bylo odvětví "Těžba a dobývání". Naopak nejlépe na tom byli "doprava a skladování", "ostatní činnosti",
	"zdravotní a sociální péče" a "zpracovatelký průmysl", ve kterých mzdy ve sledovaném období neklesly ani jednou.
	
2. 
