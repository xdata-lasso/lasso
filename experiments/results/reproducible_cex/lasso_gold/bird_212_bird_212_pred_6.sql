-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('list', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('perform', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('fall', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('table', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('true', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('according', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('song', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('not', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('great', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('blue', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('best', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('husband', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('bill', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('her', '-');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('sure', 'list', 'source');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('collection', 'list', 'source');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('save', 'list', 'source');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('knowledge', 'list', 'source');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('grow', 'list', 'source');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('clearly', 'list', 'source');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('dinner', 'list', 'source');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('throw', 'list', 'machine');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('guy', 'list', 'machine');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('PM', 'list', 'machine');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('everything', 'list', 'machine');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('surface', 'list', 'machine');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('animal', 'list', 'machine');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('show', 'list', 'machine');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T1.element, COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '-' GROUP BY T1.element ORDER BY COUNT(DISTINCT T1.molecule_id) ASC, T1.element NULLS LAST LIMIT 4) AS t;

/*
Gold Result:
('machine',)
('source',)
*/

-- Prediction Query
SELECT element FROM (SELECT element, COUNT(*) AS element_count FROM (SELECT * FROM molecule WHERE label = '-') AS m JOIN atom ON m.molecule_id = atom.molecule_id GROUP BY element) AS element_counts ORDER BY element_count ASC, element NULLS LAST LIMIT 1;

/*
Prediction Result:
('machine',)
*/