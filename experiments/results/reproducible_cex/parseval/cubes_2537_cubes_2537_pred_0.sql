-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: county --
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1, '5k5swwqcgs', 171.746906, 'n8c4pgu7v');

-- Inserting into table: party --
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1, 86.520366, '4h', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 'ie5');

-- Inserting into table: election --
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1, 1, 1, 'ele_528207', 'ele_c9754c', 1.0, 'ele_943ca1');

INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (2, 1, 1, NULL, 'swwqcgsk', 572.766956, '8c4p');

INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (3, 1, 1, 'vfe4hria2', 'puzhsrw', 944.247544, 'p');

INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (4, 1, 1, 'hvdlttilbnpr', 'dpos', 133.007885, '5u');

INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (5, 1, 1, 'klfa9000t', 'c4ecigce', 467.07027, 'nium52zbu');

INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (6, 1, 1, 'rqro', 'fqyp5s5bbp0', 673.065986, 'eutliqa11r');

INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (7, 1, 1, 'oo3o9', 'l7', 443.457804, 'lex');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT election_id, counties_represented, district, delegate, party, first_elected, committee FROM election ORDER BY election_id;

/*
Gold Result:
(1, 'ele_528207', 1, 'ele_c9754c', 1, 1.0, 'ele_943ca1')
(2, None, 1, 'swwqcgsk', 1, 572.766956, '8c4p')
(3, 'vfe4hria2', 1, 'puzhsrw', 1, 944.247544, 'p')
(4, 'hvdlttilbnpr', 1, 'dpos', 1, 133.007885, '5u')
(5, 'klfa9000t', 1, 'c4ecigce', 1, 467.07027, 'nium52zbu')
(6, 'rqro', 1, 'fqyp5s5bbp0', 1, 673.065986, 'eutliqa11r')
(7, 'oo3o9', 1, 'l7', 1, 443.457804, 'lex')
*/

-- Prediction Query
SELECT * FROM election;

/*
Prediction Result:
(1, 1, 1, 'ele_528207', 'ele_c9754c', 1.0, 'ele_943ca1')
(2, 1, 1, None, 'swwqcgsk', 572.766956, '8c4p')
(3, 1, 1, 'vfe4hria2', 'puzhsrw', 944.247544, 'p')
(4, 1, 1, 'hvdlttilbnpr', 'dpos', 133.007885, '5u')
(5, 1, 1, 'klfa9000t', 'c4ecigce', 467.07027, 'nium52zbu')
(6, 1, 1, 'rqro', 'fqyp5s5bbp0', 673.065986, 'eutliqa11r')
(7, 1, 1, 'oo3o9', 'l7', 443.457804, 'lex')
*/