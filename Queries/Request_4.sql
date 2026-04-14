/* 4. Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? The final output contains these fields, 
segment
product_count_2020
product_count_2021 
difference */

with cte1 as
	(select p.segment,
	count(distinct case when s.fiscal_year = 2020 then p.product_code end) as product_count_2020,
	count(distinct case when s.fiscal_year = 2021 then p.product_code end) as product_count_2021
	from fact_sales_monthly s
	join dim_product p on
	s.product_code = p.product_code
    group by p.segment)
    
select *, (product_count_2021-product_count_2020) as difference from cte1
order by difference desc;
