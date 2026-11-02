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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('summer', 'Christina Marsh', 'single', 'act', 'Yet support military result.', '5587 Preston Light
Stevenberg, VI 22465', 'air');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('eat', 'Christina Marsh', 'citizen', 'control', 'Feel no nothing huge real art sport.', '9961 Fernando Forks Suite 544
Nelsonmouth, WI 48101', 'already');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('one', 'Christina Marsh', 'material', 'know', 'Stuff benefit seat employee growth newspaper special.', '2202 Ebony Summit Apt. 326
North Calebfort, OH 07556', 'record');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('lay', 'Christina Marsh', 'sure', 'money', 'After building test white current office.', '114 Christopher Loaf Suite 334
Simsberg, NC 22862', 'heavy');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('energy', 'Mallory Rodgers', 'simple', 'detail', 'City rock seat near business loss.', '27195 Brian Rue
Lake Amanda, CT 16993', 'class');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('image', 'Mallory Rodgers', 'between', 'improve', 'Cup thought tell design both.', '573 Hannah Knolls Apt. 407
Hansenside, UT 64738', 'position');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('spend', 'Mallory Rodgers', 'near', 'responsibility', 'Foot cold everybody build smile across.', '557 Dillon Rapid
North Amanda, NV 39255', 'fear');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('level', 'Mallory Rodgers', 'reduce', 'forget', 'Ok real read.', '0862 Christine Lakes Apt. 518
Leefort, WI 72782', 'future');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('visit', 'Mallory Rodgers', 'outside', 'bank', 'Major together reflect standard.', '48058 Mark Square Apt. 206
Mullinsshire, NY 12308', 'decision');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('pass', 'Mallory Rodgers', 'whose', 'several', 'Organization feel room office.', '2251 Duncan Causeway Suite 416
Ayalaberg, WV 18178', 'reveal');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('enjoy', 'Mallory Rodgers', 'director', 'garden', 'Sister two free they.', '6938 John Grove
Morrisshire, CO 15250', 'hour');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('early', 'Mallory Rodgers', 'similar', 'meeting', 'Indicate test thank dinner present own.', '5355 Kayla Extension Suite 979
South Brady, GU 31104', 'clearly');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('traditional', 'Sharon Mcdonald', 'truth', 'now');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('it', 'Ashley Mills', 'audience', 'animal');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('sometimes', 'Angelica Singh', 'eight', 'pressure');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1088, 'worry', 'Amyberg', 'save', 'Ohio', 'Idaho');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1092, 'thing', 'East Morgan', 'defense', 'Connecticut', 'New York');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1096, 'with', 'Port Marissa', 'field', 'Alabama', 'Michigan');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://bowman.info/', 'Kevin', 'Robles', 'kfoster@example.net', 'cup', 'century', '297.449.7350x208', 1088, 'traditional');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.parker-gutierrez.com/', 'Katie', 'Kelley', 'oclayton@example.com', 'tonight', 'figure', '244-927-0312', 1088, 'traditional');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.mills.com/', 'Lauren', 'Lopez', 'hendersonjohn@example.net', 'authority', 'bring', '356.447.5705', 1088, 'traditional');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://smith.info/', 'Carla', 'Khan', 'justin84@example.com', 'court', 'public', '8462187234', 1088, 'traditional');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.duncan.info/', 'Joseph', 'Yu', 'jamessandoval@example.net', 'compare', 'interest', '(889)875-5855', 1092, 'it');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.walker-robbins.com/', 'Billy', 'Davis', 'angelagrant@example.net', 'structure', 'mother', '001-859-239-8368x4577', 1092, 'it');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://mcdonald.com/', 'Chad', 'Hardy', 'mirandabarbara@example.net', 'couple', 'green', '001-204-690-8240x4335', 1092, 'it');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://bauer-brown.org/', 'Shirley', 'Schmidt', 'bpark@example.org', 'oil', 'really', '+1-788-499-2107', 1092, 'it');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://ruiz-rivera.net/', 'Carl', 'Ward', 'yhall@example.net', 'goal', 'close', '(554)438-4046x084', 1096, 'sometimes');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.mills.com/', 'Donna', 'Rodriguez', 'mckeetodd@example.net', 'might', 'affect', '762-916-8936x39264', 1096, 'sometimes');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://escobar.com/', 'Elizabeth', 'Carter', 'lopezvincent@example.com', 'increase', 'hand', '+1-423-829-8324', 1096, 'sometimes');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.williamson.com/', 'Roberta', 'Ware', 'williamssandra@example.com', 'size', 'return', '001-829-825-1881x25205', 1096, 'sometimes');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('summer', 'https://bowman.info/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('summer', 'http://www.parker-gutierrez.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('summer', 'https://www.mills.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('summer', 'https://smith.info/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('energy', 'http://www.duncan.info/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('energy', 'https://www.walker-robbins.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('energy', 'http://mcdonald.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('energy', 'https://bauer-brown.org/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('visit', 'http://ruiz-rivera.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('visit', 'http://www.mills.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('visit', 'http://escobar.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('visit', 'https://www.williamson.com/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_name ORDER BY COUNT(T2.link_to_event) DESC, T1.event_name NULLS LAST LIMIT 1;

/*
Gold Result:
('Mallory Rodgers',)
*/

-- Prediction Query
SELECT "event"."event_name" FROM "event" INNER JOIN "attendance" ON "event"."event_id" = "attendance"."link_to_event" GROUP BY "event"."event_id" ORDER BY COUNT("attendance"."link_to_event") DESC, "event"."event_name" NULLS LAST LIMIT 1;

/*
Prediction Result:
('Christina Marsh',)
*/