-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('s22', 's15', 's');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('s21', 's15', 's');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('s16', 's15', 's21');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('s21', 's21', 's16');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('s22', 's21', 's16');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('s14', 's21');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('s15', 's21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 's';

/*
Gold Result:
('s21',)
*/

-- Prediction Query
SELECT atom_id2 FROM connected WHERE atom_id IN (SELECT atom_id FROM atom WHERE element = 's');

/*
Prediction Result:
('s21',)
('s21',)
*/