-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('No31', '+21', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('ca24', '+21', 'ca32');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('No23', NULL, '+21');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Yes22', NULL, '+21');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('ca24', 'No31', NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('ca24', 'ca24', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('+21', '+33');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ca20', '+21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label AS flag_carcinogenic FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca';

/*
Gold Result:
('+33',)
*/

-- Prediction Query
SELECT CASE WHEN T4.label = '+' THEN 'Yes' ELSE 'No' END AS Is_Carcinogenic FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id INNER JOIN molecule AS T4 ON T1.molecule_id = T4.molecule_id WHERE T1.element = 'ca';

/*
Prediction Result:
*/