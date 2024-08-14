-- CREATE DATABASE company;
CREATE SCHEMA IF NOT EXISTS company;
USE company;

CREATE TABLE employees (
	fName VARCHAR(15) NOT NULL,
    mInit CHAR,
    lName VARCHAR(15) NOT NULL,
    ssn CHAR(9) NOT NULL, 
    bDate DATE,
    address VARCHAR(30),
    sex CHAR,
    salary DECIMAL(10,2),
    superSsn CHAR(9),
    dNo INT NOT NULL,
    CONSTRAINT pk_employee PRIMARY KEY (ssn)
);

ALTER TABLE employees MODIFY dNo INT NOT NULL DEFAULT 1;

ALTER TABLE employees 
	ADD CONSTRAINT fk_employee 
	FOREIGN KEY(superSsn) REFERENCES employees (ssn) 
	ON DELETE SET NULL
    ON UPDATE CASCADE;

ALTER TABLE employees 
	ADD CONSTRAINT fk_dept 
	FOREIGN KEY(dNo) REFERENCES departments(dNumber)
    ON UPDATE CASCADE;

CREATE TABLE departments (
	dName VARCHAR(15) NOT NULL,
    dNumber INT NOT NULL,
    mgrSsn CHAR(9) NOT NULL,
    mgrStartDate DATE, 
    deptCreateDate DATE,
    CONSTRAINT chk_dept_date CHECK (deptCreateDate <= mgrStartDate),
    CONSTRAINT pk_dept PRIMARY KEY (dNumber),
    CONSTRAINT unique_name_dept UNIQUE(dName),
    CONSTRAINT fk_employees FOREIGN KEY (mgrSsn) REFERENCES employees(ssn)
);

CREATE TABLE deptLocations (
	dNumber INT NOT NULL,
	dLocation VARCHAR(15) NOT NULL,
    CONSTRAINT pk_dept_locations PRIMARY KEY (dNumber, dLocation),
    CONSTRAINT fk_dept_locations FOREIGN KEY (dNumber) REFERENCES departments (dNumber)
);

ALTER TABLE deptLocations 
	ADD CONSTRAINT fk_dept_deptLocations FOREIGN KEY (dNumber) REFERENCES departments(dNumber)
	ON DELETE CASCADE
    ON UPDATE CASCADE;
    
CREATE TABLE projects (
	pName VARCHAR(15) NOT NULL,
	pNumber INT NOT NULL,
    pLocation VARCHAR(15),
    dNum INT NOT NULL,
    CONSTRAINT pk_project PRIMARY KEY (pNumber),
    CONSTRAINT unique_name_project UNIQUE (pName),
    CONSTRAINT fk_project FOREIGN KEY (dNum) REFERENCES departments(dNumber)
);

CREATE TABLE worksOn (
	eSsn CHAR(9) NOT NULL,
    pNo INT NOT NULL,
    hours DECIMAL(3,1) NOT NULL,
    PRIMARY KEY (eSsn, pNo),
    CONSTRAINT fk_works_on FOREIGN KEY (eSsn) REFERENCES employees(ssn),
    CONSTRAINT fk_worksOn_projects FOREIGN KEY (pNo) REFERENCES projects(pNumber)
);

CREATE TABLE dependents (
	eSsn CHAR(9) NOT NULL,
    dependentName VARCHAR(255) NOT NULL,
    sex CHAR,
    bDate DATE,
    age INT,
    relationship VARCHAR(8),
    CONSTRAINT chk_age_dependent CHECK (age < 21),
    CONSTRAINT pk_dependent PRIMARY KEY(eSsn, dependentName),
    CONSTRAINT fk_dependent FOREIGN KEY (eSsn) REFERENCES employees(ssn)
);

SELECT * FROM information_schema.table_constraints 
	WHERE (constraint_schema = 'company');
