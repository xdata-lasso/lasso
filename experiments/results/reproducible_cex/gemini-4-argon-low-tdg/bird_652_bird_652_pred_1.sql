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
-- DATASET 1
-- Core positive case with duplicate projection values to kill DISTINCT mutations,
-- and decoupling of Primary Keys, Foreign Keys, and PostIds to kill join condition mutations (e.g., T1.Id = T2.Id, T1.PostId = T2.UserId, T1.Id = T2.UserId).
-- Also sets users.DisplayName != 'Samuel' to catch mutants joining users table and filtering on users.DisplayName.
INSERT INTO users (Id, DisplayName, CreationDate) VALUES (10, 'NotSamuel', '2012-01-01 00:00:00');
INSERT INTO users (Id, DisplayName, CreationDate) VALUES (20, 'Samuel', '2013-01-01 00:00:00');
INSERT INTO posts (Id, OwnerUserId, CreaionDate, OwnerDisplayName) VALUES (100, 20, '2012-01-01 00:00:00', 'NotSamuel');
INSERT INTO postHistory (Id, PostId, UserId, CreationDate, UserDisplayName, Text, Comment) VALUES (1, 100, 10, '2013-05-15 10:20:30', 'Samuel', 'NotSamuel', 'NotSamuel');
INSERT INTO postHistory (Id, PostId, UserId, CreationDate, UserDisplayName, Text, Comment) VALUES (2, 100, 10, '2013-08-20 14:00:00', 'Samuel', 'NotSamuel', 'NotSamuel');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (500, 10, 'Scholar', '2013-01-01 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (501, 10, 'Scholar', '2013-12-31 23:59:59');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.PostId, T2.Name FROM postHistory AS T1 INNER JOIN badges AS T2 ON T1.UserId = T2.UserId WHERE T1.UserDisplayName = 'Samuel' AND STRFTIME('%Y', T1.CreationDate) = '2013' AND STRFTIME('%Y', T2.Date) = '2013';

/*
Gold Result:
(100, 'Scholar')
(100, 'Scholar')
(100, 'Scholar')
(100, 'Scholar')
*/

-- Prediction Query
SELECT DISTINCT "posts"."id" AS "post_id", "badges"."name" AS "badge_name" FROM "users" INNER JOIN "comments" ON "users"."id" = "comments"."userid" INNER JOIN "posts" ON "comments"."postid" = "posts"."id" INNER JOIN "badges" ON "users"."id" = "badges"."userid" WHERE "users"."displayname" = 'Samuel' AND STRFTIME('%Y', "comments"."creationdate") = '2013' AND STRFTIME('%Y', "badges"."date") = '2013';

/*
Prediction Result:
*/