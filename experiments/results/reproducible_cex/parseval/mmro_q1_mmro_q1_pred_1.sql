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
-- Inserting into table: nhosiz --
INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (1, 'c_s_0539bd', 'nho_51bab5', 1);

INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (2, 'c_s_0539bd', 'nho_51bab5', 1);

INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (5, 'nho_204caf', 'nho_51bab5', -55602865);

INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (3, 'nho_204caf', 'nho_51bab5', -59984348);

INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (4, 'nho_204caf', 'nho_51bab5', -1022641847);

INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (6, 'nho_204caf', 'nho_51bab5', 247012447);

INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (7, 'nho_204caf', 'nho_51bab5', -1980249628);

INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (8, 'nho_204caf', 'nho_51bab5', -734455130);

INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (9, 'nho_204caf', 'nho_51bab5', -1633151678);

INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (10, 'nho_204caf', 'nho_51bab5', -252690330);

INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (11, 'nho_204caf', 'nho_51bab5', 1115440883);

INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (12, 'nho_204caf', 'nho_51bab5', 1465859724);

INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (13, 'nho_204caf', 'nho_51bab5', -1349201381);

-- Inserting into table: ayzfwn --
INSERT INTO "ayzfwn" ("qdujuq", "ryiyuk", "tgelyf", "ryqatk", "padlzj", "hbhscc") VALUES (1, 1, 'ayz_b21bf4', 'o_s_87a2ba', 'ayz_b2a7b0', 1.0);

INSERT INTO "ayzfwn" ("qdujuq", "ryiyuk", "tgelyf", "ryqatk", "padlzj", "hbhscc") VALUES (3, 1, 'ayz_b21bf4', 'o_s_28c599', 'ayz_b2a7b0', 1.0);

INSERT INTO "ayzfwn" ("qdujuq", "ryiyuk", "tgelyf", "ryqatk", "padlzj", "hbhscc") VALUES (2, 3, 'ayz_b21bf4', 'ayz_868a62', 'ayz_b2a7b0', 345.329712);

INSERT INTO "ayzfwn" ("qdujuq", "ryiyuk", "tgelyf", "ryqatk", "padlzj", "hbhscc") VALUES (4, 4, 'ayz_b21bf4', 'ayz_868a62', 'ayz_b2a7b0', 97.952323);

INSERT INTO "ayzfwn" ("qdujuq", "ryiyuk", "tgelyf", "ryqatk", "padlzj", "hbhscc") VALUES (5, 6, 'ayz_b21bf4', 'ayz_868a62', 'ayz_b2a7b0', 868.436572);

INSERT INTO "ayzfwn" ("qdujuq", "ryiyuk", "tgelyf", "ryqatk", "padlzj", "hbhscc") VALUES (6, 7, 'ayz_b21bf4', 'ayz_868a62', 'ayz_b2a7b0', 249.706432);

INSERT INTO "ayzfwn" ("qdujuq", "ryiyuk", "tgelyf", "ryqatk", "padlzj", "hbhscc") VALUES (7, 8, 'ayz_b21bf4', 'ayz_868a62', 'ayz_b2a7b0', 906.21648);

INSERT INTO "ayzfwn" ("qdujuq", "ryiyuk", "tgelyf", "ryqatk", "padlzj", "hbhscc") VALUES (8, 9, 'ayz_b21bf4', 'ayz_868a62', 'ayz_b2a7b0', 134.487977);

INSERT INTO "ayzfwn" ("qdujuq", "ryiyuk", "tgelyf", "ryqatk", "padlzj", "hbhscc") VALUES (9, 10, 'ayz_b21bf4', 'ayz_868a62', 'ayz_b2a7b0', 797.015047);

INSERT INTO "ayzfwn" ("qdujuq", "ryiyuk", "tgelyf", "ryqatk", "padlzj", "hbhscc") VALUES (10, 11, 'ayz_b21bf4', 'ayz_868a62', 'ayz_b2a7b0', 882.963176);

INSERT INTO "ayzfwn" ("qdujuq", "ryiyuk", "tgelyf", "ryqatk", "padlzj", "hbhscc") VALUES (11, 12, 'ayz_b21bf4', 'ayz_868a62', 'ayz_b2a7b0', 294.861575);

INSERT INTO "ayzfwn" ("qdujuq", "ryiyuk", "tgelyf", "ryqatk", "padlzj", "hbhscc") VALUES (12, 13, 'ayz_b21bf4', 'ayz_868a62', 'ayz_b2a7b0', 737.440743);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.ryiyuk, c.djnfoa, COUNT(o.qdujuq) AS total_orders, COALESCE(SUM(o.hbhscc), 0.0) AS total_spend FROM nhosiz AS c LEFT JOIN ayzfwn AS o ON c.ryiyuk = o.ryiyuk AND o.ryqatk = 'COMPLETED' WHERE c.fomiuw = 1 GROUP BY c.ryiyuk, c.djnfoa;

/*
Gold Result:
(1, 'c_s_0539bd', 0, 0.0)
(2, 'c_s_0539bd', 0, 0.0)
*/

-- Prediction Query
SELECT c.ryiyuk, c.djnfoa, COUNT(o.qdujuq) AS total_orders, COALESCE(SUM(o.hbhscc), 0.0) AS total_spend FROM nhosiz AS c LEFT JOIN ayzfwn AS o ON c.ryiyuk = o.ryiyuk WHERE o.ryqatk = 'COMPLETED' AND c.fomiuw = 1 GROUP BY c.ryiyuk, c.djnfoa;

/*
Prediction Result:
*/