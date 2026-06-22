		--after cleaning checking the data in the silver laye using the pre cleaning queries

USE DataWarehouse
SELECT 
	*
FROM 
(

SELECT 
	*,
	ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) cnt
FROM silver.crm_customers_info as  bc
WHERE cst_id IS NOT NULL 
)t
WHERE cnt!=1



SELECT 
	cst_firstname,
	cst_lastname
FROM silver.crm_customers_info
WHERE TRIM(cst_firstname)!=cst_firstname OR cst_lastname!=TRIM(cst_lastname)

SELECT distinct
cst_gender
FROM silver.crm_customers_info


--the customer_info table is cleaned successfully



--now prd_info table

SELECT * FROM bronze.crm_products_info

SELECT
	prd_id,
	COUNT(*)
FROM bronze.crm_products_info
GROUP BY prd_id
HAVING COUNT(*) >1


SELECT 
* 
--DATEADD(day,-1,LEAD (prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)) as new_end_date

FROM silver.crm_product_info
WHERE prd_end_dt < prd_start_dt 
--AND prd_key IN ('AC-HE-HL-U509-B','BI-MB-BK-M68B-42','CO-RF-FR-R92R-52')

--checking of it
SELECT
	prd_id,
	COUNT(*)
FROM silver.crm_product_info
GROUP BY prd_id
HAVING COUNT(*) >1

--data is cleaned successfully


--now we do for the sales details

SELECT DISTINCT
	sls_quantity as osls_quantity,
	sls_price as osls_price,
	sls_sales as osls_sales,
	CASE WHEN sls_sales IS NULL OR sls_sales<=0	 OR sls_sales!=sls_price*sls_quantity THEN ABS(sls_quantity*sls_price)
		ELSE sls_sales
	END sls_sales,

	CASE WHEN sls_price IS NULL OR sls_price<=0	THEN ABS(sls_sales/NULLIF(sls_quantity,0))
		ELSE sls_price
	END sls_price
FROM bronze.crm_sales_details
WHERE sls_sales!=sls_price*sls_quantity
		OR sls_price IS NULL OR sls_sales IS NULL OR sls_quantity IS NULL
		OR sls_sales <=0 OR sls_quantity <=0 OR sls_price<=0
ORDER BY sls_sales,sls_price,sls_quantity


--checking

SELECT DISTINCT
	sls_quantity as osls_quantity,
	sls_price as osls_price,
	sls_sales as osls_sales
	
FROM silver.crm_sales_details
WHERE sls_sales!=sls_price*sls_quantity
		OR sls_price IS NULL OR sls_sales IS NULL OR sls_quantity IS NULL
		OR sls_sales <=0 OR sls_quantity <=0 OR sls_price<=0
ORDER BY sls_sales,sls_price,sls_quantity

SELECT 
*
FROM silver.crm_sales_details


--For erp_cust_az12

SELECT 
CASE WHEN cid  LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
	ELSE cid
END cid,
CASE WHEN bdate > GETDATE() THEN NULL
	ELSE bdate
END bdate,
CASE WHEN UPPER(TRIM(gen)) IN ('M','Male') THEN 'Male'
	 WHEN UPPER(TRIM(gen)) IN ('F','Female') THEN 'Female'
	 ELSE 'n/a'
END gen
FROM bronze.erp_cust_az12
WHERE CASE WHEN UPPER(TRIM(gen)) IN ('M','Male') THEN 'Male'
	 WHEN UPPER(TRIM(gen)) IN ('F','Female') THEN 'Female'
	 ELSE 'n/a'
END IN ('n/a')




--erp_loc_a101

SELECT 
	REPLACE(cid,'-','') cid,
	CASE 
	WHEN TRIM(cntry)='DE' THEN 'Germany'
	WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
	WHEN  TRIM(cntry) ='' OR cntry IS  NULL  THEN 'n/a'
	ELSE TRIM(cntry)
END cntry
FROM bronze.erp_loc_a101


SELECT DISTINCT 

CASE 
	WHEN TRIM(cntry)='DE' THEN 'Germany'
	WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
	WHEN  TRIM(cntry) ='' OR cntry IS  NULL  THEN 'n/a'
	ELSE cntry
END cntry

FROM bronze.erp_loc_a101


SELECT * FROM silver.crm_customers_info

SELECT DISTINCT 

CASE 
	WHEN TRIM(cntry)='DE' THEN 'Germany'
	WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
	WHEN  TRIM(cntry) ='' OR cntry IS  NULL  THEN 'n/a'
	ELSE cntry
END cntry

FROM silver.erp_loc_a101


--
SELECT 
*
FROM bronze.erp_px_cat_g1v2
WHERE TRIM(cat)!=cat OR TRIM(subcat) !=subcat

