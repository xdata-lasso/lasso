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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (0, NULL, '2023-01-01 00:00:00.000000', 'North Pole', '2023-01-01 01:00:00.000000', 'default1', '%Y', NULL, 1, 0, 1, 1, 0, '%Y'), (1, NULL, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', '2011', NULL, 'North Pole', NULL, 0, 1, 1, NULL, '%Y'), (2, 0, '2023-01-01 00:00:00.000000', NULL, '2011-10-27 00:00:00.000000', '2011', '%Y', NULL, 1, NULL, 0, 0, 1, '2011'), (3, NULL, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default1', '%Y', 'default2', 0, 1, NULL, 0, 0, NULL), (4, NULL, '2023-01-01 00:00:00.000000', '%Y', '2023-01-01 00:00:00.000000', '2011', 'North Pole', 'default1', 1, NULL, 0, NULL, NULL, 'North Pole'), (5, 0, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', '2011', 'default1', '2011', 0, 1, 0, 0, 0, 'default1'), (6, 0, '2023-01-01 01:00:00.000000', '%Y', '2023-01-01 00:00:00.000000', '2011', '2011', 'North Pole', NULL, 0, 0, 0, 1, 'default2'), (7, 0, '2011-10-27 00:00:00.000000', '2011', '2011-10-27 00:00:00.000000', '%Y', 'North Pole', '2011', 1, 0, NULL, 0, 0, 'default1'), (8, 1, '2011-10-27 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default2', '%Y', 'default1', 0, 0, NULL, NULL, 0, 'default2'), (9, NULL, '2023-01-01 01:00:00.000000', 'North Pole', NULL, 'default1', '2011', '%Y', 0, 1, 1, NULL, 0, 'default1'), (10, NULL, '2023-01-01 01:00:00.000000', '%Y', NULL, NULL, 'North Pole', 'North Pole', 0, 1, 1, 1, NULL, NULL), (11, 1, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', '%Y', 'default1', NULL, NULL, 1, NULL, 1, 'North Pole'), (12, 1, '2011-10-27 00:00:00.000000', 'North Pole', NULL, 'default1', 'default2', 'default2', 0, NULL, NULL, 1, NULL, 'default1'), (13, 0, '2023-01-01 00:00:00.000000', NULL, NULL, 'default2', '2011', '2011', 1, 1, NULL, 1, 1, 'North Pole'), (14, 0, '2011-10-27 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'default2', NULL, 'default1', NULL, 1, NULL, 0, 0, 'default1'), (15, 0, '2023-01-01 01:00:00.000000', '2011', NULL, 'North Pole', 'North Pole', 'default1', NULL, NULL, NULL, NULL, 1, '2011'), (16, NULL, NULL, 'default1', '2011-10-27 00:00:00.000000', 'North Pole', 'default2', '%Y', 1, 1, 1, 0, 1, 'default2');
INSERT INTO badges (id, userid, name, date) VALUES (1, 1, 'default2', '2011-10-27 00:00:00.000000'), (0, 4, 'North Pole', '2011-10-27 00:00:00.000000'), (2, 14, 'default2', '2011-10-27 00:00:00.000000'), (3, 0, 'default2', '2023-01-01 00:00:00.000000'), (4, 2, '2011', NULL), (5, 11, NULL, '2023-01-01 00:00:00.000000'), (6, 2, NULL, NULL), (7, 4, 'North Pole', '2011-10-27 00:00:00.000000'), (8, NULL, 'default2', NULL), (9, 1, '2011', '2023-01-01 00:00:00.000000'), (10, 2, '%Y', '2023-01-01 01:00:00.000000'), (11, 8, 'North Pole', '2011-10-27 00:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Name FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE STRFTIME('%Y', T2.Date) = '2011' AND T1.Location = 'North Pole';

/*
Gold Result:
('North Pole',)
('North Pole',)
*/

-- Prediction Query
SELECT DISTINCT "badges"."name" FROM "badges" INNER JOIN "users" ON "badges"."userid" = "users"."id" WHERE STRFTIME('%Y', "badges"."date") = '2011' AND "users"."location" = 'North Pole';

/*
Prediction Result:
('North Pole',)
*/