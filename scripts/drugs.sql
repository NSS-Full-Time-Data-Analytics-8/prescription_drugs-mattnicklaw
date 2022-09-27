SELECT prescriber.npi, prescription.npi
FROM prescription FULL JOIN prescriber
USING(npi);

SELECT prescriber, prescription
FROM prescription INNER JOIN prescriber
ON prescriber.npi = npi;

SELECT *
FROM prescription;

SELECT SUM(total_claim_count), prescriber.npi
FROM prescriber INNER JOIN prescription
ON prescriber.npi = prescription.npi
GROUP BY prescriber.npi
ORDER BY sum(total_claim_count) DESC;
--NPI 1881634483
--Total Claims 897363

SELECT SUM(total_claim_count), nppes_provider_first_name
FROM prescriber INNER JOIN prescription
ON prescriber.npi = prescription.npi
GROUP BY nppes_provider_first_name
ORDER BY sum(total_claim_count) DESC;
--JAMES, 9378171 CLAIMS

SELECT SUM(total_claim_count), nppes_provider_last_org_name
FROM prescriber INNER JOIN prescription
ON prescriber.npi = prescription.npi
GROUP BY nppes_provider_last_org_name
ORDER BY sum DESC;
--SMITH, 3195936 CLAIMS

SELECT SUM(total_claim_count), specialty_description
FROM prescriber INNER JOIN prescription
ON prescriber.npi = prescription.npi
GROUP BY specialty_description
ORDER BY sum DESC
--FAMILY PRACTICE, 87771123 CLAIMS

