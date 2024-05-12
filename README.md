# Final_project SQL
	
Jméno: Hana Borová
Discord: hanaborova_67145
mail: han.krpenska@centrum.cz

# Zadání projektu

Naše analytické oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jsme se dohodli, že se pokusíme odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.

## Datové sady, které je možné použít pro získání vhodného datového podkladu

**Primární tabulky:**

- `czechia_payroll` – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
- `czechia_payroll_calculation` – Číselník kalkulací v tabulce mezd.
- `czechia_payroll_industry_branch` – Číselník odvětví v tabulce mezd.
- `czechia_payroll_unit` – Číselník jednotek hodnot v tabulce mezd.
- `czechia_payroll_value_type` – Číselník typů hodnot v tabulce mezd.
- `czechia_price` – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
- `czechia_price_category` – Číselník kategorií potravin, které se vyskytují v našem přehledu.

**Číselníky sdílených informací o ČR:**

- `czechia_region` – Číselník krajů České republiky dle normy CZ-NUTS 2.
- `czechia_district` – Číselník okresů České republiky dle normy LAU.

**Dodatečné tabulky:**

- `countries` - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
- `economies` - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.

## Tvorba finální tabulky

Prvním krokem tohoto projektu byla tvorba základní tabulky, ze které následně budou vycházet odpovědi na kladné otázky. Zdrojem byly tabulky `czechia payroll` a `czechia price`.

**Tabulka `czechia payroll`:**

- Odsud byli vybrány sloupce:
  - `payroll year`
  - Výpočet průměrné mzdy za daný rok (tabulka obsahovala průměrné hodnoty za kvartál).
- Dále bylo potřeba vyfiltrovat pouze mzdy zaměstnanců (které jsou v tabulce pod kódem 5958).
- K této tabulce jsem připojila pomocnou tabulku `czechia_payroll_industry_branch`, díky níž jsem získala názvy jednotlivých průmyslových odvětví.
- Dále jsem odstranila nulové hodnoty ve sloupci `industry branch name`.

**Tabulka `czechia_price`:**

- Tuto tabulku jsem připojila k tabulce `czechia payroll` na základě roku. Mezi těmito tabulkami nebylo jiné propojení.
- Bylo potřeba upravit datum ve sloupci `date_from` a následně šla napojit na `czechia_payroll`.
- Vyfiltrovala jsem ve sloupci `region code` pouze NULL hodnoty, abych zamezila duplicitním záznamům. Null hodnota ve sloupci značila průměr za danou kategorii a datum zprůměrováno za všechny regiony.
- Sloupec `price` obsahuje výpočet průměrné roční hodnoty za danou kategorii. Je potřeba zmínit, že kategorie "jakostní víno bílé" se objevila v datech až od roku 2015. 
- K této tabulce byla následně připojena tabulka `czechia_price_category`, ze které jsme získali název kategorie potravin.

**Jako poslední byla napojena tabulka `economies`.**

- Byla napojena na základě roku na tabulku czechia payroll.
- Z ní byl vybrán pouze sloupec `GDP` a to pouze pro Českou republiku.

Následně bylo nutné sjednotit data na základně společných let. Každá z tabulek obsahovala data za různé časové období. Pomocí funkcí `min/max` jsem si pro každou tabulku zjistila počáteční a konečný rok. Z toho pak vyšlo, že bude potřeba moji výslednou tabulku omezit na roky 2006 až 2018.

Na základě této tabulky jsem pak mohla odpovídat na následující výzkumné otázky:

1. **Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**
   - Z dat vyplývá, že mzdy v průběhu let nemají pouze rostoucí trend. Mezi lety 2009 až 2016 v některých odvětvích mzdy také klesaly. Z dat vyšlo, že nejhůře na tom byl rok 2013, ve kterém klesly mzdy celkem v 11 odvětvích. Nejvíce zasaženo bylo odvětví "Těžba a dobývání". Naopak nejlépe na tom byli "doprava a skladování", "ostatní činnosti", "zdravotní a sociální péče" a "zpracovatelský průmysl", ve kterých mzdy ve sledovaném období neklesly ani jednou.
   
2. **Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**
   - Prvním srovnatelným obdobím byl rok 2006 a posledním rok 2018. Bylo vycházeno z celkových průměrných mezd a cen jednotlivých potravin. Za předpokladu, že mzda bude celá utracena pouze za danou potravinu vyšli následující výsledky:
     
| Kategorie potravin 			| Rok 	| Celkové množství |
|---------------------------	|-------|------------------|
| Chléb konzumní kmínový 		| 2018 	| 16106.86|
| Mléko polotučné pasterované 	| 2018 	| 19698.8 |
| Chléb konzumní kmínový 		| 2006 	| 15449.47|
| Mléko polotučné pasterované 	| 2006 	| 17246.91|

3. **Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**
   - Vytvořila jsem si pohled - ve kterém jsem si vypočítala % meziroční nárůst cen za dané kategorie potravin a roky. Na základě něj jsem pak vypočítala celkovou průměrnou meziroční změnu za danou kategorii potravin. Je důležité zmínit, že kategorie potravin "jakostní víno bílé" není zastoupena v tabulce od roku 2006, ale až od roku 2015. Toto jsem ošetříla právě tím, že jsem použila průměr a tím jsem získala relativní změnu v průběhu času. Z dat vyplývá, že nejpomaleji zdražuje - ba dokonce zlevňuje kategorie "Cukr krystalový".

4. **Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**
   - Pomocí CTE metody jsem si vypočítala průměrný meziroční nárůst mezd a průměrný meziroční nárůst cen. Následně jsem pomocí funkce CASE/END od sebe tyto 2 hodnoty odečetla a vyšlo mi, že v roce 2012 rostly ceny o více než 10 % oproti růstu mezd.

5. **Má výška HDP vliv na změny ve mzdách a cenách potravin?**
   - Z hodnot, které mi vyšly se nezdá, že by změna HDP nějak výrazně ovlivňovala růst cen či mezd. U mezd není patrný žádný významnější meziroční výkyv a u cen potravin proběhlo razantnější snížení v roce 2010. Naopak ceny významně vzrostly v roce 2007 a 2012. Ale neprojevilo se to na HDP. Například v roce 2012 kdy narostly ceny v průměru o 14.94 % došlé dokonce k snížení růstu HDP o necelé 2 % v roce 2011 HDP rostl, ale zase ani ne o 2 %. Takže na datech, která mám k dispozici není patrné, že by se změna HDP nějak významně promítla do ukazatelů mezd a cen.
   
## Tvorba sekundární tabulky
	sekundární tabulka obsahuje údaje o GDP, GINI koeficientu a populaci za všechny Evropské země.
	