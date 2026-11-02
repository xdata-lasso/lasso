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
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, Location, WebsiteUrl, AboutMe, AccountId) VALUES (101, 500, '2020-01-01 10:00:00', 'Alice', 'New York', 'http://alice.example.com', 'Statistician', 201);
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, Location, WebsiteUrl, AboutMe, AccountId) VALUES (102, 300, '2020-01-02 10:00:00', 'Bob', 'London', 'http://bob.example.com', 'Developer', 101);
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, Location, WebsiteUrl, AboutMe, AccountId) VALUES (103, 100, '2020-01-03 10:00:00', 'Charlie', 'Paris', 'http://charlie.example.com', 'Analyst', 301);
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LastEditorUserId, Title, Tags, OwnerDisplayName, LastEditorDisplayName) VALUES (201, 4, '2020-02-01 12:00:00', 10, 100, 'Excerpt for hypothesis testing', 101, 102, 'Other Title', '<other-tag>', 'WrongOwnerDisplay', 'WrongEditorDisplay');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LastEditorUserId, Title, Tags, OwnerDisplayName, LastEditorDisplayName) VALUES (202, 5, '2020-02-02 12:00:00', 20, 200, 'Wiki for hypothesis testing', 102, 101, 'hypothesis-testing', 'hypothesis-testing', 'BobDisplay', 'AliceDisplay');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LastEditorUserId, Title, Tags, OwnerDisplayName, LastEditorDisplayName) VALUES (203, 1, '2020-02-03 12:00:00', 30, 300, 'Question about hypothesis testing', 103, 103, 'hypothesis-testing', '<hypothesis-testing>', 'CharlieDisplay', 'CharlieDisplay');
INSERT INTO tags (Id, TagName, Count, ExcerptPostId, WikiPostId) VALUES (301, 'hypothesis-testing', 42, 201, 202);
INSERT INTO tags (Id, TagName, Count, ExcerptPostId, WikiPostId) VALUES (302, 'regression', 15, 203, 201);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.DisplayName, T3.Location FROM tags AS T1 INNER JOIN posts AS T2 ON T1.ExcerptPostId = T2.Id INNER JOIN users AS T3 ON T3.Id = T2.OwnerUserId WHERE T1.TagName = 'hypothesis-testing';

/*
Gold Result:
('Alice', 'New York')
*/

-- Prediction Query
SELECT T2.DisplayName, T2.Location FROM tags AS T1 INNER JOIN users AS T2 ON T1.ExcerptPostId = T2.Id WHERE T1.TagName = 'hypothesis-testing';

/*
Prediction Result:
*/