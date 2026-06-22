--pre cleansing script

--this cript is for the data faults checking from bronze to silver data 

--primary key
USE DataWarehouse


SELECT 
	*
FROM 
(

SELECT 
	*,
	ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) cnt
FROM bronze.crm_customers_info as  bc
WHERE cst_id IS NOT NULL 
)t
WHERE cnt=1



SELECT 
	cst_firstname,
	cst_lastname
FROM bronze.crm_customers_info
WHERE TRIM(cst_firstname)!=cst_firstname OR cst_lastname!=TRIM(cst_lastname)

SELECT distinct
cst_gender
FROM bronze.crm_customers_info



--erp_px_cat

SELECT 
*
FROM bronze.erp_px_cat_g1v2
