-- Schema DDL
CREATE TABLE "building" ("building_id" TEXT PRIMARY KEY, "Name" TEXT, "Street_address" TEXT, "Years_as_tallest" TEXT, "Height_feet" INTEGER, "Floors" INTEGER);

CREATE TABLE "Institution" ("Institution_id" TEXT PRIMARY KEY, "building_id" TEXT, "Institution" TEXT, "Location" TEXT, "Founded" REAL, "Type" TEXT, "Enrollment" INTEGER, "Team" TEXT, "Primary_Conference" TEXT, FOREIGN KEY ("building_id") REFERENCES "building" ("building_id"));

CREATE TABLE "protein" ("common_name" TEXT PRIMARY KEY, "Institution_id" TEXT, "protein_name" TEXT, "divergence_from_human_lineage" REAL, "accession_number" TEXT, "sequence_length" REAL, "sequence_identity_to_human_protein" TEXT, FOREIGN KEY ("Institution_id") REFERENCES "Institution" ("Institution_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO building (building_id, Name, Street_address, Years_as_tallest, Height_feet, Floors) VALUES ('B1', 'Main Hall', '123 College Ave', '1990-2000', 150, 10);
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I1', 'B1', 'Inst 1', 'Loc 1', 1990.0, 'Public', 999, 'T1', 'C1');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I2', 'B1', 'Inst 2', 'Loc 2', 1990.0, 'Private', 1000, 'T2', 'C2');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I3', 'B1', 'Inst 3', 'Loc 3', 1990.0, 'Community', 1001, 'T3', 'C3');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I4', 'B1', 'Inst 4', 'Loc 4', 1989.9, 'Technical', 1500, 'T4', 'C4');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I5', 'B1', 'Inst 5', 'Loc 5', 1989.9, 'Liberal Arts', 1000, 'T5', 'C5');
INSERT INTO Institution (Institution_id, building_id, Institution, Location, Founded, Type, Enrollment, Team, Primary_Conference) VALUES ('I6', 'B1', 'Inst 6', 'Loc 6', 1995.5, 'Research', 500, 'T6', 'C6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM institution WHERE (founded >= 1990.0 AND enrollment <> 1000) ORDER BY TYPE, institution.institution_id NULLS LAST;

/*
Gold Result:
('Community',)
('Public',)
('Research',)
*/

-- Prediction Query
SELECT TYPE FROM institution WHERE founded > 1990 AND enrollment >= 1000;

/*
Prediction Result:
*/