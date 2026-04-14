/* 5. Get the products that have the highest and lowest manufacturing costs. 
The final output should contain these fields, 
product_code
product 
product manufacturing_cost */

SELECT
    c.product_code, p.product, c.manufacturing_cost
FROM fact_manufacturing_cost c
JOIN dim_product p ON 
c.product_code = p.product_code
WHERE manufacturing_cost 
IN (
		(SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost) 
		union
		(SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost)
	);