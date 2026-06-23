--build the star schema for gold layer

USE DataWarehouse


--Execute the view one by one


--create a view so we do not need to write this logic again and again
CREATE VIEW gold.dim_customers AS
(

SELECT 
	ROW_NUMBER() OVER(ORDER BY ci.cst_id) customer_key,
	ci.cst_id as customer_id,
	ci.cst_key as customer_number,
	ci.cst_firstname as firstname,
	ci.cst_lastname as lastname,
	lc.cntry as country,
	ci.cst_maritalstatus as marital_status,
	--we are taking the crm source as the main source and the rp as secondary
	CASE WHEN ci.cst_gender ='n/a'  THEN ISNULL(ca.gen,'n/a')
		 ELSE ci.cst_gender
	END gender,
	ca.bdate as birthdate,
	ci.cst_create_date as create_date 
FROM silver.crm_customers_info as ci
LEFT JOIN silver.erp_cust_az12 as ca
ON ci.cst_key=ca.cid
LEFT JOIN silver.erp_loc_a101 as lc
ON ci.cst_key=lc.cid
)


--for the product information
CREATE VIEW gold.dim_products AS
(

SELECT 
	ROW_NUMBER() OVER(ORDER BY cpi.prd_start_dt ,cpi.prd_id) as product_key,
	cpi.prd_id as product_id,
	cpi.prd_key as product_number,
	cpi.prd_nm as product_name,
	cpi.cat_id as category_id,
	epi.cat as category,
	epi.subcat as subcategory,
	epi.maintenance,
	cpi.prd_cost as cost,
	cpi.prd_line as product_line,
	cpi.prd_start_dt as start_date
FROM silver.crm_product_info as cpi
LEFT JOIN silver.erp_px_cat_g1v2 as epi
ON cpi.cat_id=epi.id
WHERE cpi.prd_end_dt IS NULL --this gives as the currently running products
)



CREATE VIEW gold.fact_sales AS (
SELECT 
	sld.sls_ord_num as order_number,
	dp.product_key,
	dc.customer_key,
	sld.sls_order_dt as order_date,
	sld.sls_due_dt as due_date,
	sld.sls_sales as sales_amount,
	sld.sls_quantity as quantity,
	sld.sls_price as price
FROM silver.crm_sales_details as sld
LEFT JOIN gold.dim_products as dp
ON sld.sls_prd_key=dp.product_number
LEFT JOIN gold.dim_customers as dc
ON dc.customer_id=sld.sls_cust_id
)
