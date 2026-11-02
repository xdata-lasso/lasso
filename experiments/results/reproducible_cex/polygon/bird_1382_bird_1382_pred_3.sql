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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Community Theater28', 'Community Theater', 'Community Theater54', 'Interior Design55', 'Community Theater56', 'Interior Design57', 'Community Theater58');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Interior Design27', 'Community Theater', 'Interior Design59', 'Community Theater60', 'Interior Design61', 'Community Theater62', 'Interior Design63');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Interior Design71', 'Interior Design', 'Community Theater72', 'Interior Design73');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Interior Design29', 'Interior Design47', NULL, NULL);
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (64, 'Interior Design71', 'Interior Design71', 'Interior Design71', 'Interior Design71', 'Interior Design71');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Community Theater28', 'Interior Design31');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Interior Design27', 'Interior Design31');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Interior Design33', 'Interior Design27', 'Interior Design71', 71, 71, 71, 'Interior Design71');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Interior Design31', 'Interior Design71', 64, NULL, 'Community Theater66', 'Interior Design67', 'Community Theater68', 'Interior Design69', 'Community Theater70');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Community Theater32', 'Interior Design29', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.first_name, T2.last_name FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member INNER JOIN event AS T4 ON T3.link_to_event = T4.event_id WHERE T4.event_name = 'Community Theater' AND T1.major_name = 'Interior Design';

/*
Gold Result:
(None, 'Community Theater66')
(None, 'Community Theater66')
*/

-- Prediction Query
SELECT DISTINCT member.first_name, member.last_name FROM member INNER JOIN major ON member.link_to_major = major.major_id INNER JOIN attendance ON member.member_id = attendance.link_to_member INNER JOIN event ON attendance.link_to_event = event.event_id WHERE major.major_name = 'Interior Design' AND event.event_name = 'Community Theater';

/*
Prediction Result:
(None, 'Community Theater66')
*/