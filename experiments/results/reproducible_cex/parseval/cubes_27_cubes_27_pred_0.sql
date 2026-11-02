-- Schema DDL
CREATE TABLE "i037" ("c1" INTEGER, "c2" TEXT, "c3" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i037 --
INSERT INTO "i037" ("c1", "c2", "c3") VALUES (1, 'i03_4ca98d', '5k5swwqcgs');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (1, 'i03_4ca98d', '9n8');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (1, 'i03_4ca98d', '4');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (-734455130, '4h', 'rhs_7a6883');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (1, 'i03_4ca98d', 'ia2yp');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (1, 'i03_4ca98d', 'uzhsrwbbp6lu');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (1, 'i03_4ca98d', 'hvdlttilbnpr');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (2087640001, 'dposiie5unw', 'rhs_7a6883');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (-1399556171, 'a9000t5c4eci', 'rhs_e6d7d5');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (1149850321, NULL, 'e');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (1, NULL, '76nium52');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (NULL, NULL, 'zbuo4nrqrof');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (NULL, NULL, 'qyp5s5bbp0');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (743312762, NULL, 'rhs_7a6883');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (-1822992503, 'liqa1', NULL);

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (1, 'i03_4ca98d', NULL);

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (NULL, 'i03_4ca98d', NULL);

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (NULL, 'i03_4ca98d', NULL);

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (2074205376, 'yytoo', 'rhs_7a6883');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (1, 'i03_4ca98d', 'o9hl72kl');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (NULL, 'i03_4ca98d', 'x1');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (NULL, 'i03_4ca98d', 'ji7zwau2');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (364869063, 'q13py', 'rhs_7a6883');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (1, 'i03_4ca98d', '78d99r');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (NULL, 'i03_4ca98d', 'jsl');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (NULL, 'i03_4ca98d', 'b4yp5qi');

INSERT INTO "i037" ("c1", "c2", "c3") VALUES (-227162283, 'f9v', 'rhs_7a6883');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c1, c2, c3 FROM (SELECT LHS.c2 AS c2, LHS.c1 AS c1, RHS.c3 AS c3 FROM (SELECT c2, MIN(c1) AS c1 FROM i037 GROUP BY c2) AS LHS LEFT JOIN i037 AS RHS ON (LHS.c2 = RHS.c2 AND LHS.c1 = RHS.c1)) ORDER BY c1, c2 NULLS LAST, c3 NULLS LAST;

/*
Gold Result:
(-1822992503, 'liqa1', None)
(-1399556171, 'a9000t5c4eci', 'rhs_e6d7d5')
(-734455130, '4h', 'rhs_7a6883')
(-227162283, 'f9v', 'rhs_7a6883')
(1, 'i03_4ca98d', '4')
(1, 'i03_4ca98d', '5k5swwqcgs')
(1, 'i03_4ca98d', '78d99r')
(1, 'i03_4ca98d', '9n8')
(1, 'i03_4ca98d', 'hvdlttilbnpr')
(1, 'i03_4ca98d', 'ia2yp')
(1, 'i03_4ca98d', 'o9hl72kl')
(1, 'i03_4ca98d', 'uzhsrwbbp6lu')
(1, 'i03_4ca98d', None)
(1, None, None)
(364869063, 'q13py', 'rhs_7a6883')
(2074205376, 'yytoo', 'rhs_7a6883')
(2087640001, 'dposiie5unw', 'rhs_7a6883')
*/

-- Prediction Query
SELECT t1.*, i037.c3 FROM (SELECT c2, MIN(c1) AS minc1 FROM i037 GROUP BY c2) AS t1 JOIN i037 ON t1.minc1 = i037.c1;

/*
Prediction Result:
(None, 1, None)
(None, 1, '4')
(None, 1, '5k5swwqcgs')
(None, 1, '76nium52')
(None, 1, '78d99r')
(None, 1, '9n8')
(None, 1, 'hvdlttilbnpr')
(None, 1, 'ia2yp')
(None, 1, 'o9hl72kl')
(None, 1, 'uzhsrwbbp6lu')
('4h', -734455130, 'rhs_7a6883')
('a9000t5c4eci', -1399556171, 'rhs_e6d7d5')
('dposiie5unw', 2087640001, 'rhs_7a6883')
('f9v', -227162283, 'rhs_7a6883')
('i03_4ca98d', 1, None)
('i03_4ca98d', 1, '4')
('i03_4ca98d', 1, '5k5swwqcgs')
('i03_4ca98d', 1, '76nium52')
('i03_4ca98d', 1, '78d99r')
('i03_4ca98d', 1, '9n8')
('i03_4ca98d', 1, 'hvdlttilbnpr')
('i03_4ca98d', 1, 'ia2yp')
('i03_4ca98d', 1, 'o9hl72kl')
('i03_4ca98d', 1, 'uzhsrwbbp6lu')
('liqa1', -1822992503, None)
('q13py', 364869063, 'rhs_7a6883')
('yytoo', 2074205376, 'rhs_7a6883')
*/