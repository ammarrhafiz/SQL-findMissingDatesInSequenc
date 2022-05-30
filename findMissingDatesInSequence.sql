/* Find Missing Dates In Sequence 
--------------------------------*/

DECLARE  @MaxDate DATE, 
         @MinDate DATE, 
         @iDate  DATE 
-- SQL Server table variable 
DECLARE  @DateSequence TABLE( 
                          DATE DATE 
                          ) 
SELECT @MaxDate = Convert(DATE,Max([date])), 
       @MinDate = Convert(DATE,Min([date])) 
FROM   [Database].[Schema].[Table]

SET @iDate = @MinDate 

WHILE (@iDate <= @MaxDate) 
  BEGIN 
    INSERT @DateSequence
    SELECT @iDate 
     
    SET @iDate = Convert(DATE,Dateadd(DAY,1,@iDate)) 
  END 

SELECT Gaps = DATE 
FROM   @DateSequence
EXCEPT 
SELECT DISTINCT Convert(DATE,[date]) 
FROM   [Database].[Schema].[Table]
GO