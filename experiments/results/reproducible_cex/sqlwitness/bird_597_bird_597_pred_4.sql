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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 1, '2023-01-01 00:00:00.000000', 'India', '2023-01-01 00:00:00.000000', 'Teacher', 'default2', 'default2', 0, 1, 1, 1, NULL, 'Teacher'), (0, 0, '2023-01-01 00:00:00.000000', NULL, NULL, 'default1', 'india', 'default2', 1, 1, 0, 0, NULL, 'default1'), (2, NULL, '2023-01-01 01:00:00.000000', 'india', '2023-01-01 01:00:00.000000', 'default1', 'default1', 'default1', NULL, 1, 0, NULL, NULL, 'India'), (3, NULL, NULL, 'India', NULL, NULL, NULL, 'Teacher', 1, 0, NULL, 0, 1, 'india'), (4, 0, '2023-01-01 00:00:00.000000', NULL, NULL, 'Teacher', NULL, 'default2', 1, 0, 0, 1, 0, 'default1'), (5, NULL, NULL, 'india', NULL, NULL, 'default1', 'India', 1, NULL, 0, NULL, 1, 'india'), (6, NULL, '2023-01-01 00:00:00.000000', 'Teacher', '2023-01-01 00:00:00.000000', NULL, NULL, 'default2', NULL, 0, 1, 1, NULL, 'India'), (7, 1, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'India', 'india', 0, 1, NULL, 1, NULL, 'default1'), (8, NULL, '2023-01-01 01:00:00.000000', 'india', NULL, 'default1', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL), (9, NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, NULL, 'india', 'default2', 1, 0, NULL, NULL, 1, 'default1'), (10, 1, '2023-01-01 00:00:00.000000', 'india', '2023-01-01 00:00:00.000000', 'default1', 'default2', 'default2', 0, NULL, 0, 1, 1, 'default1');
INSERT INTO badges (id, userid, name, date) VALUES (0, 10, 'Teacher', NULL), (1, 0, 'india', '2023-01-01 01:00:00.000000'), (2, 4, NULL, NULL), (3, 7, 'Teacher', NULL), (4, 0, 'Teacher', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T2.Location = 'India' AND T1.Name = 'Teacher';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT b.UserId) FROM badges AS b JOIN users AS u ON b.UserId = u.Id WHERE LOWER(u.Location) = 'india' AND b.Name = 'Teacher';

/*
Prediction Result:
(2,)
*/