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
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'CS', 'Eng', 'Eng');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'NYC', 'NY', 'New York', 'NY');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MB1', 'A', 'B', 'a@b.com', 'Member', 'M', '123', 10001, 'M1');
INSERT INTO event (event_id, event_name, type) VALUES ('E1', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E2', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E3', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E4', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E5', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E6', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E7', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E8', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E9', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E10', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E11', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E12', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E13', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E14', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E15', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E16', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E17', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E18', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E19', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E20', 'Meeting', 'Social');
INSERT INTO event (event_id, event_name, type) VALUES ('E21', 'Meeting', 'Social');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E5', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E6', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E7', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E8', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E9', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E11', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E12', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E13', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E14', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E15', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E16', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E17', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E18', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E19', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E21', 'MB1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
*/

-- Prediction Query
SELECT "event"."event_name" FROM "event" INNER JOIN "attendance" ON "event"."event_id" = "attendance"."link_to_event" WHERE "event"."type" <> 'Fundraiser' GROUP BY "event"."event_name" HAVING COUNT("attendance"."link_to_event") > 20;

/*
Prediction Result:
('Meeting',)
*/