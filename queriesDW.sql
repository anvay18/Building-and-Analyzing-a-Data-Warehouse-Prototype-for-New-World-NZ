--Query1
Select * from ( Select ds.product_name, SUM(wf.SALE) total_sale 
From d_products ds, w_facts wf, d_time dt
where wf.product_id = ds.product_id
and wf.time_id = dt.time_id and dt.cal_month = 'SEPTEMBER' 
group by ds.product_name
ORDER BY SUM(wf.SALE) DESC ) where ROWNUM < 2;

--Query2

Select * from (select ds.supplier_name,SUM(wf.sale) total_sale
from d_suppliers ds, w_facts wf
where wf.supplier_id = ds.supplier_id 
group by ds.supplier_name
order by total_sale DESC ) where ROWNUM < 4;

--Query3
select * from
(select * from
(select ds.store_name, SUM(wf.sale) total_sale
FROM d_stores ds, w_facts wf, d_time dt
where wf.store_id = ds.store_id
and wf.time_id = dt.time_id
and dt.cal_month = 'SEPTEMBER'
group by ds.store_name)
order by total_sale DESC) WHERE ROWNUM < 4;

--Query4

SELECT store_name, SUM(quarter_1) quarter_1,SUM(quarter_2) quarter_2,SUM(quarter_3) quarter_3,SUM(quarter_4) quarter_4
FROM (SELECT store_name, 
      CASE WHEN T_Q=1 THEN total_sale END AS quarter_1,
      CASE WHEN T_Q=2 THEN total_sale END AS quarter_2,
      CASE WHEN T_Q=3 THEN total_sale END AS quarter_3, 
      CASE WHEN T_Q=4 THEN total_sale END AS quarter_4
      FROM(SELECT d_stores.store_name, d_time.CAL_QUARTER T_Q,
                  SUM(sale) total_sale
                  FROM w_facts, d_time, d_stores
                  WHERE d_time.time_id = w_facts.time_id
                  AND d_stores.store_id = w_facts.store_id
               GROUP BY d_stores.store_name, d_time.CAL_QUARTER
           ORDER BY d_stores.store_name))
         GROUP BY store_name
         ORDER BY store_name;
          
--Query5
DROP MATERIALIZED VIEW STORE_PRODUCT_ANALYSIS;

CREATE MATERIALIZED VIEW STORE_PRODUCT_ANALYSIS BUILD IMMEDIATE REFRESH FORCE ON DEMAND
AS
SELECT
    ds.store_name, dp.product_name, sum(wf.price * wf.quantity) AS "TOTAL_SALES"
    
    FROM w_FACTS wf INNER JOIN D_PRODUCTS dp ON dp.product_id = wf.product_id
     INNER JOIN D_STORES ds ON ds.store_id = wf.store_id
     GROUP BY
     ds.store_name,dp.product_name
     ORDER BY ds.store_name, dp.product_name;
     
Select * from STORE_PRODUCT_ANALYSIS;

--Query6
DROP MATERIALIZED VIEW MONTH_STORE_ANALYSIS;

CREATE MATERIALIZED VIEW MONTH_STORE_ANALYSIS BUILD IMMEDIATE REFRESH FORCE ON DEMAND
AS
SELECT
    dt.cal_month, ds.store_name, SUM(wf.price * wf.quantity) AS "TOTAL_SALES"
    
    FROM w_FACTS wf 
    INNER JOIN D_TIME dt ON dt.time_id = wf.time_id
     INNER JOIN D_STORES ds ON ds.store_id = wf.store_id
     GROUP BY
     dt.CAL_MONTH,ds.STORE_NAME
     ORDER BY dt.CAL_MONTH, ds.STORE_NAME;
     
Select * from MONTH_STORE_ANALYSIS;
    
    
      