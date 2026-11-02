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
-- Inserting into table: posts --
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (61217, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1, 'hvdlttilbnpr', -2147483648, '2021-08-20 16:50:24+00:00', 'dposiie5unw', 'klfa9000t', 1408123494, -1964997180, 1149850321, -2147483648, '2020-05-18 19:45:10+00:00', '2025-04-19 21:11:20+00:00', -1833165707, '2024-05-26 02:52:16+00:00', 'nium52zbu', '4nrq');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -1106983592, 1884179925, '2024-04-01 02:40:29+00:00', -2070843029, 1, '02eu', -2147483648, '2022-07-13 23:48:43+00:00', 'iqa', '1ryytoo', 1644911394, -1666765085, 1178636309, -2147483648, '2021-07-01 18:29:24+00:00', '2020-08-18 16:30:34+00:00', 1055976837, '2023-08-25 07:55:29+00:00', 'ji7zwau2', 'dwyrq13pyu78');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1362461264, -904834265, '2023-07-26 21:52:05+00:00', -2031361952, 1, 'p5qi2rk', -2147483648, '2020-10-15 10:13:01+00:00', 'vqx58pz0f', '8jegd21vy9ux', -1492524358, -1612443122, -2050247126, -2147483648, '2022-10-17 07:55:28+00:00', '2021-07-30 02:29:08+00:00', 2103044118, '2020-12-31 11:15:26+00:00', 'gndqwnqc', 'x5hncprjtu0');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, -566887085, 602161869, '2020-09-05 12:25:49+00:00', 2094425101, 1, '7', -2147483648, '2022-05-08 02:53:39+00:00', 'fdrz16n', 'jja', -7597509, -1625552518, -1738458256, -2147483648, '2020-11-09 07:36:21+00:00', '2021-04-29 02:40:32+00:00', -458359144, '2025-06-10 19:01:27+00:00', 'afgogri', 'tsj3ayxp1q4');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: postlinks --
INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483648, '2021-11-17 08:00:56+00:00', 61217, 61217, 775304493);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483647, '2023-05-14 17:39:51+00:00', 61217, 61217, -1748371085);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483646, '2022-03-23 04:34:16+00:00', 61217, 61217, 894242932);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483645, '2025-11-06 14:42:57+00:00', 61217, 2, -1056308489);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483644, '2020-04-25 22:30:05+00:00', 61217, 3, 1631231566);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483643, '2023-12-12 02:47:46+00:00', 61217, 61217, -2078052421);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (2, '2021-06-12 16:42:05+00:00', 61217, 2, 32204797);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (3, '2021-05-17 23:21:59+00:00', 61217, 61217, 37673509);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483640, '2023-06-28 02:52:00+00:00', 1, 1, 1923912467);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ViewCount FROM posts AS T1 INNER JOIN postLinks AS T2 ON T1.Id = T2.PostId WHERE T2.PostId = 61217;

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT p.*, (SELECT ViewCount FROM posts WHERE Id = 61217) AS Popularity FROM postLinks AS pl JOIN posts AS p ON pl.RelatedPostId = p.Id WHERE pl.PostId = 61217;

/*
Prediction Result:
(61217, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1, 'hvdlttilbnpr', -2147483648, '2021-08-20 16:50:24+00:00', 'dposiie5unw', 'klfa9000t', 1408123494, -1964997180, 1149850321, -2147483648, '2020-05-18 19:45:10+00:00', '2025-04-19 21:11:20+00:00', -1833165707, '2024-05-26 02:52:16+00:00', 'nium52zbu', '4nrq', 1)
(61217, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1, 'hvdlttilbnpr', -2147483648, '2021-08-20 16:50:24+00:00', 'dposiie5unw', 'klfa9000t', 1408123494, -1964997180, 1149850321, -2147483648, '2020-05-18 19:45:10+00:00', '2025-04-19 21:11:20+00:00', -1833165707, '2024-05-26 02:52:16+00:00', 'nium52zbu', '4nrq', 1)
(61217, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1, 'hvdlttilbnpr', -2147483648, '2021-08-20 16:50:24+00:00', 'dposiie5unw', 'klfa9000t', 1408123494, -1964997180, 1149850321, -2147483648, '2020-05-18 19:45:10+00:00', '2025-04-19 21:11:20+00:00', -1833165707, '2024-05-26 02:52:16+00:00', 'nium52zbu', '4nrq', 1)
(2, -1106983592, 1884179925, '2024-04-01 02:40:29+00:00', -2070843029, 1, '02eu', -2147483648, '2022-07-13 23:48:43+00:00', 'iqa', '1ryytoo', 1644911394, -1666765085, 1178636309, -2147483648, '2021-07-01 18:29:24+00:00', '2020-08-18 16:30:34+00:00', 1055976837, '2023-08-25 07:55:29+00:00', 'ji7zwau2', 'dwyrq13pyu78', 1)
(3, -1362461264, -904834265, '2023-07-26 21:52:05+00:00', -2031361952, 1, 'p5qi2rk', -2147483648, '2020-10-15 10:13:01+00:00', 'vqx58pz0f', '8jegd21vy9ux', -1492524358, -1612443122, -2050247126, -2147483648, '2022-10-17 07:55:28+00:00', '2021-07-30 02:29:08+00:00', 2103044118, '2020-12-31 11:15:26+00:00', 'gndqwnqc', 'x5hncprjtu0', 1)
(61217, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1, 'hvdlttilbnpr', -2147483648, '2021-08-20 16:50:24+00:00', 'dposiie5unw', 'klfa9000t', 1408123494, -1964997180, 1149850321, -2147483648, '2020-05-18 19:45:10+00:00', '2025-04-19 21:11:20+00:00', -1833165707, '2024-05-26 02:52:16+00:00', 'nium52zbu', '4nrq', 1)
(2, -1106983592, 1884179925, '2024-04-01 02:40:29+00:00', -2070843029, 1, '02eu', -2147483648, '2022-07-13 23:48:43+00:00', 'iqa', '1ryytoo', 1644911394, -1666765085, 1178636309, -2147483648, '2021-07-01 18:29:24+00:00', '2020-08-18 16:30:34+00:00', 1055976837, '2023-08-25 07:55:29+00:00', 'ji7zwau2', 'dwyrq13pyu78', 1)
(61217, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1, 'hvdlttilbnpr', -2147483648, '2021-08-20 16:50:24+00:00', 'dposiie5unw', 'klfa9000t', 1408123494, -1964997180, 1149850321, -2147483648, '2020-05-18 19:45:10+00:00', '2025-04-19 21:11:20+00:00', -1833165707, '2024-05-26 02:52:16+00:00', 'nium52zbu', '4nrq', 1)
*/