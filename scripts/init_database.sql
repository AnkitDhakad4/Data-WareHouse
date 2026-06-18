
/*
Purpose: 
			this script is creating a new data base and the three schemas bronze,silver and gold in it
*/


use master


CREATE DATABASE DataWarehouse
GO 
Use DataWarehouse
GO --tells sql to complete the execution of  the upper command then go for the lower one
CREATE SCHEMA bronze
GO 
CREATE SCHEMA silver
GO
CREATE SCHEMA gold
