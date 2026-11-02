-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests label filter ('+' vs '-' vs NULL) and string position logic (suffix '-2' vs prefix or middle substring)
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR005', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR006', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR007', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR008', '+');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR005_22', 'TR005', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR006_24', 'TR006', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('22_TR007_10', 'TR007', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR023_99', 'TR007', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A_24', 'TR008', 'h');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE SUBSTRING(T1.atom_id, -2) BETWEEN '21' AND '25' AND T2.label = '+';

/*
Gold Result:
('TR008',)
*/

-- Prediction Query
SELECT DISTINCT a.molecule_id FROM atom AS a JOIN (SELECT molecule_id FROM molecule WHERE label = '+') AS m ON a.molecule_id = m.molecule_id WHERE SUBSTRING(a.atom_id, 7, 2) BETWEEN '21' AND '25' ORDER BY a.molecule_id;

/*
Prediction Result:
*/