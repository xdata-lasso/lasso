-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B1', 'Tower A', '123 Main', '1990-2000', 500, 40);
INSERT INTO "building" ("building_id", "Name", "Street_address", "Years_as_tallest", "Height_feet", "Floors") VALUES ('B2', 'Tower B', '456 Oak', '2000-2010', 600, 50);
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I1', 'B1', 'Alpha Univ', 'NY', 1900.0, 'Public', 10000, 'Lions', 'ConfA');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I2', 'B1', 'Beta College', 'NY', 1920.0, 'Private', 5000, 'Tigers', 'ConfA');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I3', 'B1', 'Gamma Inst', 'NY', 1950.0, 'Public', 8000, 'Bears', 'ConfB');
INSERT INTO "Institution" ("Institution_id", "building_id", "Institution", "Location", "Founded", "Type", "Enrollment", "Team", "Primary_Conference") VALUES ('I4', 'B2', 'Delta Univ', 'CA', 1960.0, 'Private', 12000, 'Eagles', 'ConfA');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P1', 'I1', 'Prot1', 1.2, 'ACC1', 100.0, '99%');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P2', 'I1', 'Prot2', 2.3, 'ACC2', 200.0, '95%');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P3', 'I3', 'Prot3', 3.4, 'ACC3', 150.0, '90%');
INSERT INTO "protein" ("common_name", "Institution_id", "protein_name", "divergence_from_human_lineage", "accession_number", "sequence_length", "sequence_identity_to_human_protein") VALUES ('P4', 'I4', 'Prot4', 4.5, 'ACC4', 300.0, '85%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT institution, n AS count___ FROM (SELECT LHS.institution_id AS institution_id, LHS.institution AS institution, LHS.location AS LOCATION, LHS.founded AS founded, LHS.type AS TYPE, LHS.enrollment AS enrollment, LHS.team AS team, LHS.primary_conference AS primary_conference, LHS.building_id AS building_id, LHS.common_name AS common_name, LHS.protein_name AS protein_name, LHS.divergence_from_human_lineage AS divergence_from_human_lineage, LHS.accession_number AS accession_number, LHS.sequence_length AS sequence_length, LHS.sequence_identity_to_human_protein AS sequence_identity_to_human_protein, RHS.n AS n FROM (SELECT LHS.institution_id AS institution_id, LHS.institution AS institution, LHS.location AS LOCATION, LHS.founded AS founded, LHS.type AS TYPE, LHS.enrollment AS enrollment, LHS.team AS team, LHS.primary_conference AS primary_conference, LHS.building_id AS building_id, RHS.common_name AS common_name, RHS.protein_name AS protein_name, RHS.divergence_from_human_lineage AS divergence_from_human_lineage, RHS.accession_number AS accession_number, RHS.sequence_length AS sequence_length, RHS.sequence_identity_to_human_protein AS sequence_identity_to_human_protein FROM institution AS LHS INNER JOIN protein AS RHS ON (LHS.institution_id = RHS.institution_id)) AS LHS INNER JOIN (SELECT building_id, primary_conference, COUNT(*) AS n FROM institution GROUP BY building_id, primary_conference) AS RHS ON (LHS.primary_conference = RHS.primary_conference AND LHS.building_id = RHS.building_id)) ORDER BY institution, count___ NULLS LAST;

/*
Gold Result:
('Alpha Univ', 2)
('Delta Univ', 1)
('Gamma Inst', 1)
*/

-- Prediction Query
SELECT T1.institution, COUNT(*) FROM institution AS T1 JOIN protein AS T2 ON T1.institution_id = T2.institution_id GROUP BY T1.institution_id;

/*
Prediction Result:
('Alpha Univ', 2)
('Gamma Inst', 1)
('Delta Univ', 1)
*/