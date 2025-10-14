CREATE DATABASE Health_Care

USE Health_Care

SELECT *
FROM Data$

SELECT DISTINCT
"Medication"
FROM Data$
ORDER BY Age ASC

SELECT
"Patient ID",
Age,
Gender,
"Blood Type",
"Medical Condition",
"Doctor",
"Hospital",
"Insurance Provider",
"Billing Amount",
"Admission Type"
FROM Data$
WHERE "Admission Type" = ''

--CREATE DIMENSION TABLE FOR HOSPITAL,INSURANCE PROVIDER, Medical Condition, Medication

CREATE TABLE DimHospltal (
 HospitalID INT IDENTITY(1,1) PRIMARY KEY,
 HospitalName VARCHAR(100),
 HospitalLongitude VARCHAR(100),
 HospitalLatitude VARCHAR(100)
 )

CREATE TABLE DimInsuranceProvider (
 ProviderID INT IDENTITY(1,1) PRIMARY KEY,
 ProvviderName VARCHAR(100) 
 )

CREATE TABLE DimMedicalCondition (
 ConditionID INT IDENTITY(1,1) PRIMARY KEY,
 ConditionName VARCHAR(100) 
 )

CREATE TABLE DimMedication (
 MedicationID INT IDENTITY(1,1) PRIMARY KEY,
 MedicationName VARCHAR(100) 
 )

 --ADDING VALUES TO THE DIMENSION TABLE

 INSERT INTO DimHospltal (HospitalName)
 SELECT DISTINCT Hospital
 FROM Data$

 UPDATE DimHospltal (HospitalLatitude, HospitalLongitude)
 SET DimHospltal.HospitalLatitude = Data$.Hospital Latitude
 JOIN 


 SELECT *
 FROM DimHospltal

INSERT INTO DimInsuranceProvider (ProvviderName)
 SELECT DISTINCT [Insurance Provider]
 FROM Data$

 INSERT INTO DimMedicalCondition(ConditionName)
 SELECT DISTINCT [Medical Condition]
 FROM Data$

 INSERT INTO DimMedication(MedicationName)
 SELECT DISTINCT Medication
 FROM Data$

 --CREATING FOREIFGN KEY IN FACTS TABLE

SELECT *
FROM Data$


ALTER TABLE Data$
ALTER COLUMN [Patient ID] VARCHAR(100) NOT NULL

ALTER TABLE Data$
ADD CONSTRAINT PK_Data PRIMARY KEY ([Patient ID])



 ALTER TABLE Data$
 ADD HospitalID INT FOREIGN KEY REFERENCES DimHospltal(HospitalID),
     ProviderID INT FOREIGN KEY REFERENCES DimInsuranceProvider(ProvviderID),
	 ConditionID INT FOREIGN KEY REFERENCES DimMedicalCondtion(CondtionID),
	 MedicationID INT FOREIGN KEY REFERENCES DimMedication(MedicationID)

ALTER TABLE Data$
ADD 
    HospitalID INT,
    ProviderID INT,
    ConditionID INT,
    MedicationID INT;

ALTER TABLE Data$
ADD DURATION INT

SELECT *
FROM Data$

UPDATE Data$
SET Duration = DATEDIFF(DAY, [Date of Admission], [Discharge Date])

SELECT 
	DISTINCT Hospital,
	HospitalID,
	[Hospital Longitude],
	[Hospital Latitude]
FROM Data$
ORDER BY HospitalID


ALTER TABLE Data$
ADD CONSTRAINT FK_Data_Hospital 
    FOREIGN KEY (HospitalID) REFERENCES DimHospltal(HospitalID),

    CONSTRAINT FK_Data_Provider 
    FOREIGN KEY (ProviderID) REFERENCES DimInsuranceProvider(ProviderID),

    CONSTRAINT FK_Data_Condition 
    FOREIGN KEY (ConditionID) REFERENCES DimMedicalCondition(ConditionID),

    CONSTRAINT FK_Data_Medication 
    FOREIGN KEY (MedicationID) REFERENCES DimMedication(MedicationID);


-- INPUTING THE FKs

UPDATE D
SET D.HospitalID = H.HospitalID
FROM Data$ AS D
JOIN DimHospltal AS H
ON D.Hospital = H.HospitalName

UPDATE D
SET D.ProviderID = H.ProviderID
FROM Data$ AS D
JOIN DimInsuranceProvider AS H
ON D.[Insurance Provider] = H.ProvviderName

UPDATE D
SET D.ConditionID = H.ConditionID
FROM Data$ AS D
JOIN DimMedicalCondition AS H
ON D.[Medical Condition] = H.ConditionName

UPDATE D
SET D.MedicationID = H.MedicationID
FROM Data$ AS D
JOIN DimMedication AS H
ON D.Medication = H.MedicationName

UPDATE H
SET H.HospitalLongitude = D.[Hospital Longitude]
FROM DimHospltal AS H
JOIN Data$ AS D
ON H.HospitalID = D.HospitalID

UPDATE H
SET H.HospitalLatitude = D.[Hospital Latitude]
FROM DimHospltal AS H
JOIN Data$ AS D
ON H.HospitalID = D.HospitalID
