-- Schema DDL
CREATE TABLE schools (CDSCode TEXT PRIMARY KEY, County TEXT NOT NULL);

CREATE TABLE frpm (CDSCode TEXT PRIMARY KEY, "County Name" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: schools --
INSERT INTO "schools" ("cdscode", "county") VALUES ('frp_fc9f67', '5k5swwqcgs');

INSERT INTO "schools" ("cdscode", "county") VALUES ('!', '9n8');

INSERT INTO "schools" ("cdscode", "county") VALUES ('+', '4');

INSERT INTO "schools" ("cdscode", "county") VALUES ('0', 'gu7v');

INSERT INTO "schools" ("cdscode", "county") VALUES ('p', 'e4');

INSERT INTO "schools" ("cdscode", "county") VALUES ('$', 'hria2ypuzhs');

INSERT INTO "schools" ("cdscode", "county") VALUES ('A', 'rwbbp6luhvd');

-- Inserting into table: frpm --
INSERT INTO "frpm" ("cdscode", "county name", "enrollment (k-12)", "free meal count (k-12)") VALUES ('frp_fc9f67', 'Alameda', 1.0, 1.0);

INSERT INTO "frpm" ("cdscode", "county name", "enrollment (k-12)", "free meal count (k-12)") VALUES ('!', 'Alameda', 1.0, 1.0);

INSERT INTO "frpm" ("cdscode", "county name", "enrollment (k-12)", "free meal count (k-12)") VALUES ('+', 'Alameda', 1.0, 1.0);

INSERT INTO "frpm" ("cdscode", "county name", "enrollment (k-12)", "free meal count (k-12)") VALUES ('0', 'Alameda', 1.0, 1.0);

INSERT INTO "frpm" ("cdscode", "county name", "enrollment (k-12)", "free meal count (k-12)") VALUES ('p', 'Alameda', 1.0, 1.0);

INSERT INTO "frpm" ("cdscode", "county name", "enrollment (k-12)", "free meal count (k-12)") VALUES ('$', 'Alameda', 1.0, 1.0);

INSERT INTO "frpm" ("cdscode", "county name", "enrollment (k-12)", "free meal count (k-12)") VALUES ('A', 'Alameda', 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "Free Meal Count (K-12)" / "Enrollment (K-12)" FROM frpm WHERE "County Name" = 'Alameda' ORDER BY (CAST("Free Meal Count (K-12)" AS REAL) / "Enrollment (K-12)") DESC, frpm.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT MAX("Free Meal Count (K-12)" / "Enrollment (K-12)") AS Highest_Eligible_Free_Rate FROM frpm INNER JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE schools.County = 'Alameda';

/*
Prediction Result:
(None,)
*/