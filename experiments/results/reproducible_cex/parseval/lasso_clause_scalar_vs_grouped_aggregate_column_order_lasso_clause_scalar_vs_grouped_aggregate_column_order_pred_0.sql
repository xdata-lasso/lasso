-- Schema DDL
CREATE TABLE EVENT (EVENT_ID TEXT PRIMARY KEY, EVENT_NAME TEXT);

CREATE TABLE BUDGET (BUDGET_ID TEXT PRIMARY KEY, CATEGORY TEXT, AMOUNT INTEGER, LINK_TO_EVENT TEXT, FOREIGN KEY (LINK_TO_EVENT) REFERENCES EVENT (EVENT_ID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name") VALUES ('t1__7f6e2e', 'April Speaker');

INSERT INTO "event" ("event_id", "event_name") VALUES ('t1__7e0873', 'April Speaker');

INSERT INTO "event" ("event_id", "event_name") VALUES ('@', 'April Speaker');

INSERT INTO "event" ("event_id", "event_name") VALUES ('?', 'April Speaker');

INSERT INTO "event" ("event_id", "event_name") VALUES ('A', 'cgsk9');

INSERT INTO "event" ("event_id", "event_name") VALUES ('a', 'April Speaker');

INSERT INTO "event" ("event_id", "event_name") VALUES ('event_id_7', 'April Speaker');

INSERT INTO "event" ("event_id", "event_name") VALUES ('event_id_8', 'April Speaker');

INSERT INTO "event" ("event_id", "event_name") VALUES ('event_id_9', 'April Speaker');

INSERT INTO "event" ("event_id", "event_name") VALUES ('t2__8f8e14', 'April Speaker');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "amount", "link_to_event") VALUES ('t2__253c88', 't2__84fd61', -55602865, 't1__7f6e2e');

INSERT INTO "budget" ("budget_id", "category", "amount", "link_to_event") VALUES ('A', 't2__84fd61', -59984348, 't1__7f6e2e');

INSERT INTO "budget" ("budget_id", "category", "amount", "link_to_event") VALUES ('C', 't2__84fd61', -664303813, 't1__7f6e2e');

INSERT INTO "budget" ("budget_id", "category", "amount", "link_to_event") VALUES ('-', 't2__84fd61', -1, 'A');

INSERT INTO "budget" ("budget_id", "category", "amount", "link_to_event") VALUES ('j', 't2__0f3709', 0, 'A');

INSERT INTO "budget" ("budget_id", "category", "amount", "link_to_event") VALUES ('!', 't2__84fd61', 0, 'A');

INSERT INTO "budget" ("budget_id", "category", "amount", "link_to_event") VALUES ('0', 't2__0f3709', 1, 'A');

INSERT INTO "budget" ("budget_id", "category", "amount", "link_to_event") VALUES ('"', 't2__84fd61', 0, 'A');

INSERT INTO "budget" ("budget_id", "category", "amount", "link_to_event") VALUES ('''', 't2__0f3709', 1, 'A');

INSERT INTO "budget" ("budget_id", "category", "amount", "link_to_event") VALUES ('b', 't2__0f3709', 0, 'A');

INSERT INTO "budget" ("budget_id", "category", "amount", "link_to_event") VALUES ('B', 't2__84fd61', -1, 'A');

INSERT INTO "budget" ("budget_id", "category", "amount", "link_to_event") VALUES ('a', 't2__0f3709', 0, 'A');

INSERT INTO "budget" ("budget_id", "category", "amount", "link_to_event") VALUES ('t2__c82bc5', 't2__0f3709', 1610062532, 't2__8f8e14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.amount), T2.category FROM EVENT AS T1 INNER JOIN BUDGET AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'April Speaker' ORDER BY T2.amount, T1.event_id NULLS LAST, T2.budget_id NULLS LAST;

/*
Gold Result:
(830171506, 't2__84fd61')
*/

-- Prediction Query
SELECT category, SUM(CAST(amount AS REAL)) AS total_budgeted FROM BUDGET JOIN EVENT ON BUDGET.link_to_event = EVENT.event_id WHERE EVENT.event_name = 'April Speaker' GROUP BY category ORDER BY total_budgeted ASC, category NULLS LAST;

/*
Prediction Result:
('t2__84fd61', -779891026.0)
('t2__0f3709', 1610062532.0)
*/