-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('b_s_760801', 'm_s_31f68b');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'm_s_31f68b');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_2', 'm_s_31f68b');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('b_s_a33327', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'm_s_31f68b');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('m_s_e581eb', 'u7');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_2_4', 'b_s_760801', '5k5swwqcgs');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b_s_d026c7', 'b_s_760801', '4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_id = 'TR001_2_4';

/*
Gold Result:
*/

-- Prediction Query
SELECT m.label FROM bond AS b JOIN molecule AS m ON b.molecule_id = m.molecule_id WHERE b.bond_id = 'TR001_2_4';

/*
Prediction Result:
('m_s_31f68b',)
*/