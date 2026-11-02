-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('machine', 'Valerie Gray', '310 Kendra Common Apt. 164
Reidstad, GA 49021', 'hear', 1005, 1006);
INSERT INTO "building" ("building_id", "name", "street_address", "years_as_tallest", "height_feet", "floors") VALUES ('support', NULL, 'USNV Lewis
FPO AA 52357', 'usually', 1009, 1010);
INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('determine', 'machine', 'religious', '283 Steven Groves
Lake Mark, WI 07832', 1007.5, 'drop', 1008, 'term', 'almost');
INSERT INTO "institution" ("institution_id", "building_id", "institution", "location", "founded", "type", "enrollment", "team", "primary_conference") VALUES ('who', 'support', 'question', '38849 Hurst Locks Suite 328
Daviston, VI 14872', 1011.5, 'claim', 1012, 'product', 'collection');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.building_id AS building_id, LHS.name AS name, LHS.street_address AS street_address, LHS.years_as_tallest AS years_as_tallest, LHS.height_feet AS height_feet, LHS.floors AS floors, RHS.n AS n FROM building AS LHS INNER JOIN (SELECT building_id, COUNT(*) AS n FROM institution GROUP BY building_id) AS RHS ON (LHS.building_id = RHS.building_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('Valerie Gray', 1)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM building AS T1 JOIN institution AS T2 ON T1.building_id = T2.building_id GROUP BY T1.building_id;

/*
Prediction Result:
('Valerie Gray', 1)
(None, 1)
*/