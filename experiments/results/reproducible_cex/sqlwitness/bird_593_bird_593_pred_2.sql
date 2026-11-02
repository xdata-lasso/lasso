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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 0, NULL, 'Teacher', '2023-01-01 01:00:00.000000', 'default2', 'default1', 'Supporter', NULL, NULL, 1, NULL, NULL, 'New York'), (0, NULL, '2023-01-01 01:00:00.000000', 'Supporter', '2023-01-01 01:00:00.000000', 'Teacher', 'default1', NULL, NULL, 0, NULL, NULL, NULL, 'default1'), (2, 0, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'New York, NY', 'New York', 'Supporter', 0, 1, 1, NULL, NULL, 'Teacher'), (3, 0, '2023-01-01 01:00:00.000000', 'Teacher', NULL, 'New York', 'Teacher', 'New York, NY', 1, 0, 0, NULL, NULL, 'New York'), (4, 0, '2023-01-01 01:00:00.000000', 'Teacher', '2023-01-01 00:00:00.000000', 'default2', 'New York, NY', 'default2', NULL, 1, 0, 0, 0, 'New York, NY'), (5, 1, NULL, 'New York, NY', '2023-01-01 00:00:00.000000', 'New York', 'Teacher', NULL, 0, 1, 0, 0, 1, 'default2'), (6, NULL, '2023-01-01 00:00:00.000000', 'New York, NY', '2023-01-01 00:00:00.000000', 'default2', 'default1', 'New York', NULL, NULL, 0, 0, 1, 'Teacher'), (7, 1, '2023-01-01 01:00:00.000000', 'Teacher', '2023-01-01 01:00:00.000000', 'Supporter', 'default2', 'default1', 1, 0, 1, 0, NULL, 'Teacher'), (8, NULL, '2023-01-01 01:00:00.000000', 'default2', NULL, 'New York', 'New York', 'default2', NULL, 0, NULL, 0, 0, 'New York'), (9, 1, '2023-01-01 01:00:00.000000', 'New York', '2023-01-01 01:00:00.000000', 'Teacher', 'default2', 'Supporter', 0, 0, 0, NULL, 1, 'default2'), (10, 0, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'New York, NY', 'default2', 0, 1, 1, NULL, 1, 'default2'), (11, 0, '2023-01-01 01:00:00.000000', 'default2', NULL, 'Supporter', 'Supporter', NULL, 1, NULL, 0, NULL, NULL, 'Teacher'), (12, 0, NULL, NULL, '2023-01-01 00:00:00.000000', 'New York, NY', 'default1', NULL, NULL, 1, 0, 0, 0, 'default2');
INSERT INTO badges (id, userid, name, date) VALUES (0, 0, 'Teacher', '2023-01-01 00:00:00.000000'), (1, 8, 'Supporter', '2023-01-01 00:00:00.000000'), (2, 4, 'Teacher', NULL), (3, 3, 'Supporter', NULL), (4, 9, 'New York, NY', '2023-01-01 01:00:00.000000'), (5, 0, 'default2', '2023-01-01 01:00:00.000000'), (6, 1, 'default2', NULL), (7, 12, 'Teacher', NULL), (8, 3, 'Teacher', '2023-01-01 00:00:00.000000'), (9, 11, 'default2', '2023-01-01 01:00:00.000000'), (10, NULL, 'New York, NY', '2023-01-01 00:00:00.000000'), (11, 3, 'New York, NY', '2023-01-01 01:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.Id) FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T1.Name IN ('Supporter', 'Teacher') AND T2.Location = 'New York';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "users"."id") FROM "users" INNER JOIN "badges" AS "b1" ON "users"."id" = "b1"."userid" INNER JOIN "badges" AS "b2" ON "users"."id" = "b2"."userid" WHERE "users"."location" = 'New York, NY' AND "b1"."name" = 'Teacher' AND "b2"."name" = 'Supporter';

/*
Prediction Result:
(0,)
*/