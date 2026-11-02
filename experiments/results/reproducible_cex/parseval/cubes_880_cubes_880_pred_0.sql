-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: storm --
INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (1, 'sto_f1b885', 'sto_1e7266', -55602865, 486.033807, 2);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (2, 'sto_f1b885', 'sto_1e7266', -664303813, 833.684115, 2);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (3, 'sto_f1b885', 'sto_1e7266', -1022641847, 97.952323, 2);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (4, '9n8', '4', -734455130, 906.21648, 1);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (5, 'hria2ypu', 'hsrwbbp', 13244799, 320.851235, NULL);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (6, NULL, 'vd', -1377057208, 304.02808, 2);

INSERT INTO "storm" ("storm_id", "name", "dates_active", "max_speed", "damage_millions_usd", "number_deaths") VALUES (7, 'bnp', NULL, 1236688122, 986.066566, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, dates_active, number_deaths FROM storm WHERE (number_deaths > 1) ORDER BY name, storm.storm_id NULLS LAST;

/*
Gold Result:
(None, 'vd', 2)
('bnp', None, 2)
('sto_f1b885', 'sto_1e7266', 2)
('sto_f1b885', 'sto_1e7266', 2)
('sto_f1b885', 'sto_1e7266', 2)
*/

-- Prediction Query
SELECT name, dates_active, number_deaths FROM storm WHERE number_deaths >= 1;

/*
Prediction Result:
('sto_f1b885', 'sto_1e7266', 2)
('sto_f1b885', 'sto_1e7266', 2)
('sto_f1b885', 'sto_1e7266', 2)
('9n8', '4', 1)
(None, 'vd', 2)
('bnp', None, 2)
*/