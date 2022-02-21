/*
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT
*/
-- write with a backbone first.
-- two -- means inline comment code.
SELECT *
FROM products
LIMIT 100;

SELECT *
FROM sales
LIMIT 100;

SELECT category_name, item_description
FROM products
ORDER BY category_name DESC
LIMIT 100;

SELECT item_no, bottle_price
FROM products
WHERE bottle_price > 12 -- operators include > < >= <= = !=
ORDER BY bottle_price
LIMIT 100;

SELECT category_name, AVG(bottle_price)
FROM products
WHERE (category_name ILIKE '%scotch%' AND category_name NOT ILIKE '%whisk%')
	OR category_name ILIKE '%vodka%'
-- lower() upper()
-- ilike == postgres ... sqlserver == like
-- % <---> %h_llo%, %hello%, etc..
GROUP BY category_name;

SELECT item_description
FROM products
LIMIT 10;

SELECT CATEGORY_NAME,
	COUNT(CATEGORY_NAME),
	AVG(BOTTLE_PRICE)::MONEY AVG_BOTTLE_PRICE,
	AVG(SHELF_PRICE::numeric::MONEY) -- cast(column/expression type)
-- cast(avg(bottle_price) as money)
-- data types for cast function: numeric, text, decimal, money
FROM PRODUCTS
WHERE (CATEGORY_NAME ilike '%scotch%'
							AND CATEGORY_NAME not ilike '%whisk%')
	OR CATEGORY_NAME ilike '%vodka%' -- not == excluding data -- whisk
-- % <----> hello% _ hallo %h_llo%
-- lower() upper() -- ilike == postgres .... SqlServer == like
GROUP BY 1
HAVING AVG(SHELF_PRICE) > 10 --1 group by category_name or 2 groups by avg bottle price
ORDER BY 1;

-- ctrl + shift + k --> beautify your code!

SELECT P.CATEGORY_NAME,
	COUNT(CATEGORY_NAME),
	AVG(SHELF_PRICE)::numeric::MONEY AVG_SHELF_PRICE,
	AVG(BOTTLE_PRICE)::MONEY::numeric::text::decimal::numeric::MONEY AVG_BOTTLE_PRICE
	-- cast(avg(bottle_price) as money) -- cast(column/expression as type)
FROM PRODUCTS P
WHERE (CATEGORY_NAME ilike '%scotch%'
							AND CATEGORY_NAME not ilike '%whisk%')
	OR CATEGORY_NAME ilike '%vodka%' -- not == excluding data -- whisk
-- % <----> hello% _ hallo %h_llo%
-- lower() upper() -- ilike == postgres .... SqlServer == like
GROUP BY 1
HAVING AVG(SHELF_PRICE) > 10
ORDER BY 1

/*
SELECT DISTINCT *
FROM products;
9977 rows returned
*/

/*
SELECT DISTINCT category_name, item_description
FROM products;
7418 rows returned
*/

SELECT DISTINCT ON(category_name) category_name, item_description
FROM products;

SELECT DISTINCT category_name, item_description
FROM products;

SELECT category_name, proof
FROM products
WHERE proof::numeric BETWEEN 80 and 151;

/*
"TEQUILA"
"IRISH WHISKIES"
"AMERICAN DRY GINS"
"IMPORTED VODKA"
"80 PROOF VODKA"
*/

SELECT category_name, proof
FROM products
WHERE LOWER(category_name)
IN ('tequila', 'irish whiskies', 'american dry gins', 'imported vodka');

category_name ilike 'tequila'
or category_name ilike 'irish whiskies'


SELECT total
FROM sales_full
LIMIT 100;

SELECT vendor, AVG(total) AS avg_sales, SUM(total) > 100000 AS sales
FROM sales_full
WHERE lower(category_name)
	IN ('imported ale', 'imported amaretto', 'imported dry gins', 'imported grape brandies', 'imported schnapps',
		'imported vodka - misc', 'misc. imported cordials & liquers')
GROUP BY vendor
ORDER BY avg_sales DESC
LIMIT 10;

SELECT vendor, AVG(total) avg_sales
FROM sales_full
WHERE lower(category_name)
	IN ('imported ale', 'imported amaretto', 'imported dry gins',
    'imported grape brandies', 'imported schnapps',
		'imported vodka - misc', 'misc. imported cordials & liquers')
GROUP BY vendor
HAVING SUM(total) > 100000
ORDER BY avg_sales DESC
LIMIT 10;
