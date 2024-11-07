-- Create the database
CREATE DATABASE IF NOT EXISTS sms_db;
USE sms_db;

-- Create address table
CREATE TABLE address (
    id INT PRIMARY KEY auto_increment,
    state VARCHAR(50),
    city VARCHAR(50)
);

-- Create user table
CREATE TABLE user (
    id INT PRIMARY KEY auto_increment,
    username VARCHAR(50),
    password VARCHAR(50),
    role VARCHAR(20)
);

-- Create student table
CREATE TABLE student (
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(100),
    contact VARCHAR(20),
    user_id INT,
    address_id INT,
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (address_id) REFERENCES address(id)
);

-- Create course table
CREATE TABLE course (
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(100),
    credits INT,
    department_id INT
);

-- Create student_course table (junction table)
CREATE TABLE student_course (
    student_id INT,
    course_id INT,
    date_of_enroll DATE,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (course_id) REFERENCES course(id)
);

-- Create instructor table
CREATE TABLE instructor (
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(100),
    salary DECIMAL(10,2),
    contact VARCHAR(20),
    job_title varchar(255)
);

-- Create course_instructor table (junction table)
CREATE TABLE course_instructor (
    course_id INT auto_increment,
    instructor_id INT,
    batch VARCHAR(10),
    month VARCHAR(20),
    year INT,
    PRIMARY KEY (course_id, instructor_id),
    FOREIGN KEY (course_id) REFERENCES course(id),
    FOREIGN KEY (instructor_id) REFERENCES instructor(id)
);

-- Insert data into address
INSERT INTO address (id, state, city) VALUES
(1, 'California', 'Los Angeles'),
(2, 'New York', 'New York City');

-- Insert data into user
INSERT INTO user (id, username, password, role) VALUES
(1, 'student1', 'pass123', 'student'),
(2, 'student2', 'pass456', 'student');

-- Insert data into student
INSERT INTO student (id, name, contact, user_id, address_id) VALUES
(1, 'Alice Johnson', '555-0011', 1, 1),
(2, 'Bob Williams', '555-0022', 2, 2);

-- Insert data into course
INSERT INTO course (id, name, credits, department_id) VALUES
(1, 'Spring Boot', 3, 1),
(2, 'AWS Services', 3, 1);

-- Insert data into student_course
INSERT INTO student_course (student_id, course_id, date_of_enroll) VALUES
(1, 1, '2024-10-01'),
(2, 2, '2024-10-02');

-- Insert data into instructor
INSERT INTO instructor (id, name, salary, contact,job_title) VALUES
(1, 'John Doe', 70000, '555-1234',"junior"),
(2, 'Jane Smith', 80000, '555-5678',"junior");

-- Insert data into course_instructor
INSERT INTO course_instructor (course_id, instructor_id, batch, month, year) VALUES
(1, 1, 'A', 'August', 2024),
(2, 2, 'B', 'August', 2024);

CREATE TABLE instructor_event_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    updated_column text,
    old_value text,
    new_value text,
    updated_time timestamp default current_timestamp,
    updated_by text,
    inst_id INT 
);

delimiter $$
create trigger instructor_update_trigger3
before update on instructor
for each row
begin
	insert into instructor_event_logs(updated_column,old_value,new_value,updated_by,inst_id)
    values("salary", old.salary,new.salary,current_user(),old.id);
end;
$$
update instructor
set salary = 9000000
where id = 1;

show tables;

select * from instructor_event_logs;
select * from instructor;
select * from course_instructor;
select * from course;
select * from student_course;
select * from student;
select * from user;
select * from address;

