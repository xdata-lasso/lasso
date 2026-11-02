-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1938, 1941, '1970-08-04', 'Linda Morgan', '1974-01-08', 'http://mills.com/', '04618 Dean Squares
South Maria, CT 67555', 'sense', 1945, 1949, 1953, 1957, 1961, 'http://white-morales.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1939, 1946.0, '1970-08-05', 'Whitney Cooper', '1974-01-09', 'http://www.dawson-conner.biz/', '1173 Kimberly Village
West Jade, LA 21521', 'left', 1964.0, 1970.0, 1976.0, 1982.0, 1988.0, 'https://jefferson.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1940, 1951.0, '1970-08-06', 'Heather Lopez', '1974-01-10', 'https://www.vang.com/', '75300 Rebecca Village Suite 218
Lake Jenniferview, SD 30799', 'pretty', 1983.0, 1991.0, 1999.0, 2007.0, 2015.0, 'http://www.barber.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1969, 1956.0, '1970-08-07', 'Tamara Powell', '1974-01-11', 'http://www.wallace-martinez.com/', '7012 Melissa Lake Suite 611
North Melissaburgh, MA 47362', 'executive', 2002.0, 2012.0, 2022.0, 2032.0, 2042.0, 'https://gregory.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1937, 1942, '1982-09-16', 'Shari Hobbs', '1986-02-20', 'http://www.mercer.net/', '663 Stephen Unions
Millerfort, NV 41927', 'wall', 1946, 1950, 1954, 1958, 1962, 'https://www.monroe.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1970, 1978.0, '1982-09-17', 'Stephanie Webb', '1986-02-21', 'https://rhodes.net/', '016 Johnson Plaza Apt. 199
Pamelaside, IL 86300', 'ground', 1996.0, 2002.0, 2008.0, 2014.0, 2020.0, 'https://www.smith-fitzgerald.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1971, 1983.0, '1982-09-18', 'Stephen Alexander Jr.', '1986-02-22', 'http://www.michael.info/', '0375 Moran Lakes Suite 113
West Michaelport, OH 68918', 'box', 2015.0, 2023.0, 2031.0, 2039.0, 2047.0, 'https://norman.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1972, 1988.0, '1982-09-19', 'Alexandria Oneill', '1986-02-23', 'http://www.flores-rivera.com/', '27261 Carr Field
Port Philipmouth, GU 25480', 'sometimes', 2034.0, 2044.0, 2054.0, 2064.0, 2074.0, 'http://www.sandoval-obrien.com/');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1965, 1938, 'Autobiographer', '1978-05-12');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1967, 1938, 'Autobiographer', '1978-05-13');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1968, 1938, 'Autobiographer', '1978-05-14');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1997, 1938, 'Autobiographer', '1978-05-15');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1966, 1937, 'Autobiographer', '1978-05-12');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1998, 1937, 'Autobiographer', '1990-06-02');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1999, 1937, 'Autobiographer', '1990-06-03');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2000, 1937, 'Autobiographer', '1990-06-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T2."Name" = 'Autobiographer' ORDER BY T2.Date, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Shari Hobbs',)
*/

-- Prediction Query
SELECT T2.DisplayName FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T1.Name LIKE 'Autobiographer' ORDER BY T1.Date ASC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Linda Morgan',)
*/