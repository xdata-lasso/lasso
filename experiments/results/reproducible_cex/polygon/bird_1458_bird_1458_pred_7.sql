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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Member18', 'Member66', 'Member66', 'Member66', 'Member66', 'Member66', 'Member66');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Vermont17', 'Member66', 'Member66', 'Member66', 'Member66', 'Member66', 'Member66');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Member26', 'Member66', 'Member66', 'Member66');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Maine60', 'Member66', 'Member66', 'Member66');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (66, NULL, 'Maine68', 'Vermont69', 'Member70', 'New Jersey71');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (27, 'Maine32', NULL, NULL, 'Maine', 'New Jersey35');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Vermont17', 'New Jersey59');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Member18', 'New Jersey19');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Vermont21', NULL, 'Member66', 66, 66, 66, 'Member66');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Maine20', 'Vermont17', 'Member66', 66, 66, 66, 'Member66');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('New Jersey23', 'Vermont21', 'New Jersey19', 'Member66', 'Member66', 66, 'Member66');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Member22', 'Vermont21', 'New Jersey59', 'Member66', 'Member66', 66, 'Member66');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Vermont25', 'New Jersey19', 'Member66', 66, 'Member66', 'Member66');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Maine24', 'New Jersey19', 'Member66', 66, 'Member66', 'Member66');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('New Jersey59', 'Maine60', 66, NULL, NULL, 'New Jersey63', 'Member', 'Maine64', 'Vermont65');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('New Jersey19', 'Member26', 27, 'Maine36', NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN T2.state = 'Maine' THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.state = 'Vermont' THEN 1 ELSE 0 END)) AS REAL) * 100 / COUNT(T1.member_id) AS diff FROM member AS T1 INNER JOIN zip_code AS T2 ON T2.zip_code = T1.zip;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN z.state = 'New Jersey' THEN 1 ELSE 0 END) AS REAL) / COUNT(m.member_id) - CAST(SUM(CASE WHEN z.state = 'Vermont' THEN 1 ELSE 0 END) AS REAL) / COUNT(m.member_id) AS difference FROM member AS m INNER JOIN zip_code AS z ON m.zip = z.zip_code WHERE m.position = 'Member';

/*
Prediction Result:
(0.0,)
*/