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
INSERT INTO users (Id, Reputation, DisplayName) VALUES (1, 100, 'UserOne');
INSERT INTO users (Id, Reputation, DisplayName) VALUES (2, 200, 'UserTwo');
INSERT INTO posts (Id, PostTypeId, AcceptedAnswerId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LasActivityDate, Title, LastEditorUserId, LastEditDate, CommunityOwnedDate, ClosedDate, ParentId) VALUES (10, 1, 20, '2020-01-01 00:00:00', 5, 100, 'Body 10', 1, '2020-01-05 00:00:00', 'What is the best introductory Bayesian statistics textbook?', 2, '2020-01-02 12:00:00', '2020-01-03 00:00:00', '2020-01-04 00:00:00', 20);
INSERT INTO posts (Id, PostTypeId, AcceptedAnswerId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LasActivityDate, Title, LastEditorUserId, LastEditDate, CommunityOwnedDate, ClosedDate, ParentId) VALUES (20, 2, 10, '2020-02-01 00:00:00', 3, 50, 'What is the best introductory Bayesian statistics textbook?', 2, '2020-02-05 00:00:00', 'Another Title', 1, '2020-02-02 12:00:00', '2020-02-03 00:00:00', '2020-02-04 00:00:00', 10);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, RevisionGUID, CreationDate, UserId, Text, Comment) VALUES (100, 1, 10, 'guid-100', '2020-01-01 01:00:00', 1, 'History Text 100', 'Comment 100');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, RevisionGUID, CreationDate, UserId, Text, Comment) VALUES (101, 2, 10, 'guid-101', '2020-01-01 02:00:00', 2, 'History Text 101', 'Comment 101');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, RevisionGUID, CreationDate, UserId, Text, Comment) VALUES (102, 1, 20, 'guid-102', '2020-02-01 01:00:00', 2, 'What is the best introductory Bayesian statistics textbook?', 'What is the best introductory Bayesian statistics textbook?');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Id, T2.LastEditDate FROM postHistory AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T2.Title = 'What is the best introductory Bayesian statistics textbook?';

/*
Gold Result:
(100, '2020-01-02 12:00:00')
(101, '2020-01-02 12:00:00')
*/

-- Prediction Query
SELECT COUNT(ph.Id) AS PostHistoryCount, MAX(ph.CreationDate) AS LastEditDate FROM posts AS p INNER JOIN postHistory AS ph ON p.Id = ph.PostId WHERE p.Title = 'What is the best introductory Bayesian statistics textbook?';

/*
Prediction Result:
(2, '2020-01-01 02:00:00')
*/