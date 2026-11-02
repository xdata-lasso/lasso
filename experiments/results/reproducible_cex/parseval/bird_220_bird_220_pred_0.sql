-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'TR000', 't_s_ac0f0c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'TR000', 't_s_ac0f0c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'TR000', 't_s_0995e5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'TR000', '!');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'TR000', 't_s_0995e5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'TR000', '"');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'TR000', 't_s_0995e5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'TR000', '!');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'TR000', 't_s_0995e5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't_s_12cda4', 't_s_ac0f0c');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 't_s_ca05da', 't_s_0995e5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'TR000', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR000', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t_s_12cda4', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t_s_34f905', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t_s_ca05da', 'gu7v');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR000' ORDER BY T.element LIMIT 3;

/*
Gold Result:
(None,)
('!',)
('"',)
*/

-- Prediction Query
SELECT CASE WHEN element = 'cl' THEN 'Chlorine' WHEN element = 'c' THEN 'Carbon' WHEN element = 'h' THEN 'Hydrogen' WHEN element = 'o' THEN 'Oxygen' WHEN element = 's' THEN 'Sulfur' WHEN element = 'n' THEN 'Nitrogen' WHEN element = 'p' THEN 'Phosphorus' WHEN element = 'na' THEN 'Sodium' WHEN element = 'br' THEN 'Bromine' WHEN element = 'f' THEN 'Fluorine' WHEN element = 'i' THEN 'Iodine' WHEN element = 'sn' THEN 'Tin' WHEN element = 'pb' THEN 'Lead' WHEN element = 'te' THEN 'Tellurium' WHEN element = 'ca' THEN 'Calcium' END AS "Element" FROM atom WHERE molecule_id;

/*
Prediction Result:
*/