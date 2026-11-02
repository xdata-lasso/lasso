-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=19', ' = 20', '=28');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('s18', ' = 20', 's');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=22', ' = 20', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('s21', ' = 20', ' = 29');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('=19', '=19', '=22');
INSERT INTO "molecule" ("molecule_id", "label") VALUES (' = 20', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 's' AND T2.bond_type <> '=';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.molecule_id) FROM molecule AS T1 LEFT JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id LEFT JOIN bond AS T3 ON T1.molecule_id = T3.molecule_id WHERE T2.element <> 's' AND T3.bond_type <> ' = ';

/*
Prediction Result:
(2,)
*/