--Load the data


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	BEGIN TRY
		PRINT '=========================================='
		PRINT 'Loading the Data To Tables'
		DECLARE @start_time DATETIME,@end_time DATETIME;

		PRINT '----------------------------'
		PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
		PRINT 'Loading the table:bronze.crm_customers_info'
		SET @start_time=GETDATE()
		TRUNCATE TABLE bronze.crm_customers_info
		BULK INSERT  bronze.crm_customers_info
		FROM 'D:\SQL(Data with Baraa)\SQL Project\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		WITH
		(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SET @end_time=GETDATE()
		PRINT 'Total Time Taken is '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'
		PRINT 'Loding is completed '
		PRINT '<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
		
		
		
		PRINT '----------------------------'
		PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
		PRINT 'Loading the table:bronze.crm_products_info'
		SET @start_time=GETDATE()
		TRUNCATE TABLE bronze.crm_products_info

		BULK INSERT  bronze.crm_products_info
		FROM 'D:\SQL(Data with Baraa)\SQL Project\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		WITH
		(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SET @end_time=GETDATE()
		PRINT 'Total Time Taken is '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'
		PRINT 'Loding is completed '
		PRINT '<<<<<<<<<<<<<<<<<<<<<<<<<<<<'



		PRINT '----------------------------'
		PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
		PRINT 'Loading the table:bronze.crm_sales_details'
		SET @start_time=GETDATE()
		TRUNCATE TABLE bronze.crm_sales_details
		BULK INSERT  bronze.crm_sales_details
		FROM 'D:\SQL(Data with Baraa)\SQL Project\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		WITH
		(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SET @end_time=GETDATE()
		PRINT 'Total Time Taken is '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'
		PRINT 'Loding is completed '
		PRINT '<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
		


		PRINT '----------------------------'
		PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
		PRINT 'Loading the table:bronze.erp_cust_az12'
		SET @start_time=GETDATE()
		TRUNCATE TABLE bronze.erp_cust_az12
		BULK INSERT  bronze.erp_cust_az12
		FROM 'D:\SQL(Data with Baraa)\SQL Project\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
		WITH
		(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SET @end_time=GETDATE()
		PRINT 'Total Time Taken is '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'
		PRINT 'Loding is completed '
		PRINT '<<<<<<<<<<<<<<<<<<<<<<<<<<<<'


		PRINT '----------------------------'
		PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
		PRINT 'Loading the table:bronze.erp_loc_a101'
		SET @start_time=GETDATE()
		TRUNCATE TABLE bronze.erp_loc_a101
		BULK INSERT  bronze.erp_loc_a101
		FROM 'D:\SQL(Data with Baraa)\SQL Project\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
		WITH
		(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SET @end_time=GETDATE()
		PRINT 'Total Time Taken is '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'
		PRINT 'Loding is completed '
		PRINT '<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
		




		PRINT '----------------------------'
		PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
		PRINT 'Loading the table:bronze.erp_px_cat_g1v2'
		SET @start_time=GETDATE()
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		BULK INSERT  bronze.erp_px_cat_g1v2
		FROM 'D:\SQL(Data with Baraa)\SQL Project\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH
		(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SET @end_time=GETDATE()
		PRINT 'Total Time Taken is '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'
		PRINT 'Loding is completed '
		PRINT '<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
		


		PRINT 'Data is Loaded to Tables'
		PRINT '=========================================='
	END TRY


	BEGIN CATCH
		PRINT 'There is some error while loading the date'
		PRINT 'Error Message: '+ ERROR_MESSAGE()
		
	END CATCH
		/*SELECT  
		COUNT(*)
		FROM bronze.erp_px_cat_g1v2 as ep*/

END


EXECUTE bronze.load_bronze