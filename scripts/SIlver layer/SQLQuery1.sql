/*
USE DataWarehouse

SELECT TOP 1000
	*
FROM silver.crm_customers_info
*/

USE DataWarehouse
CREATE Table silver.crm_customers_info
(
	cst_id INT ,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_maritalstatus NVARCHAR(50),
	cst_gender  NVARCHAR(50),
	cst_create_date DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()

)


Create Table silver.crm_product_info
(
	prd_id INT,
	cat_id NVARCHAR(50),
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
	
)
IF OBJECT_ID('silver.crm_sales_details') IS NOT NULL
	DROP TABLE silver.crm_sales_details
CREATE TABLE silver.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt DATE,
    sls_ship_dt  DATE,
    sls_due_dt   DATE,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);


CREATE TABLE silver.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);



CREATE TABLE silver.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

--it checks that the table User defined('U') is exit or not?
IF OBJECT_ID('silver.erp_px_cat_g1v2','U') IS NOT NULL
--if it exist then drop the table and create newer
DROP TABLE silver.erp_px_cat_g1v2
GO
CREATE TABLE silver.erp_px_cat_g1v2 (
id           NVARCHAR(50),
cat          NVARCHAR(50),
subcat       NVARCHAR(50),
maintenance  NVARCHAR(50),
dwh_create_date DATETIME2 DEFAULT GETDATE()
);
