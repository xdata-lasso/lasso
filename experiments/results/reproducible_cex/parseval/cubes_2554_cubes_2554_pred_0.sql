-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: party --
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1, 1.0, '5k5swwqcgs', 'par_7eff89', 'par_e1cdc5', 'par_9b4194', '9n8', 'par_b48e83');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (2, 874.871895, 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (3, 133.007885, '5u', 'w6kl', 'a9', '00t5c4e', 'cigce376nium', '52zbuo4nrq');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (4, 597.420508, 'fqyp', 's5bbp02e', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (5, 598.409165, 'wau2dwy', 'q13py', '78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (6, 541.393553, 'z0f8', 'egd', '1vy9uxj4', 'wb', 'v', 'ph2');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (7, 109.083092, 'dqwn', 'cx5hn', 'p', 'jtu0d', '79fjgq8', 'n2f3dqv0gcb9');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (8, 540.154414, 'k3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (9, 584.342044, 'yfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (10, 360.694313, 'q4301jh', 'den8c68x', 'vacx7afu5', '1of77p', 'o72ctdc', 'mfg62');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (11, 93.813527, '5q8qdj', 'e1io', '278507cv', 'jpttg', 'bnou5zi36', '4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT governor FROM (SELECT party_id, YEAR, party, governor, lieutenant_governor, comptroller, governor AS attorney_general, us_senate, party_id_other, year_other, governor_other, lieutenant_governor_other, comptroller_other, us_senate_other FROM (SELECT LHS.party_id AS party_id, LHS.year AS YEAR, LHS.party AS party, LHS.governor AS governor, LHS.lieutenant_governor AS lieutenant_governor, LHS.comptroller AS comptroller, LHS.attorney_general AS attorney_general, LHS.us_senate AS us_senate, RHS.party_id AS party_id_other, RHS.year AS year_other, RHS.governor AS governor_other, RHS.lieutenant_governor AS lieutenant_governor_other, RHS.comptroller AS comptroller_other, RHS.us_senate AS us_senate_other FROM party AS LHS INNER JOIN party AS RHS ON (LHS.party = RHS.party AND LHS.governor = RHS.attorney_general))) ORDER BY governor;

/*
Gold Result:
*/

-- Prediction Query
SELECT Governor FROM party GROUP BY Governor ORDER BY COUNT(*) DESC, Governor NULLS LAST LIMIT 1;

/*
Prediction Result:
('16nijjai5dh',)
*/