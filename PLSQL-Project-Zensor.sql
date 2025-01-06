
CREATE TABLE Students (
    StudentID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Program VARCHAR2(50),
    Year NUMBER(1),
    Email VARCHAR2(100) UNIQUE
);

CREATE TABLE Courses (
    CourseID NUMBER PRIMARY KEY,
    CourseName VARCHAR2(100),
    Credits NUMBER(2),
    MaxEnrollment NUMBER,
    CurrentEnrollment NUMBER DEFAULT 0
);


CREATE TABLE Prerequisites (
    CourseID NUMBER,
    PrerequisiteID NUMBER,
    PRIMARY KEY (CourseID, PrerequisiteID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE,
    FOREIGN KEY (PrerequisiteID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);


CREATE TABLE Registrations (
    RegistrationID NUMBER PRIMARY KEY,
    StudentID NUMBER,
    CourseID NUMBER,
    Status VARCHAR2(20) DEFAULT 'Active',
    RegistrationDate DATE DEFAULT SYSDATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);


CREATE TABLE Administrators (
    AdminID NUMBER PRIMARY KEY,
    AdminName VARCHAR2(100),
    Password VARCHAR2(100)
);




--1. procedure to calculate the total credits for a student based on active registrations.

CREATE OR REPLACE PROCEDURE Calculate_Total_Credits (
    p_StudentID IN NUMBER,
    p_TotalCredits OUT NUMBER
) AS
BEGIN
    SELECT SUM(c.Credits)
    INTO p_TotalCredits
    FROM Courses c
    JOIN Registrations r ON c.CourseID = r.CourseID
    WHERE r.StudentID = p_StudentID AND r.Status = 'Active';
END;
/


--2. Procedure to check prerequisites and enroll a student in a course.

CREATE OR REPLACE PROCEDURE Register_Student (
    p_StudentID IN NUMBER,
    p_CourseID IN NUMBER
) AS
    v_PrerequisiteMet BOOLEAN := TRUE;
    v_TotalCredits NUMBER;
    v_MaxEnrollment NUMBER;
    v_CurrentEnrollment NUMBER;
BEGIN
    -- Check prerequisites
    FOR prereq IN (
        SELECT PrerequisiteID
        FROM Prerequisites
        WHERE CourseID = p_CourseID
    ) LOOP
        IF NOT EXISTS (
            SELECT 1
            FROM Registrations
            WHERE StudentID = p_StudentID
              AND CourseID = prereq.PrerequisiteID
              AND Status = 'Completed'
        ) THEN
            v_PrerequisiteMet := FALSE;
            EXIT;
        END IF;
    END LOOP;
    
    IF v_PrerequisiteMet THEN
        -- Check enrollment limits
        SELECT MaxEnrollment INTO v_MaxEnrollment FROM Courses WHERE CourseID = p_CourseID;
        SELECT COUNT(*) INTO v_CurrentEnrollment FROM Registrations WHERE CourseID = p_CourseID AND Status = 'Active';
        
        IF v_CurrentEnrollment < v_MaxEnrollment THEN
            INSERT INTO Registrations (StudentID, CourseID, Status, RegistrationDate)
            VALUES (p_StudentID, p_CourseID, 'Active', SYSDATE);
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'Course is full.');
        END IF;
    ELSE
        RAISE_APPLICATION_ERROR(-20002, 'Prerequisites not met.');
    END IF;
END;
/


--3. Trigger to reject an insert into Registrations if a course exceeds maximum enrollment.

CREATE OR REPLACE TRIGGER Prevent_OverEnrollment
BEFORE INSERT ON Registrations
FOR EACH ROW
DECLARE
    v_MaxEnrollment NUMBER;
    v_CurrentEnrollment NUMBER;
BEGIN
    SELECT MaxEnrollment INTO v_MaxEnrollment FROM Courses WHERE CourseID = :NEW.CourseID;
    SELECT COUNT(*) INTO v_CurrentEnrollment FROM Registrations WHERE CourseID = :NEW.CourseID AND Status = 'Active';
    
    IF v_CurrentEnrollment >= v_MaxEnrollment THEN
        RAISE_APPLICATION_ERROR(-20003, 'Cannot register: course is full.');
    END IF;
END;
/

