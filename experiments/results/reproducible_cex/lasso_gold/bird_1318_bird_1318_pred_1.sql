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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('purpose', 'Daniel Doyle', 'require', 'begin', 'Behavior discussion own.', '1849 Ray Squares
North Donnaport, CO 31013', 'benefit');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('brother', 'Daniel Doyle', 'sit', 'performance', 'Current practice nation determine operation speak according.', '7525 Clark Grove Apt. 928
East Steven, KY 84387', 'someone');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('ago', 'Daniel Doyle', 'wait', 'knowledge', 'Recently future choice whatever.', '503 Linda Locks
Carlshire, FM 94599', 'anyone');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('site', 'Daniel Doyle', 'offer', 'almost', 'Bill here grow gas enough analysis.', '7242 Julie Plain Suite 969
Coxberg, NY 65187', 'traditional');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('break', 'Christopher Becker', 'pick', 'attack');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1001, 'image', 'Carlsonmouth', 'newspaper', 'Kentucky', 'Oklahoma');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.dyer.com/', 'Mario', 'Decker', 'millertodd@example.org', 'deep', 'remain', '371.233.1509x83930', 1001, 'break');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://moore-smith.com/', 'Andrew', 'Parker', 'davidalvarez@example.net', 'sell', 'rate', '510.451.8347', 1001, 'break');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.evans.com/', 'Sarah', 'Brown', 'josephbrennan@example.com', 'forget', 'hour', '001-899-973-7631x1656', 1001, 'break');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.ashley.org/', 'Natasha', 'Humphrey', 'sarahcampos@example.net', 'inside', 'left', '001-801-406-5133x3872', 1001, 'break');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://www.dyer.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://moore-smith.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'http://www.evans.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://www.ashley.org/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_name ORDER BY COUNT(T2.link_to_event) DESC, T1.event_name NULLS LAST LIMIT 1;

/*
Gold Result:
('Daniel Doyle',)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e INNER JOIN attendance AS a ON e.event_id = a.link_to_event INNER JOIN member AS m ON a.link_to_member = m.member_id WHERE m.position = 'Student_Club' GROUP BY e.event_name ORDER BY COUNT(*) DESC, e.event_name NULLS LAST LIMIT 1;

/*
Prediction Result:
*/