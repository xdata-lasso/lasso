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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, NULL, NULL, '%India%', '2023-01-01 00:00:00.000000', 'Teacher', '%India%', 'Teacher', NULL, NULL, 1, NULL, 1, NULL), (0, 1, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', '%India%', '%India%', 'Teacher', 0, 0, 0, 1, 0, '%India%'), (2, 0, NULL, 'India', '2023-01-01 01:00:00.000000', 'India', 'default2', NULL, 1, NULL, NULL, NULL, 1, '%India%'), (3, 0, '2023-01-01 01:00:00.000000', '%India%', '2023-01-01 01:00:00.000000', NULL, 'Teacher', '%India%', 1, NULL, 1, 1, NULL, 'default2'), (4, 0, NULL, 'default1', '2023-01-01 01:00:00.000000', 'India', NULL, NULL, 0, NULL, 1, 1, 0, NULL), (5, 1, '2023-01-01 00:00:00.000000', NULL, NULL, 'default2', 'default1', 'default1', 0, 1, NULL, NULL, NULL, NULL), (6, NULL, '2023-01-01 00:00:00.000000', '%India%', '2023-01-01 00:00:00.000000', NULL, 'default1', 'default2', 1, 0, NULL, NULL, 1, '%India%'), (7, 0, '2023-01-01 01:00:00.000000', '%India%', '2023-01-01 01:00:00.000000', 'India', 'India', '%India%', 1, 0, NULL, 0, NULL, '%India%');
INSERT INTO badges (id, userid, name, date) VALUES (1, NULL, 'default1', NULL), (0, 1, 'Teacher', '2023-01-01 01:00:00.000000'), (2, 6, 'India', '2023-01-01 01:00:00.000000'), (3, 0, 'India', '2023-01-01 01:00:00.000000'), (4, 0, 'default2', '2023-01-01 00:00:00.000000'), (5, 3, 'India', NULL), (6, 5, 'default2', '2023-01-01 00:00:00.000000'), (7, 1, NULL, NULL), (8, NULL, 'default1', NULL), (9, 3, NULL, '2023-01-01 00:00:00.000000'), (10, 2, 'Teacher', '2023-01-01 00:00:00.000000'), (11, 6, 'default1', NULL), (12, 7, 'Teacher', NULL), (13, 3, 'India', '2023-01-01 01:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T2.Location = 'India' AND T1.Name = 'Teacher';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.UserId) FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T2.Location LIKE '%India%' AND T1.Name = 'Teacher';

/*
Prediction Result:
(2,)
*/