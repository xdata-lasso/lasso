-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2594, 'then', '1992-06-19', '1993-07-20', '1994-08-21', 'what', 'official');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2666, 'certainly', '1973-05-06', '1974-06-07', '1975-07-08', 'city', 'during');
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2594, '1995-09-22', 2595.5, 2596.5, 2597, 'like', 2598, 'watch', '+', '+', '+', 'cold', 2599);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2666, '1976-08-09', 2667.5, 2668.5, 2669, 'identify', 2670, 'rule', '+', '+', '+', 'claim', 2671);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2594, '1996-10-23', 2600, 2601, 2602, 2603, 2604.5, 2605.5, 2606.5, 2607, 2608.5, 2609.5, 2610, 2611, 249, 2612, 2613.5, 2614.5, 2615.5, 2616.5, 2617, 2618.5, 2619, 2620.5, 2621, 2622, 2623, 'six', 2624, 2625, 2626, 'training', 'may', 'listen', 2627, 2628, 'event', 'society', 'end', 'though', 'public', 'factor', 'space', 2629);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2594, '1972-04-05', 2636, 2637, 2638, 2639, 2640.5, 2641.5, 2642.5, 2643, 2644.5, 2645.5, 2646, 2647, 249, 2648, 2649.5, 2650.5, 2651.5, 2652.5, 2653, 2654.5, 2655, 2656.5, 2657, 2658, 2659, 'less', 2660, 2661, 2662, 'bank', 'sell', 'feeling', 2663, 2664, 'easy', 'expert', 'government', 'front', 'walk', 'now', 'be', 2665);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2666, '1977-09-10', 2672, 2673, 2674, 2675, 2676.5, 2677.5, 2678.5, 2679, 2680.5, 2681.5, 2682, 2683, 249, 2684, 2685.5, 2686.5, 2687.5, 2688.5, 2689, 2690.5, 2691, 2692.5, 2693, 2694, 2695, 'seat', 2696, 2697, 2698, 'difficult', 'attack', 'join', 2699, 2700, 'involve', 'give', 'occur', 'man', 'just', 'assume', 'design', 2701);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T2.CPK < 250 AND (T3.KCT = '+' OR T3.RVVT = '+' OR T3.LAC = '+');

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "Examination"."ID") FROM "Examination" INNER JOIN "Laboratory" ON "Examination"."ID" = "Laboratory"."ID" WHERE "Laboratory"."CPK" < 250 AND ("Examination"."KCT" = '+' OR "Examination"."RVVT" = '+' OR "Examination"."LAC" = '+');

/*
Prediction Result:
(2,)
*/