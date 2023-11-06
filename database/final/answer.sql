-- 1
SELECT pres_name, death_age
FROM president
ORDER BY pres_name;

-- 2
SELECT pres_name, party
FROM president
ORDER BY party, pres_name;

-- 3
SELECT death_age
FROM president
ORDER BY party, pres_name;

-- 4
SELECT pres_name, pr_age, spouse_name, sp_age
FROM pres_marriage
ORDER BY pr_age DESC, sp_age;

-- 5
SELECT *
FROM president
WHERE pres_name = 'Reagan R';

-- 6
SELECT *
FROM president
WHERE pres_name != 'Reagan R';

-- 7
SELECT *
FROM president
WHERE death_age < 70
ORDER BY death_age DESC;

-- 8
SELECT *
FROM president
WHERE pres_name BETWEEN 'Elisenhower' AND 'Nixon'
ORDER BY pres_name;

-- 9 OR
SELECT *
FROM president
WHERE yrs_serv = 2
	OR yrs_serv = 4
	OR yrs_serv = 6
	OR yrs_serv = 8
ORDER BY yrs_serv;

-- 9 IN
SELECT *
FROM president
WHERE yrs_serv IN (2, 4, 6, 8)
ORDER BY yrs_serv;

-- 10
SELECT *
FROM president
WHERE party = 'Republican'
ORDER BY pres_name;

-- 11
SELECT pres_name, spouse_name, nr_children
FROM pres_marriage
WHERE nr_children > 5
ORDER BY nr_children DESC;

-- 12
SELECT pres_name, spouse_name, pr_age, sp_age
FROM pres_marriage
WHERE pr_age BETWEEN 20 AND 29
	AND sp_age BETWEEN 13 AND 19;

-- 13
SELECT pres_name, spouse_name, pr_age, sp_age
FROM pres_marriage
WHERE pr_age = sp_age
ORDER BY pr_age;

-- 14
SELECT AVG(pr_age)
FROM pres_marriage;

-- 15
SELECT AVG(nr_children)
FROM pres_marriage
WHERE mar_year < 1900;

-- 16
SELECT AVG(votes)
FROM election
WHERE winner_loser_indic = 'W'
	AND election_year > 1900;

-- 17
SELECT COUNT(DISTINCT(election_year))
FROM election;

-- 18
SELECT COUNT(DISTINCT(candidate))
FROM election
WHERE winner_loser_indic = 'L';

-- 19 NULL
SELECT COUNT(state_name)
FROM state
WHERE admin_entered IS NULL;

-- 19 SubQuery
SELECT COUNT(state_name)
FROM state
WHERE year_entered = (
	SELECT MIN(year_entered)
	FROM state
);

-- 20
SELECT AVG(death_age)
FROM president
WHERE party = 'Republican'
	AND birth_yr > 1850;

-- 21
SELECT COUNT(pres_name)
FROM pres_marriage;

-- 22
SELECT COUNT(pres_name)
FROM president
WHERE death_age > 1985;

-- 23
SELECT MAX(admin_nr)
FROM administration;

-- 24
SELECT COUNT(DISTINCT(pres_name))
FROM administration;

-- 25
SELECT MIN(sp_age)
FROM pres_marriage;

-- 26
SELECT SUM(nr_children)
FROM pres_marriage
WHERE sp_age < 20;

-- 27
SELECT AVG(ABS(pr_age -sp_age))
FROM pres_marriage;

-- 28
SELECT COUNT(*)
FROM pres_marriage
WHERE pr_age -sp_age > 2;

-- 29
SELECT AVG(pr_age) / AVG(sp_age)
FROM pres_marriage;

-- 30
SELECT *
FROM pres_marriage
WHERE sp_age - pr_age = 1;

-- 31
SELECT MIN(yrs_serv/cast(death_age as FLOAT)) *100,
	MAX(yrs_serv/cast(death_age as FLOAT)) *100,
	AVG(yrs_serv) / AVG(death_age) * 100
FROM president
WHERE death_age IS NOT NULL;

-- 32
SELECT election_year, COUNT(candidate)
FROM election
GROUP BY election_year
HAVING election_year >= 1900
ORDER BY election_year;

-- 33
SELECT COUNT(candidate)
FROM election
GROUP BY election_year
HAVING election_year > 1899
ORDER BY election_year;

-- 34
SELECT pres_name
FROM pres_marriage
GROUP BY pres_name
HAVING COUNT(pres_name) > 1
	AND MAX(PR_AGE)- 2*MIN(PR_AGE) = 0;

-- 35
SELECT election_year, COUNT(candidate)
FROM election
GROUP BY election_year
HAVING election_year > 1870
	AND COUNT(candidate) > 2;

-- 36
SELECT AVG(pr_age), AVG(sp_age)
FROM pres_marriage;

-- 37
SELECT pres_name, AVG(nr_children)
FROM pres_marriage
GROUP by pres_name;

-- 38
SELECT pres_name, SUM(nr_children)
FROM pres_marriage
GROUP by pres_name
HAVING COUNT(pres_name) > 1
	AND MIN(pr_age) < 20;

-- 39
SELECT pres_name, SUM(nr_children)
FROM pres_marriage
GROUP by pres_name
HAVING MIN(pr_age) < 35;

-- 40
SELECT pres_name
FROM pres_marriage
GROUP BY pres_name
HAVING MIN(nr_children) = 0;

-- 41
SELECT pres_name
FROM pres_marriage
GROUP by pres_name
HAVING COUNT(pres_name) > 1
	AND MIN(nr_children) >= 2;

-- 42
SELECT pres_name, spouse_name
FROM pres_marriage
HAVING MIN(nr_children) > 5;

-- 43
SELECT DISTINCT(party)
FROM president
GROUP BY party;

-- 44
SELECT president.party
FROM president, administration
WHERE president.pres_name = administration.pres_name
	AND administration.year_inaugurated > 1850
GROUP BY president.party
HAVING COUNT(president.pres_name) > 7;

-- 75
SELECT pres_name, SUM(nr_children)
FROM pres_marriage
WHERE pres_name = (
	SELECT pres_name, SUM(nr_children)
	FROM pres_marriage
	WHERE pr_age >= 50
		AND sp_age <= 30
	GROUP BY pres_name
	HAVING count(*) > 1
	)
GROUP BY pres_name
HAVING count(*) > 1;
