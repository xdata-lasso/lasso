-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__0ecd50', 't1__2ffd79');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__0ecd50', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'A', 't1__2ffd79');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'O', 't1__2ffd79');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'O', 't1__2ffd79');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'O', 't1__2ffd79');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__0ecd50', 't1__2ffd79');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__0ecd50', 't1__59cfd9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('/', 't1__0ecd50', 't1__2ffd79');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 't1__0ecd50', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 't1__0ecd50', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't1__0ecd50', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't1__0ecd50', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 't1__0ecd50', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__0ecd50', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__0ecd50', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 't1__0ecd50', NULL);

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__0ecd50', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__1a1336', '4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T1.element = 'cl' THEN T1.element ELSE NULL END) AS REAL) * 100 / COUNT(T1.element) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
(20.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN a.element = 'cl' THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(m.molecule_id) AS percentage FROM molecule AS m INNER JOIN atom AS a ON m.molecule_id = a.molecule_id WHERE m.label = '+';

/*
Prediction Result:
(7.6923076923076925,)
*/