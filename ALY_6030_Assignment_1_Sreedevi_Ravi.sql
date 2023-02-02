#Create a database for car information
CREATE SCHEMA IF NOT EXISTS CarInfo;

#View all schemas
SHOW SCHEMAS;

#Use CarInfo as the database in which all the tables will be stored
USE CarInfo;

#In case the same table exists, uncomment the below line and drop the table
#DROP TABLE IF EXISTS Cars;

#Create a table to store the car information. 
#Add a column ID with auto increment. This is to create a unique ID for each entry in the table

CREATE TABLE Cars (
	    ID BIGINT AUTO_INCREMENT NOT NULL,
        CarName VARCHAR(255),
        MPG NUMERIC(32,4),
        Cylinders INT,
        Displacement NUMERIC(32,4),
        Horsepower NUMERIC(32,4),
        Weight DECIMAL(8,3),
        Acceleration NUMERIC(32,4),
        Model INT,
        Origin VARCHAR(255),
        PRIMARY KEY (ID)
);

#Perform a select to see the table structure
SELECT * FROM Cars;

#Load data into the table Cars by using the import from external file option in MySQL Workbench
#The below two commands are run by MySQL Workbench during import
#TRUNCATE TABLE `carinfo`.`cars`;
#PREPARE stmt FROM 'INSERT INTO `carinfo`.`cars` (`CarName`,`MPG`,`Cylinders`,`Displacement`,`Horsepower`,`Weight`,`Acceleration`,`Model`,`Origin`) VALUES(?,?,?,?,?,?,?,?,?)'

#Run a select after importing values
SELECT * FROM Cars;

#Do a count to verify the count in csv file
SELECT COUNT(ID) FROM Cars;

#Form three business questions and answer using SQL

#Question 1) How many automobiles of US origin were made in the years 1980, 1981, and 1982 and have an MPG between 30 and 50?
SELECT COUNT(ID) AS COUNT
FROM Cars WHERE Origin = 'US' 
AND MPG BETWEEN 30 AND 50
AND MPG IS NOT NULL
AND Model IN (80,81,82);

###Question 2) What is the average fuel efficiency and average weight of cars with respect to the number of cylinders?
###The cars should have an average weight greater than 2000 pounds.The records should be ordered in increasing order of their MPG.
SELECT ROUND(AVG(MPG),2) AS 'Average MPG',ROUND(AVG(Weight),2) AS 'Average Weight',Cylinders 
FROM Cars 
GROUP BY Cylinders 
HAVING AVG(Weight) > 2000
ORDER BY AVG(MPG);

###Question3) What is min and max acceleration for a car based on number of cylinders.
# The records to be ordered on decreasing horsepower.
SELECT MIN(Acceleration),MAX(Acceleration),Cylinders,Avg(Horsepower) FROM Cars
GROUP BY Cylinders ORDER BY Avg(Horsepower) DESC; 