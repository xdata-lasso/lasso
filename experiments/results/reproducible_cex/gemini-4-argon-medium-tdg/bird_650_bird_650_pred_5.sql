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
-- Tests basic join, WHERE condition filtering, string case/substring variations, outer joins, and wrong join conditions (e.g., T1.Id = T2.Id).
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, LastAccessDate, WebsiteUrl, Location, AboutMe, Views, UpVotes, DownVotes, AccountId, Age, ProfileImageUrl) VALUES (1, 100, '2020-01-01 00:00:00', 'Alice', '2023-05-01 10:00:00', 'http://alice.com', 'New York', 'Bio 1', 10, 5, 1, 1001, 25, 'img1.jpg');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, LastAccessDate, WebsiteUrl, Location, AboutMe, Views, UpVotes, DownVotes, AccountId, Age, ProfileImageUrl) VALUES (2, 200, '2020-01-02 00:00:00', 'Bob', '2023-05-02 11:00:00', 'http://bob.com', 'London', 'Bio 2', 20, 10, 2, 1002, 30, 'img2.jpg');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, LastAccessDate, WebsiteUrl, Location, AboutMe, Views, UpVotes, DownVotes, AccountId, Age, ProfileImageUrl) VALUES (3, 300, '2020-01-03 00:00:00', 'Charlie', '2023-05-03 12:00:00', 'http://charlie.com', 'Paris', 'Bio 3', 30, 15, 3, 1003, 35, 'img3.jpg');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, LastAccessDate, WebsiteUrl, Location, AboutMe, Views, UpVotes, DownVotes, AccountId, Age, ProfileImageUrl) VALUES (10, 400, '2020-01-04 00:00:00', 'Dave', '2023-05-04 13:00:00', 'http://dave.com', 'Tokyo', 'Bio 4', 40, 20, 4, 1004, 40, 'img4.jpg');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (10, 1, 'outliers', '2021-06-01 08:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (11, 2, 'Outliers', '2021-06-02 09:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (12, 2, 'outlier', '2021-06-03 09:30:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (13, NULL, 'outliers', '2021-06-04 10:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (14, 1, NULL, '2021-06-05 11:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.LastAccessDate, T1.Location FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T2.Name = 'outliers';

/*
Gold Result:
('2023-05-01 10:00:00', 'New York')
*/

-- Prediction Query
SELECT COALESCE(T1.LastAccessDate, 'Unknown'), COALESCE(T1.Location, 'Unknown') FROM users AS T1 LEFT JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T2.Name = 'Outliers';

/*
Prediction Result:
('2023-05-02 11:00:00', 'London')
*/