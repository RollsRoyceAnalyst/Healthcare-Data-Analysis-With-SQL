
-- 1.	What are the most common age groups, genders, and blood types among patients? Are certain groups being admitted more often than others

--SUBQUERY
SELECT
	Age_group,
	COUNT(*) AS Total_each_group
FROM
(
SELECT 
	Age,
	CASE
		WHEN Age < 13 THEN 'Child'
		WHEN Age BETWEEN 13 AND 19 THEN 'Teenager'
		WHEN Age BETWEEN 20 AND 34 THEN 'Young Adult'
		WHEN Age BETWEEN 35 AND 49 THEN 'Adult'
		WHEN Age BETWEEN 50 AND 64 THEN 'Middle-aged'
		WHEN Age >= 65 THEN 'Senior'
	END AS Age_group

FROM Data$)t
GROUP BY Age_group
ORDER BY Total_each_group	DESC

--CTE
WITH Age_group AS (SELECT 
	Age,
	CASE
		WHEN Age < 13 THEN 'Child'
		WHEN Age BETWEEN 13 AND 19 THEN 'Teenager'
		WHEN Age BETWEEN 20 AND 34 THEN 'Young Adult'
		WHEN Age BETWEEN 35 AND 49 THEN 'Adult'
		WHEN Age BETWEEN 50 AND 64 THEN 'Middle-aged'
		WHEN Age >= 65 THEN 'Senior'
	END AS Age_group
FROM Data$)

SELECT 
	Age_group, 
	COUNT(*) AS totalAge
FROM Age_group
GROUP BY Age_group
ORDER BY totalAge DESC

SELECT 
	Gender,
	COUNT(*) as Total_gender
FROM Data$
GROUP BY Gender
ORDER BY Total_gender DESC

SELECT
	[Blood Type],
	COUNT(*) AS totalEachBloodType
FROM Data$
GROUP BY [Blood Type]
ORDER BY totalEachBloodType DESC


-- 2. 2.	Which medical conditions are diagnosed the most, and do they affect certain groups of people more than others?


SELECT
	C.ConditionName,
	COUNT(*) AS totalCondition
FROM Data$ AS D
JOIN DimMedicalCondition AS C
ON D.ConditionID = C.ConditionID
GROUP BY C.ConditionName
ORDER BY totalCondition DESC

SELECT 
	C.ConditionName,
	D.Gender,
	COUNT(*) AS totalMedicalConditionByGender

FROM DimMedicalCondition AS C
JOIN Data$ AS D
ON D.ConditionID = C.ConditionID
GROUP BY C.ConditionName, D.Gender
ORDER BY C.ConditionName, totalMedicalConditionByGender DESC

SELECT
	C.ConditionName,
	CASE
		WHEN Age < 13 THEN 'Child'
		WHEN Age BETWEEN 13 AND 19 THEN 'Teenager'
		WHEN Age BETWEEN 20 AND 34 THEN 'Young Adult'
		WHEN Age BETWEEN 35 AND 49 THEN 'Adult'
		WHEN Age BETWEEN 50 AND 64 THEN 'Middle-aged'
		WHEN Age >= 65 THEN 'Senior'
	END AS Age_group,
	COUNT(*) AS totalConitionByAgeGroup
FROM DimMedicalCondition AS C
JOIN Data$ AS D
on c.ConditionID = D.ConditionID
GROUP BY C.ConditionName, CASE
		WHEN Age < 13 THEN 'Child'
		WHEN Age BETWEEN 13 AND 19 THEN 'Teenager'
		WHEN Age BETWEEN 20 AND 34 THEN 'Young Adult'
		WHEN Age BETWEEN 35 AND 49 THEN 'Adult'
		WHEN Age BETWEEN 50 AND 64 THEN 'Middle-aged'
		WHEN Age >= 65 THEN 'Senior'
	END 
ORDER BY C.ConditionName, totalConitionByAgeGroup DESC 

SELECT
	C.ConditionName,
	D.[Blood Type],
	COUNT(*) AS totalConditionByBloodType
FROM DimMedicalCondition AS C
JOIN Data$ AS D
ON C.ConditionID = D.ConditionID
GROUP BY C.ConditionName, D.[Blood Type]
ORDER BY C.ConditionName, totalConditionByBloodType DESC


-- 3.	How long do patients typically stay in the hospital for different conditions?

--Does this vary depending on the hospital or type of admission (emergency, urgent, or planned)?

SELECT
	AVG(Duration)
FROM Data$
GROUP BY Duration
ORDER BY Duration DESC

SELECT *
FROM Data$


SELECT 
	C.ConditionName,
	D.[Admission Type],
	AVG(Duration) AS AverageDuration

FROM Data$ AS D
JOIN DimMedicalCondition AS C
ON D.ConditionID = C.ConditionID
GROUP BY C.ConditionName, D.[Admission Type]
ORDER BY c.ConditionName,D.[Admission Type], AverageDuration DESC



SELECT 
	H.HospitalName,
	C.ConditionName,
	AVG(Duration) AS AverageDuration

FROM Data$ AS D
JOIN DimMedicalCondition AS C
ON D.ConditionID = C.ConditionID
JOIN DimHospltal as H
ON H.HospitalID = D.HospitalID
GROUP BY H.HospitalName, C.ConditionName
ORDER BY H.HospitalName, c.ConditionName, AverageDuration DESC



SELECT 
	C.ConditionName,
	AVG(Duration) AS AverageDuration

FROM Data$ AS D
JOIN DimMedicalCondition AS C
ON D.ConditionID = C.ConditionID
GROUP BY C.ConditionName
ORDER BY c.ConditionName, AverageDuration DESC


-- 4. 4.	How much does treatment usually cost for each condition? 
-- Are there big differences in costs between hospitals or insurance providers?

SELECT
	C.ConditionName,
	ROUND(AVG([Billing Amount]), 2) AS avrageBilling
FROM Data$ AS D
JOIN DimMedicalCondition AS C
ON D.ConditionID = C.ConditionID
GROUP BY C.ConditionName
ORDER BY C.ConditionName, avrageBilling DESC


SELECT
	H.HospitalName,
	C.ConditionName,
	ROUND(AVG([Billing Amount]), 2) AS avrageBilling
FROM Data$ AS D
JOIN DimMedicalCondition AS C
ON D.ConditionID = C.ConditionID
JOIN DimHospltal AS H
ON H.HospitalID = D.HospitalID
GROUP BY H.HospitalName, C.ConditionName
ORDER BY H.HospitalName, avrageBilling DESC

SELECT*
FROM DimInsuranceProvider

SELECT
	P.ProvviderName,
	C.ConditionName,
	ROUND(AVG([Billing Amount]), 2) AS avrageBilling
FROM Data$ AS D
JOIN DimMedicalCondition AS C
ON D.ConditionID = C.ConditionID
JOIN DimInsuranceProvider AS P
ON P.ProviderID = D.ProviderID
GROUP BY P.ProvviderName, C.ConditionName
ORDER BY P.ProvviderName, avrageBilling DESC



-- 5. 5.	Which hospitals are treating the most patients, and how do they compare in terms of patient outcomes, like test results?

SELECT
	H.HospitalName,
	COUNT(D.[Patient ID]) AS patientNumber
FROM Data$ AS D
JOIN DimHospltal AS H
ON D.HospitalID = H.HospitalID
GROUP BY H.HospitalName
ORDER BY patientNumber DESC

SELECT*
FROM Data$

SELECT
	H.HospitalName,
	D.[Test Results],
	COUNT(D.[Patient ID]) AS patientNumber
FROM Data$ AS D
JOIN DimHospltal AS H
ON D.HospitalID = H.HospitalID
GROUP BY H.HospitalName, D.[Test Results]
ORDER BY H.HospitalName, patientNumber DESC


--6.	What medications are most often prescribed for each condition? Are they being used consistently across hospitals?

SELECT 
	
	C.ConditionName,
	M.MedicationName,
	COUNT(*) AS medicatiobByCondition
FROM Data$ AS D
JOIN DimMedication AS M
ON D.MedicationID = M.MedicationID
JOIN DimMedicalCondition AS C
ON C.ConditionID = D.ConditionID
GROUP BY C.ConditionName, M.MedicationName 
ORDER BY C.ConditionName, medicatiobByCondition DESC

SELECT*
FROM Data$

SELECT 
	H.HospitalName,
	C.ConditionName,
	M.MedicationName,
	COUNT(*) AS medicatiobByCondition
FROM Data$ AS D
JOIN DimMedication AS M
ON D.MedicationID = M.MedicationID
JOIN DimMedicalCondition AS C
ON C.ConditionID = D.ConditionID
JOIN DimHospltal AS H
ON H.HospitalID = D.HospitalID
GROUP BY H.HospitalName, C.ConditionName, M.MedicationName
ORDER BY H.HospitalName,C.ConditionName, medicatiobByCondition DESC

-- 7. 8.	Which insurance companies are covering the most patients, and how does that relate to treatment costs and patient outcomes?

SELECT 
	P.[ProvviderName],
	COUNT([Patient ID]) AS insuranceByProvider
FROM Data$ AS D
JOIN DimInsuranceProvider AS P
ON P.ProviderID = D.ProviderID
GROUP BY P.[ProvviderName]
ORDER BY insuranceByProvider DESC



SELECT 
	P.[ProvviderName],
	D.[Test results],
	COUNT([Patient ID]) AS insuranceByProvider,
	AVG([Billing Amount]) AS Average_treatment_cost
FROM Data$ AS D
JOIN DimInsuranceProvider AS P
ON P.ProviderID = D.ProviderID
GROUP BY P.[ProvviderName], D.[Test results]
ORDER BY P.[ProvviderName], insuranceByProvider DESC


--7.	How are patients admitted - mostly through emergency, urgent, or planned admissions - and how does that impact the length of stay or treatment costs?
SELECT 
	[Admission Type],
	COUNT(*) OVER(PARTITION BY [Admission Type] ) as admissionTypes,
	AVG(Duration) OVER (PARTITION BY [Admission Type])
FROM Data$
ORDER BY admissionTypes DESC

SELECT
	[Admission Type],
	AVG(Duration) AS averageDuration,
	COUNT(*) AS admissionType,
	AVG([bILLING aMOUNT])
FROM Data$
GROUP BY [Admission Type]
ORDER BY admissionType DESC