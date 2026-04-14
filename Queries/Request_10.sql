/* 10. Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? 
    The final output contains these fields, 
    division 
    product_code */
    
    
    with product_sales as
		(select  p.division, s.product_code, p.product, p.variant, sum(s.sold_quantity) as total_sold_quantity
		from fact_sales_monthly s
		join dim_product p on
		s.product_code = p.product_code
		where fiscal_year = 2021
		group by p.division, s.product_code),
        
	cte2 as    
		(select *,
		rank() over(partition by division order by total_sold_quantity desc) as Rank_Order
		from product_sales)
        
	select division,product_code, concat(product, " - ", variant) as product, total_sold_quantity, rank_order from cte2
    where Rank_Order <=3;
