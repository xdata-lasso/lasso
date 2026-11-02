-- Schema DDL
CREATE TABLE event (event_id TEXT CONSTRAINT event_pk PRIMARY KEY, event_name TEXT, event_date TEXT, type TEXT, notes TEXT, location TEXT, status TEXT);

CREATE TABLE major (major_id TEXT CONSTRAINT major_pk PRIMARY KEY, major_name TEXT, department TEXT, college TEXT);

CREATE TABLE zip_code (zip_code INTEGER CONSTRAINT zip_code_pk PRIMARY KEY, type TEXT, city TEXT, county TEXT, state TEXT, short_state TEXT);

CREATE TABLE "attendance" (link_to_event TEXT, link_to_member TEXT, PRIMARY KEY (link_to_event, link_to_member), FOREIGN KEY (link_to_event) REFERENCES event (event_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "budget" (budget_id TEXT PRIMARY KEY, category TEXT, spent REAL, remaining REAL, amount INTEGER, event_status TEXT, link_to_event TEXT, FOREIGN KEY (link_to_event) REFERENCES event (event_id));

CREATE TABLE "expense" (expense_id TEXT PRIMARY KEY, expense_description TEXT, expense_date TEXT, cost REAL, approved TEXT, link_to_member TEXT, link_to_budget TEXT, FOREIGN KEY (link_to_budget) REFERENCES budget (budget_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "income" (income_id TEXT CONSTRAINT income_pk PRIMARY KEY, date_received TEXT, amount INTEGER, source TEXT, notes TEXT, link_to_member TEXT, FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "member" (member_id TEXT CONSTRAINT member_pk PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, position TEXT, t_shirt_size TEXT, phone TEXT, zip INTEGER, link_to_major TEXT, FOREIGN KEY (link_to_major) REFERENCES major (major_id), FOREIGN KEY (zip) REFERENCES zip_code (zip_code));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO event (event_id, type) VALUES ('E1', 'Meeting');
INSERT INTO member (member_id) VALUES ('M1');
INSERT INTO member (member_id) VALUES ('M2');
INSERT INTO member (member_id) VALUES ('M3');
INSERT INTO member (member_id) VALUES ('M4');
INSERT INTO member (member_id) VALUES ('M5');
INSERT INTO member (member_id) VALUES ('M6');
INSERT INTO member (member_id) VALUES ('M7');
INSERT INTO member (member_id) VALUES ('M8');
INSERT INTO member (member_id) VALUES ('M9');
INSERT INTO member (member_id) VALUES ('M10');
INSERT INTO member (member_id) VALUES ('M11');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M9');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type = 'Meeting' GROUP BY T1.type HAVING COUNT(T2.link_to_event) > 10;

/*
Gold Result:
(11,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "event"."event_id") FROM "event" INNER JOIN "attendance" ON "event"."event_id" = "attendance"."link_to_event" WHERE "event"."type" = 'Meeting' GROUP BY "event"."event_id" HAVING COUNT("attendance"."link_to_event") > 10;

/*
Prediction Result:
(1,)
*/