-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Boundary conditions for floors: 19 (< 20), 20 (= 20), 21 (> 20), and NULL.
-- 2. Join exclusions: building without institution, building with institution but no protein.
-- 3. Duplicate values for floors (both from multiple proteins on the same building and across different buildings) to distinguish COUNT(DISTINCT floors) from COUNT(floors) or COUNT(*).
-- 4. Differentiating `floors` from other integer columns like `Height_feet` and `Enrollment`.
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B1', 'Alpha Tower', '100 Main St', '1990-1995', 15, 20);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B2', 'Beta Tower', '200 Main St', '1995-2000', 18, 19);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B3', 'Gamma Tower', '300 Main St', '2000-2005', 10, 21);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B4', 'Delta Tower', '400 Main St', '2005-2010', 12, 10);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B5', 'Epsilon Tower', '500 Main St', '2010-2015', 14, 15);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B6', 'Zeta Tower', '600 Main St', '2015-2020', 16, NULL);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B7', 'Eta Tower', '700 Main St', '2020-2022', 20, 20);
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I1', 'B1', 'Inst Alpha', 'City A', 1900.0, 'Public', 10, 'Lions', 'Conf A');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I2', 'B2', 'Inst Beta', 'City B', 1910.0, 'Private', 12, 'Tigers', 'Conf B');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I3', 'B3', 'Inst Gamma', 'City C', 1920.0, 'Public', 15, 'Bears', 'Conf C');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I4', 'B4', 'Inst Delta', 'City D', 1930.0, 'Private', 20, 'Hawks', 'Conf D');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I6', 'B6', 'Inst Zeta', 'City F', 1950.0, 'Public', 18, 'Eagles', 'Conf F');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I7', 'B7', 'Inst Eta', 'City G', 1960.0, 'Private', 25, 'Sharks', 'Conf G');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I8', NULL, 'Inst Theta', 'City H', 1970.0, 'Public', 14, 'Wolves', 'Conf H');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P1', 'I1', 'Prot 1', 1.5, 'ACC1', 10.0, '99%');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P2', 'I1', 'Prot 2', 2.5, 'ACC2', 15.0, '98%');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P3', 'I2', 'Prot 3', 3.5, 'ACC3', 20.0, '97%');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P4', 'I3', 'Prot 4', 4.5, 'ACC4', 12.0, '96%');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P5', 'I6', 'Prot 5', 5.5, 'ACC5', 18.0, '95%');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P6', 'I7', 'Prot 6', 6.5, 'ACC6', 14.0, '94%');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P7', 'I8', 'Prot 7', 7.5, 'ACC7', 16.0, '93%');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P8', NULL, 'Prot 8', 8.5, 'ACC8', 11.0, '92%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT floors) AS n_distinct FROM (SELECT * FROM (SELECT LHS.building_id AS building_id, LHS.name AS name, LHS.street_address AS street_address, LHS.years_as_tallest AS years_as_tallest, LHS.height_feet AS height_feet, LHS.floors AS floors, LHS.institution_id AS institution_id, LHS.institution AS institution, LHS.location AS LOCATION, LHS.founded AS founded, LHS.type AS TYPE, LHS.enrollment AS enrollment, LHS.team AS team, LHS.primary_conference AS primary_conference, RHS.common_name AS common_name, RHS.protein_name AS protein_name, RHS.divergence_from_human_lineage AS divergence_from_human_lineage, RHS.accession_number AS accession_number, RHS.sequence_length AS sequence_length, RHS.sequence_identity_to_human_protein AS sequence_identity_to_human_protein FROM (SELECT LHS.building_id AS building_id, LHS.name AS name, LHS.street_address AS street_address, LHS.years_as_tallest AS years_as_tallest, LHS.height_feet AS height_feet, LHS.floors AS floors, RHS.institution_id AS institution_id, RHS.institution AS institution, RHS.location AS LOCATION, RHS.founded AS founded, RHS.type AS TYPE, RHS.enrollment AS enrollment, RHS.team AS team, RHS.primary_conference AS primary_conference FROM building AS LHS INNER JOIN institution AS RHS ON (LHS.building_id = RHS.building_id)) AS LHS INNER JOIN protein AS RHS ON (LHS.institution_id = RHS.institution_id)) WHERE (floors <= 20))) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM institution AS T1 JOIN protein AS T2 ON T1.institution_id = T2.institution_id JOIN building AS T3 ON T3.building_id = T1.building_id WHERE T3.floors >= 20;

/*
Prediction Result:
(4,)
*/