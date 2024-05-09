/* Write your T-SQL query statement below */

/*Case 1 - when there is a product_id from product table present in unitssold table*/
with cte_sales as
(select p.product_id, 
coalesce(round(sum(p.price * u.units) * 1.00 / sum(u.units),2),0.00) as average_price
from prices p
left join unitssold u
on p.product_id = u.product_id
and u.purchase_date between p.start_date and p.end_date
group by p.product_id)
select * from cte_sales 
union
/*when product_id is not present in unitssold table, it should be hard-coded to 0.00, to pass all the test cases*/
select p.product_id, 0.00 as average_price
from Prices p where p.product_id
not in (select product_id from UnitsSold)
