-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B1', 'Tower A', '100 Main St', '1990-1995', 120, 10);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B2', 'Tower B', '200 Main St', '1995-2000', 150, 10);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B3', 'Tower C', '300 Main St', '2000-2005', 250, 20);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B4', 'Tower D', '400 Main St', '2005-2010', 15, 21);
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B5', 'Tower E', '500 Main St', '2010-2020', 600, 50);
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I1', 'B1', 'Inst 1', 'City A', 1901.0, 'Public', 5000, 'Lions', 'Conf A');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I2', 'B2', 'Inst 2', 'City B', 1920.0, 'Private', 3000, 'Tigers', 'Conf B');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I3', 'B3', 'Inst 3', 'City C', 1950.0, 'Public', 8000, 'Bears', 'Conf A');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I4', 'B3', 'Inst 4', 'City C', 1960.0, 'Private', 2000, 'Hawks', 'Conf C');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I5', 'B4', 'Inst 5', 'City D', 1975.0, 'Public', 10000, 'Eagles', 'Conf B');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I6', 'B5', 'Inst 6', 'City E', 1985.0, 'Private', 1500, 'Owls', 'Conf C');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P1', 'I1', 'Prot Alpha', 12.5, 'ACC1', 100.0, '95%');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P2', 'I1', 'Prot Beta', 15.0, 'ACC2', 200.0, '90%');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P3', 'I2', 'Prot Gamma', 8.0, 'ACC3', 150.0, '98%');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P4', 'I3', 'Prot Delta', 20.0, 'ACC4', 300.0, '85%');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P5', 'I4', 'Prot Epsilon', 5.0, 'ACC5', 120.0, '99%');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P6', 'I5', 'Prot Zeta', 30.0, 'ACC6', 400.0, '70%');
INSERT INTO protein (common_name, Institution_id, protein_name, divergence_from_human_lineage, accession_number, sequence_length, sequence_identity_to_human_protein) VALUES ('P7', 'I6', 'Prot Eta', 45.0, 'ACC7', 500.0, '60%');
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