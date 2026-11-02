-- Schema DDL
CREATE TABLE schools (CDSCode TEXT PRIMARY KEY, County TEXT NOT NULL);

CREATE TABLE frpm (CDSCode TEXT PRIMARY KEY, "County Name" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO schools (CDSCode, County) VALUES ('1', 'Alameda');
INSERT INTO schools (CDSCode, County) VALUES ('2', 'Alameda');
INSERT INTO frpm (CDSCode, "County Name", "Enrollment (K-12)", "Free Meal Count (K-12)") VALUES ('1', 'Alameda', 100.0, 50.0);
INSERT INTO frpm (CDSCode, "County Name", "Enrollment (K-12)", "Free Meal Count (K-12)") VALUES ('2', 'Other', 100.0, 80.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "Free Meal Count (K-12)" / "Enrollment (K-12)" FROM frpm WHERE "County Name" = 'Alameda' ORDER BY (CAST("Free Meal Count (K-12)" AS REAL) / "Enrollment (K-12)") DESC, frpm.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
(0.5,)
*/

-- Prediction Query
SELECT MAX("Free Meal Count (K-12)" / "Enrollment (K-12)") AS Highest_Eligible_Free_Rate FROM frpm INNER JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE schools.County = 'Alameda';

/*
Prediction Result:
(0.8,)
*/