
SELECT distinct
	
	ci.cst_gender,
	ca.gen,
	--we are taking the crm source as the main source and the rp as secondary
	CASE WHEN ci.cst_gender ='n/a'  THEN ISNULL(ca.gen,'n/a')
		 ELSE ci.cst_gender
	END gen
FROM silver.crm_customers_info as ci
LEFT JOIN silver.erp_cust_az12 as ca
ON ci.cst_key=ca.cid
LEFT JOIN silver.erp_loc_a101 as lc
ON ci.cst_key=lc.cid

