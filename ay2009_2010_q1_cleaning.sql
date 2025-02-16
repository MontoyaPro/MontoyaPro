SELECT *
FROM fl_dashboard_ay2009_2010_q1;

#Need to rename all the columns that did not transfer well

ALTER TABLE fl_dashboard_ay2009_2010_q1 
RENAME COLUMN MyUnknownColumn TO OPE_ID;

ALTER TABLE fl_dashboard_ay2009_2010_q1 
RENAME COLUMN School_Name TO `School Name`;

ALTER TABLE fl_dashboard_ay2009_2010_q1 
RENAME COLUMN `MyUnknownColumn_[1]` TO State;

ALTER TABLE fl_dashboard_ay2009_2010_q1 
RENAME COLUMN `MyUnknownColumn_[19]` TO `GRAD PLUS $ of Disbursements`;

#remove the uneeded first row

DELETE FROM fl_dashboard_ay2009_2010_q1
WHERE OPE_ID = 'OPE ID';

#Standardize blanks in the dataset
#Zero was chosen as the blank in most columns as the data is saying that there was none of that type of loan

SELECT *
FROM fl_dashboard_ay2009_2010_q1
WHERE `GRAD PLUS $ of Disbursements` = '0' OR `GRAD PLUS $ of Disbursements` = '$-';

UPDATE fl_dashboard_ay2009_2010_q1
SET `GRAD PLUS $ of Disbursements` = '0' 
WHERE `GRAD PLUS $ of Disbursements` = '$-';

UPDATE fl_dashboard_ay2009_2010_q1
SET `GRAD PLUS $ of Disbursements` = TRIM(`GRAD PLUS $ of Disbursements`);

#Check school type column for any errors
SELECT DISTINCT `School Type`
FROM fl_dashboard_ay2009_2010_q1;

SELECT *
FROM fl_dashboard_ay2009_2010_q1
LIMIT 10000;

#remove leading $, commas and trailing zeros from columns
UPDATE fl_dashboard_ay2009_2010_q1
SET `GRAD PLUS $ of Disbursements` = REPLACE(`GRAD PLUS $ of Disbursements`, '$', '');

UPDATE fl_dashboard_ay2009_2010_q1
SET `GRAD PLUS $ of Disbursements` = SUBSTRING_INDEX(`GRAD PLUS $ of Disbursements`, '.', 1);

#set numbered columns to numbers
ALTER TABLE fl_dashboard_ay2009_2010_q1
MODIFY COLUMN `GRAD PLUS $ of Disbursements` INT; 

#find any diplicate OPE_IDs
SELECT OPE_ID, COUNT(*) as CNT 
FROM fl_dashboard_ay2009_2010_q1
GROUP BY OPE_ID HAVING CNT > 1;