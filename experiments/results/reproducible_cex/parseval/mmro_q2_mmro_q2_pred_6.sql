-- Schema DDL
/* Relational schema for MMRO-BM (ManyMutationsRandomObfuscated: Random Letter Strings) */ /* Relational schema for ManyMutantsBM benchmark suite. */ /* Universal schema compatible with SQLite, PostgreSQL, and MySQL. */ CREATE TABLE udaxih (utlsgw INTEGER PRIMARY KEY, cbvhyj TEXT(100) NOT NULL UNIQUE, chdmio TEXT(100) NOT NULL);

CREATE TABLE hexdvx (ulfllg INTEGER PRIMARY KEY, viwvuc TEXT(100) NOT NULL, utlsgw INTEGER NOT NULL, tufrxh TEXT(50) NOT NULL, fomiuw INTEGER NOT NULL DEFAULT 1, FOREIGN KEY (utlsgw) REFERENCES udaxih (utlsgw));

CREATE TABLE rcsnba (rhvkyy INTEGER PRIMARY KEY, bhbzkm TEXT(100) NOT NULL UNIQUE, utlsgw INTEGER NOT NULL, icgswk REAL NOT NULL, gupmuo TEXT(20) NOT NULL, FOREIGN KEY (utlsgw) REFERENCES udaxih (utlsgw));

CREATE TABLE cghqta (eiehxr INTEGER PRIMARY KEY, ulfllg INTEGER NOT NULL, rhvkyy INTEGER NOT NULL, rixsns TEXT(20) NOT NULL, mlheqp REAL NOT NULL, UNIQUE (ulfllg, rhvkyy), FOREIGN KEY (ulfllg) REFERENCES hexdvx (ulfllg), FOREIGN KEY (rhvkyy) REFERENCES rcsnba (rhvkyy));

CREATE TABLE rgwuwr (cybdeu INTEGER PRIMARY KEY, rhvkyy INTEGER NOT NULL, fzvntc INTEGER, tufrxh TEXT(200) NOT NULL, mmtoqi TEXT(20) NOT NULL, gupmuo TEXT(20) NOT NULL, ravxdv TEXT(20) NOT NULL, FOREIGN KEY (rhvkyy) REFERENCES rcsnba (rhvkyy), FOREIGN KEY (fzvntc) REFERENCES hexdvx (ulfllg));

CREATE TABLE nhosiz (ryiyuk INTEGER PRIMARY KEY, djnfoa TEXT(100) NOT NULL, xxiqyf TEXT(20) NOT NULL, fomiuw INTEGER NOT NULL DEFAULT 1);

CREATE TABLE ayzfwn (qdujuq INTEGER PRIMARY KEY, ryiyuk INTEGER NOT NULL, tgelyf TEXT(20) NOT NULL, ryqatk TEXT(20) NOT NULL, padlzj TEXT(20) NOT NULL DEFAULT 'STANDARD', hbhscc REAL NOT NULL DEFAULT 0, FOREIGN KEY (ryiyuk) REFERENCES nhosiz (ryiyuk));

CREATE TABLE kiegyk (xpcyry INTEGER PRIMARY KEY, eevprf TEXT(100) NOT NULL UNIQUE, iqtngr TEXT(50) NOT NULL);

CREATE TABLE dcmdll (yxwgwj INTEGER PRIMARY KEY, xpcyry INTEGER NOT NULL, mvuloq TEXT(100) NOT NULL, odhhck REAL NOT NULL, asrhsh INTEGER NOT NULL DEFAULT 0, FOREIGN KEY (xpcyry) REFERENCES kiegyk (xpcyry));

CREATE TABLE tizbxo (acwubh INTEGER PRIMARY KEY, qdujuq INTEGER NOT NULL, yxwgwj INTEGER NOT NULL, cbkcqh INTEGER NOT NULL, ivpgre REAL NOT NULL, xssphz REAL, UNIQUE (qdujuq, yxwgwj), FOREIGN KEY (qdujuq) REFERENCES ayzfwn (qdujuq), FOREIGN KEY (yxwgwj) REFERENCES dcmdll (yxwgwj));

CREATE TABLE rdmcrj (pzngdd INTEGER PRIMARY KEY, yxwgwj INTEGER NOT NULL, ryiyuk INTEGER NOT NULL, vnlnno INTEGER NOT NULL, xbvuud INTEGER NOT NULL DEFAULT 0, bmxkzd TEXT(20) NOT NULL, FOREIGN KEY (yxwgwj) REFERENCES dcmdll (yxwgwj), FOREIGN KEY (ryiyuk) REFERENCES nhosiz (ryiyuk));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: udaxih --
INSERT INTO "udaxih" ("utlsgw", "cbvhyj", "chdmio") VALUES (1, 'Engineering', 'uda_f6f47b');

INSERT INTO "udaxih" ("utlsgw", "cbvhyj", "chdmio") VALUES (3, 'cbvhyj_2', 'uda_f6f47b');

INSERT INTO "udaxih" ("utlsgw", "cbvhyj", "chdmio") VALUES (2, 'A', 'uda_f6f47b');

-- Inserting into table: hexdvx --
INSERT INTO "hexdvx" ("ulfllg", "viwvuc", "utlsgw", "tufrxh", "fomiuw") VALUES (1, 'e_s_0a5b1d', 1, 'hex_d6b5f8', -55602865);

INSERT INTO "hexdvx" ("ulfllg", "viwvuc", "utlsgw", "tufrxh", "fomiuw") VALUES (-2147483647, 'e_s_0e63d4', 1, 'hex_d6b5f8', 809183447);

INSERT INTO "hexdvx" ("ulfllg", "viwvuc", "utlsgw", "tufrxh", "fomiuw") VALUES (-2147483646, 'e_s_0e63d4', 1, 'hex_d6b5f8', -1633151678);

INSERT INTO "hexdvx" ("ulfllg", "viwvuc", "utlsgw", "tufrxh", "fomiuw") VALUES (-2147483645, 'e_s_0e63d4', 1, 'hex_d6b5f8', 1268590800);

INSERT INTO "hexdvx" ("ulfllg", "viwvuc", "utlsgw", "tufrxh", "fomiuw") VALUES (2, 'hex_41df58', 2, 'hex_d6b5f8', -55602865);

-- Inserting into table: rcsnba --
INSERT INTO "rcsnba" ("rhvkyy", "bhbzkm", "utlsgw", "icgswk", "gupmuo") VALUES (1, 'bhbzkm_1', 1, 285.529132, 'ACTIVE');

INSERT INTO "rcsnba" ("rhvkyy", "bhbzkm", "utlsgw", "icgswk", "gupmuo") VALUES (2, 'bhbzkm_2', 1, 97.952323, 'ACTIVE');

INSERT INTO "rcsnba" ("rhvkyy", "bhbzkm", "utlsgw", "icgswk", "gupmuo") VALUES (3, 'bhbzkm_3', 1, 572.766956, 'rcs_c0ca07');

-- Inserting into table: cghqta --
INSERT INTO "cghqta" ("eiehxr", "ulfllg", "rhvkyy", "rixsns", "mlheqp") VALUES (-2147483648, 1, 1, 'cgh_11d497', 357.862717);

INSERT INTO "cghqta" ("eiehxr", "ulfllg", "rhvkyy", "rixsns", "mlheqp") VALUES (-2147483647, 1, 3, 'cgh_11d497', 206.939346);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.ulfllg, e.viwvuc, d.cbvhyj FROM hexdvx AS e JOIN udaxih AS d ON e.utlsgw = d.utlsgw WHERE e.fomiuw = 1 AND d.cbvhyj = 'Engineering' AND NOT EXISTS(SELECT 1 FROM rgwuwr AS t WHERE t.fzvntc = e.ulfllg AND t.gupmuo = 'OVERDUE') AND EXISTS(SELECT 1 FROM cghqta AS a JOIN rcsnba AS p ON a.rhvkyy = p.rhvkyy WHERE a.ulfllg = e.ulfllg AND p.gupmuo = 'ACTIVE');

/*
Gold Result:
*/

-- Prediction Query
SELECT e.ulfllg, e.viwvuc, d.cbvhyj FROM hexdvx AS e JOIN udaxih AS d ON e.utlsgw = d.utlsgw WHERE d.cbvhyj = 'Engineering' AND NOT EXISTS(SELECT 1 FROM rgwuwr AS t WHERE t.fzvntc = e.ulfllg AND t.gupmuo = 'OVERDUE') AND EXISTS(SELECT 1 FROM cghqta AS a JOIN rcsnba AS p ON a.rhvkyy = p.rhvkyy WHERE a.ulfllg = e.ulfllg AND p.gupmuo = 'ACTIVE');

/*
Prediction Result:
(1, 'e_s_0a5b1d', 'Engineering')
*/