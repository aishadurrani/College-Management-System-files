CREATE DATABASE CollegeManagementSystem;
USE	CollegeManagementSystem;

CREATE TABLE department (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
    
CREATE TABLE course( 
	id INT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL, 
    deptId INT NOT NULL,
    CONSTRAINT fk_course_deptid FOREIGN KEY(deptid)
    REFERENCES department(id)
    );
    
CREATE TABLE faculty(
	id INT PRIMARY KEY, 
    firstname VARCHAR(30) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    deptId INT NOT NULL,
    CONSTRAINT fk_faculty_deptid FOREIGN KEY(deptid)
    REFERENCES department(id)
    );
    
CREATE TABLE facultyCourse(
	facultyId INT NOT NULL,
    courseId INT NOT NULL,
    CONSTRAINT fk_facultyCourse_facultyid FOREIGN KEY(facultyId)
    REFERENCES faculty(id),
    CONSTRAINT fk_facultyCourse_course FOREIGN KEY(courseId)
    REFERENCES course(id)
    );
    
CREATE TABLE student(
	id INT PRIMARY KEY,
    firstname VARCHAR(30) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    street VARCHAR(50) NOT NULL,
    streetDetail VARCHAR(30) NOT NULL,
    city VARCHAR(30) NOT NULL,
    state VARCHAR(30) NOT NULL,
    postalCode CHAR(5) NOT NULL,
    majorId INT NOT NULL,
    CONSTRAINT st_student_majorid FOREIGN KEY(majorId)
    REFERENCES department(id)
    );
    
CREATE TABLE studentCourse(
	studentID INT NOT NULL,
    courseId INT NOT NULL,
    progress INT NOT NULL,
    startDate DATE,
    CONSTRAINT st_studentCourse_studentid FOREIGN KEY(studentID)
    REFERENCES student(id),
    CONSTRAINT st_studentCourse_course FOREIGN KEY(courseID)
    REFERENCES course(id)
    );

    
    