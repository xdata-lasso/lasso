-- Schema DDL
CREATE TABLE schools (CDSCode TEXT PRIMARY KEY, County TEXT NOT NULL);

CREATE TABLE frpm (CDSCode TEXT PRIMARY KEY, "County Name" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "schools" ("cdscode", "county") VALUES ('purpose', 'face');
INSERT INTO "schools" ("cdscode", "county") VALUES ('brother', 'election');
INSERT INTO "schools" ("cdscode", "county") VALUES ('ago', 'dog');
INSERT INTO "schools" ("cdscode", "county") VALUES ('site', 'chair');
INSERT INTO "frpm" ("cdscode", "county name", "enrollment (k-12)", "free meal count (k-12)") VALUES ('purpose', 'Alameda', 1001.5, 1005.5);
INSERT INTO "frpm" ("cdscode", "county name", "enrollment (k-12)", "free meal count (k-12)") VALUES ('brother', 'Alameda', 1008.5, 1014.5);
INSERT INTO "frpm" ("cdscode", "county name", "enrollment (k-12)", "free meal count (k-12)") VALUES ('ago', 'Alameda', 1015.5, 1023.5);
INSERT INTO "frpm" ("cdscode", "county name", "enrollment (k-12)", "free meal count (k-12)") VALUES ('site', 'Alameda', 1022.5, 1032.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "Free Meal Count (K-12)" / "Enrollment (K-12)" FROM frpm WHERE "County Name" = 'Alameda' ORDER BY (CAST("Free Meal Count (K-12)" AS REAL) / "Enrollment (K-12)") DESC, frpm.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
(1.0097799511002445,)
*/

-- Prediction Query
SELECT MAX("Free Meal Count (K-12)" / "Enrollment (K-12)") AS Highest_Eligible_Free_Rate FROM frpm INNER JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE schools.County = 'Alameda';

/*
Prediction Result:
(None,)
*/