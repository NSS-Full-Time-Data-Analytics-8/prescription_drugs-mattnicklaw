--Q1A
SELECT SUM(total_claim_count), prescriber.npi
FROM prescriber INNER JOIN prescription
ON prescriber.npi = prescription.npi
GROUP BY prescriber.npi
ORDER BY sum(total_claim_count) DESC;
--NPI 1881634483, Total Claims 897363


--Q1B
SELECT SUM(total_claim_count), nppes_provider_first_name
FROM prescriber INNER JOIN prescription
ON prescriber.npi = prescription.npi
GROUP BY nppes_provider_first_name
ORDER BY sum(total_claim_count) DESC;
--JAMES, 9378171 CLAIMS


--Q1B
SELECT SUM(total_claim_count), nppes_provider_last_org_name
FROM prescriber INNER JOIN prescription
ON prescriber.npi = prescription.npi
GROUP BY nppes_provider_last_org_name
ORDER BY sum DESC;
--SMITH, 3195936 CLAIMS


--2A
SELECT SUM(total_claim_count), specialty_description
FROM prescriber INNER JOIN prescription
ON prescriber.npi = prescription.npi
GROUP BY specialty_description
ORDER BY sum DESC;
--FAMILY PRACTICE, 87771123 CLAIMS


--2B,2C,2D
SELECT opioid_drug_flag
FROM drug;
--That's a NOPE

--Q3A
SELECT total_drug_cost, drug.drug_name
FROM prescription INNER JOIN drug
ON prescription.drug_name = drug.drug_name
GROUP BY drug.drug_name, total_drug_cost
ORDER BY total_drug_cost DESC;
--ESBRIET, 2829174.3


--Q3B
SELECT drug.drug_name, total_drug_cost, total_day_supply, ROUND(total_drug_cost/total_day_supply,2) AS drug_per_day
FROM prescription INNER JOIN drug
ON prescription.drug_name = drug.drug_name
GROUP BY drug.drug_name, total_drug_cost, total_day_supply, drug_per_day
ORDER BY drug_per_day DESC;
--GAMMAGARD LIQUID, 7141.11

--Q4A
SELECT opioid_drug_flag, antibiotic_drug_flag, drug.drug_name,
	CASE WHEN opioid_drug_flag = 'Y' THEN 'opioid'
		 WHEN antibiotic_drug_flag = 'Y' THEN 'antibiotic'
		 ELSE 'neither' END AS drug_type
FROM drug;

--Q4B
--Subquery of Q4A

--Q5A
SELECT *
FROM cbsa
WHERE cbsaname LIKE '%TN%';
-- 168 in TN

--Q5B
SELECT cbsa.cbsaname, cbsa.fipscounty, population.population
FROM cbsa FULL JOIN population
USING (fipscounty)
WHERE population IS NOT NULL
ORDER BY population DESC;
--LARGEST: Memphis, TN-MS-AR ... 937847

--Q5B
SELECT cbsa.cbsaname, cbsa.fipscounty, population.population
FROM cbsa FULL JOIN population
USING (fipscounty)
WHERE population IS NOT NULL
AND cbsaname IS NOT NULL
ORDER BY population ASC;
--Nashville-Davidson--Murfreesboro--Franklin, TN ... 8773
--Too many duplicate values prob not a FULL JOIN

--Q6A
WITH bigboyclub as  (SELECT drug_name, total_claim_count
					FROM prescription
					WHERE total_claim_count >= 3000)

SELECT opioid_drug_flag, drug.drug_name, total_claim_count,
	CASE WHEN opioid_drug_flag = 'Y' THEN 'opioid'
		 ELSE 'nope-ioid' END AS drug_type
FROM drug INNER JOIN bigboyclub ON drug.drug_name = bigboyclub.drug_name;
--MY BRAIN IS MUSH! BUT THIS IS FUN. (and incorrect, but I'll get there)