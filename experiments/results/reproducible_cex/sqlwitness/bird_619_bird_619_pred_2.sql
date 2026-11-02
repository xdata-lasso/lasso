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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (64, 18, NULL, 'default2', '2023-01-01 01:00:00.000000', 'Supporter', 'default2', NULL, 65, 18, NULL, 20, 1, 'Supporter'), (66, 19, '2023-01-01 00:00:00.000000', 'Supporter', '2023-01-01 01:00:00.000000', 'default2', NULL, 'default2', NULL, 65, 65, 1, NULL, 'default2'), (0, 0, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default2', 'default1', 'default1', 66, 0, 19, 64, 65, 'Supporter'), (19, 1, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', NULL, NULL, NULL, 19, 0, 66, NULL, 66, 'default2'), (20, 18, NULL, 'default2', NULL, 'Supporter', 'default2', NULL, 20, 1, 20, 66, 18, NULL), (65, 20, NULL, 'default2', '2023-01-01 00:00:00.000000', NULL, 'default2', 'default1', 18, NULL, 20, 0, 66, 'Supporter'), (18, 66, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'Supporter', 'default1', NULL, NULL, 18, 0, 1, 66, 'Supporter');
INSERT INTO badges (id, userid, name, date) VALUES (20, 64, NULL, NULL), (0, 20, 'default1', '2023-01-01 00:00:00.000000'), (19, 64, 'default1', NULL), (64, 66, NULL, '2023-01-01 01:00:00.000000'), (65, 0, 'Supporter', NULL), (66, 18, 'default2', NULL), (18, 0, 'Supporter', '2023-01-01 01:00:00.000000'), (1, 0, NULL, '2023-01-01 00:00:00.000000'), (2, 66, 'Supporter', NULL), (3, 0, 'Supporter', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T2.Name = 'Supporter' AND T1.Age BETWEEN 19 AND 65;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "users"."id") FROM "users" INNER JOIN "badges" ON "users"."id" = "badges"."userid" WHERE "users"."age" BETWEEN 19 AND 65 AND "badges"."name" = 'Supporter';

/*
Prediction Result:
(1,)
*/