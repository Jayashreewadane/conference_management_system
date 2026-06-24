CREATE DATABASE ConferenceManagement;
USE ConferenceManagement;
CREATE TABLE conferences (
    conference_id INT PRIMARY KEY,
    conference_name VARCHAR(100),
    location VARCHAR(100),
    start_date DATE,
    end_date DATE
);
CREATE TABLE attendees (
    attendee_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    company VARCHAR(100),
    job_title VARCHAR(100)
);
CREATE TABLE speakers (
    speaker_id INT PRIMARY KEY,
    name VARCHAR(100),
    bio TEXT,
    expertise VARCHAR(100)
);
CREATE TABLE sessions (
    session_id INT PRIMARY KEY,
    conference_id INT,
    session_title VARCHAR(100),
    speaker_id INT,
    schedule_time DATETIME,
    room VARCHAR(50),

    FOREIGN KEY (conference_id)
    REFERENCES conferences(conference_id),

    FOREIGN KEY (speaker_id)
    REFERENCES speakers(speaker_id)
);
CREATE TABLE registrations (
    registration_id INT PRIMARY KEY,
    attendee_id INT,
    conference_id INT,
    registration_date DATE,
    ticket_type VARCHAR(50),

    FOREIGN KEY (attendee_id)
    REFERENCES attendees(attendee_id),

    FOREIGN KEY (conference_id)
    REFERENCES conferences(conference_id)
);
INSERT INTO conferences VALUES
(1, 'Tech Summit 2026', 'Mumbai', '2026-06-10', '2026-06-12'),
(2, 'AI Conference 2026', 'Pune', '2026-07-15', '2026-07-17');
INSERT INTO attendees VALUES
(101, 'Rahul Sharma', 'rahul@gmail.com', 'TCS', 'Developer'),
(102, 'Priya Patil', 'priya@gmail.com', 'Infosys', 'Analyst'),
(103, 'Amit Verma', 'amit@gmail.com', 'Wipro', 'Manager');
INSERT INTO speakers VALUES
(201, 'Dr. Mehta', 'AI Expert', 'Artificial Intelligence'),
(202, 'Anjali Rao', 'Cloud Specialist', 'Cloud Computing');
INSERT INTO registrations VALUES
(401, 101, 1, '2026-05-01', 'VIP'),
(402, 102, 1, '2026-05-02', 'Regular'),
(403, 103, 2, '2026-05-03', 'Student');
SELECT * FROM conferences;
SELECT * FROM attendees;
SELECT * FROM speakers;
SELECT * FROM sessions;
SELECT * FROM registrations;
SELECT a.name, a.email
FROM attendees a
JOIN registrations r
ON a.attendee_id = r.attendee_id
WHERE r.conference_id = 1;
SELECT sp.name,
COUNT(s.session_id) AS total_sessions
FROM speakers sp
LEFT JOIN sessions s
ON sp.speaker_id = s.speaker_id
GROUP BY sp.name;
SELECT sp.name
FROM speakers sp
LEFT JOIN sessions s
ON sp.speaker_id = s.speaker_id
WHERE s.session_id IS NULL;
SELECT a.name,
COUNT(r.conference_id) AS total_conferences
FROM attendees a
JOIN registrations r
ON a.attendee_id = r.attendee_id
GROUP BY a.name
HAVING COUNT(r.conference_id) > 1;
SELECT session_title, schedule_time
FROM sessions
WHERE room = 'Hall A';
UPDATE attendees
SET company = 'Accenture'
WHERE attendee_id = 101;
DELETE FROM registrations
WHERE registration_id = 403;
DROP TABLE registrations;
DROP DATABASE ConferenceManagement;
