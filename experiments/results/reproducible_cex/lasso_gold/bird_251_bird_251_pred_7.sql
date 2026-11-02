-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('building', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('rest', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('value', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('not', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('finally', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('learn', 'brother');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('coach', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('long', 'brother');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('social', 'building', 'grow');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('example', 'building', 'grow');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('specific', 'building', 'grow');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('put', 'building', 'grow');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('about', 'finally', 'everyone');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('seven', 'learn', 'everyone');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('type', 'coach', 'everyone');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('serve', 'long', 'everyone');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T2.element, COUNT(DISTINCT T2.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+' GROUP BY T2.element ORDER BY COUNT(DISTINCT T2.molecule_id), T2.element NULLS LAST LIMIT 1) AS t;

/*
Gold Result:
('grow',)
*/

-- Prediction Query
SELECT element FROM (SELECT a.element, COUNT(*) AS element_count FROM molecule AS m JOIN atom AS a ON m.molecule_id = a.molecule_id WHERE m.label = '+' GROUP BY a.element) AS element_counts ORDER BY element_counts.element_count ASC, element NULLS LAST LIMIT 1;

/*
Prediction Result:
('everyone',)
*/