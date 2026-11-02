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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('assume', 'Ronnie Nguyen', 'interview', 'Meeting', 'Building article sit develop.', 'Unit 8593 Box 2133
DPO AA 70452', 'customer');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('learn', 'David Harding', 'top', 'Meeting', 'Statement head piece popular old.', '96522 Brittany Valley
Robintown, VT 92324', 'it');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('recognize', 'Randy Rodriguez', 'local', 'Meeting', 'True avoid young cup position.', '378 Thompson Camp
North Jessebury, AK 69503', 'same');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('case', 'Jerry Edwards', 'only', 'Meeting', 'Begin suggest speak business.', '325 Samantha Vista Suite 002
Port Daniel, NC 48327', 'once');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('economic', 'Hunter Townsend', 'smile', 'Meeting', 'Anything under item right many him interview.', 'USNV Bush
FPO AP 52352', 'seven');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('film', 'John Phelps', 'oil', 'Meeting', 'Democrat cost evidence third alone people.', '5226 Banks Extensions Suite 392
Parkerport, DC 23793', 'wish');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('every', 'Robert Torres', 'enjoy', 'Meeting', 'Positive material third look because.', '029 Mccall Ridge Apt. 917
West Julie, IA 45958', 'show');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('today', 'Lindsey Lewis', 'between', 'Meeting', 'Case current this moment piece soon.', 'Unit 2157 Box 0433
DPO AP 09386', 'now');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('forward', 'Brittany Dawson', 'maintain', 'Meeting', 'Writer site grow.', '006 Oconnor Expressway
Snyderfurt, MI 72069', 'evidence');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('with', 'Jennifer Williams', 'blue', 'Meeting', 'Sit general not focus establish ago others.', '327 Lauren Bypass Suite 054
North Matthewfurt, GA 96443', 'recent');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('suddenly', 'Robert Thompson', 'summer', 'Meeting', 'Time sing around.', '9970 Dunlap Expressway
Mooreville, MA 27442', 'father');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('cold', NULL, 'international', 'Meeting', 'But represent society heart.', '00225 Kline Road
Natalieland, MN 45422', 'whole');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('might', NULL, 'after', 'Meeting', 'Side perhaps order answer blue.', '7467 Banks Union Apt. 120
North Robert, OR 63766', 'room');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('stock', NULL, 'drive', 'Meeting', 'Answer break know.', '96590 Timothy Oval Apt. 670
West Dianatown, VT 89358', 'sound');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('source', NULL, 'door', 'Meeting', 'Natural listen check receive.', '588 Ryan Stream
South Michael, TX 84571', 'energy');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('state', NULL, 'short', 'Meeting', 'Act inside big minute performance red industry together.', '28772 Karen Islands
West Tara, AR 66945', 'information');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('behavior', NULL, 'catch', 'Meeting', 'Responsibility brother box blood cup current enjoy.', '3177 Miller Parks Suite 517
North Richardton, OH 72472', 'gun');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('carry', NULL, 'development', 'Meeting', 'Win group important civil nature travel read.', '948 Diamond Motorway
Michaelton, GU 29719', 'support');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('possible', NULL, 'similar', 'Meeting', 'Former able public trade structure protect chance.', '997 Baldwin Crescent Apt. 305
Mariaport, OH 68918', 'cell');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('leader', NULL, 'age', 'Meeting', 'Single avoid rich toward.', '27261 Carr Field
Port Philipmouth, GU 25480', 'certainly');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('property', NULL, 'perform', 'Meeting', 'Lead with enough anyone spend.', '0917 Barrett Parkways
South Adam, WA 06867', 'itself');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('laugh', NULL, 'mother', 'Meeting', 'System growth quality.', '782 Jessica Crossroad Apt. 699
Williamfurt, MT 80323', 'play');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('finish', 'Anthony Armstrong', 'though', 'military');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('scene', 'Kayla Cameron', 'officer', 'traditional');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1056, 'class', 'West Adamland', 'financial', 'Texas', 'South Dakota');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1067, 'former', 'East Jason', 'send', 'Maine', 'Utah');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.johnson.com/', 'Christopher', 'Hernandez', 'earmstrong@example.org', 'central', 'third', '786.710.3579x727', 1056, 'finish');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://parker.info/', 'Angela', 'Knight', 'joshuathomas@example.net', 'statement', 'article', '(541)540-6029', 1056, 'finish');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://may.com/', 'Andrea', 'Aguilar', 'vwilliams@example.net', 'need', 'alone', '+1-533-646-8007x2290', 1056, 'finish');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://lopez-williams.info/', 'Melissa', 'Hanna', 'brandonalvarez@example.com', 'until', 'loss', '+1-844-366-5743x748', 1056, 'finish');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://hood.com/', 'April', 'Garcia', 'andrew44@example.com', 'outside', 'apply', '9853899441', 1056, 'finish');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.barnett.biz/', 'Sally', 'Chan', 'rgarrison@example.org', 'air', 'why', '445-244-4328x30965', 1056, 'finish');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.cardenas-barnes.net/', 'Alexander', 'Floyd', 'dennismccann@example.com', 'consumer', 'herself', '+1-974-746-6609x9353', 1056, 'finish');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.evans-foster.com/', 'Isabella', 'Dillon', 'joseph69@example.net', 'data', 'sea', '542.782.4172x48251', 1056, 'finish');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.thompson-joyce.com/', 'Briana', 'Beard', 'lopezjason@example.com', 'type', 'decide', '346.955.4947', 1056, 'finish');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.henderson.biz/', 'Kimberly', 'Humphrey', 'xmalone@example.org', 'there', 'eye', '8996917381', 1056, 'finish');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.scott.com/', 'Daniel', 'Baker', 'cameronmckinney@example.com', 'deep', 'home', '(702)423-5697x25217', 1056, 'finish');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.santos.com/', 'Sydney', 'Williams', 'susanmeyer@example.net', 'none', 'thing', '420-675-0110', 1067, 'scene');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://castillo.biz/', 'Jill', 'Mcfarland', 'robertherrera@example.org', 'account', 'body', '+1-819-734-6676', 1067, 'scene');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://mills.biz/', 'David', 'Carlson', 'jeffrey35@example.com', 'produce', 'describe', '3617809190', 1067, 'scene');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.brown.com/', 'Billy', 'Ayala', 'kelly98@example.com', 'attorney', 'note', '514.449.1476x60728', 1067, 'scene');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.vaughn.com/', 'Joshua', 'Garrett', 'wilsonmichael@example.org', 'develop', 'them', '001-268-842-4508x8210', 1067, 'scene');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://garcia-parrish.net/', 'Joseph', 'Cameron', 'susanfleming@example.com', 'religious', 'scientist', '+1-481-443-5368', 1067, 'scene');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://dixon.com/', 'Eugene', 'Turner', 'hmoon@example.com', 'professional', 'unit', '(939)343-1290', 1067, 'scene');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://butler-french.com/', 'Meghan', 'Tyler', 'amber40@example.net', 'different', 'site', '314-513-9755x2314', 1067, 'scene');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.king.info/', 'Adam', 'Pierce', 'willie87@example.com', 'treatment', 'stage', '277-759-4929x95562', 1067, 'scene');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://payne.com/', 'Steven', 'Jones', 'phillipsdenise@example.com', 'reveal', 'radio', '936.745.2577', 1067, 'scene');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://lucero.com/', 'Sharon', 'Zimmerman', 'vaughangary@example.net', 'language', 'technology', '001-347-281-2914x28341', 1067, 'scene');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('assume', 'https://www.johnson.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('assume', 'http://parker.info/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('assume', 'https://may.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('assume', 'https://lopez-williams.info/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('assume', 'https://hood.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('assume', 'http://www.barnett.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('assume', 'http://www.cardenas-barnes.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('assume', 'https://www.evans-foster.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('assume', 'http://www.thompson-joyce.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('assume', 'http://www.henderson.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('assume', 'http://www.scott.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('cold', 'https://www.santos.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('cold', 'http://castillo.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('cold', 'https://mills.biz/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('cold', 'http://www.brown.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('cold', 'https://www.vaughn.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('cold', 'http://garcia-parrish.net/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('cold', 'http://dixon.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('cold', 'http://butler-french.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('cold', 'http://www.king.info/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('cold', 'http://payne.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('cold', 'https://lucero.com/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type = 'Meeting' GROUP BY T1.type HAVING COUNT(T2.link_to_event) > 10;

/*
Gold Result:
(22,)
*/

-- Prediction Query
SELECT COUNT(T1.type) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type = 'Meeting' GROUP BY T2.link_to_event HAVING COUNT(T2.link_to_event) > 10;

/*
Prediction Result:
(11,)
(11,)
*/