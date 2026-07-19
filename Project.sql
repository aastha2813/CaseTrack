create database CaseTrack;
use CaseTrack;

create table CaseFile (
    Case_Id varchar(10) primary key,
    Title varchar(100),
    Description varchar(max),
    Start_Date date,
    Status varchar(50),
    Crime_Type varchar(50)
);

select * from CaseFile;

create table CrimeScene (
    Scene_id varchar(10) primary key,
    Case_id varchar(10) unique,
    Address varchar(200),
    City varchar(50),
    Date_Reported date,
    Description varchar(max),
    foreign (Case_Id) references CaseFile(Case_Id)
);

create table Officer (
    Officer_Id varchar(10) primary key,
    Name varchar(100),
    Officer_Rank varchar(50),
    Department varchar(100)
);

create table CaseOfficer (
    Case_Id varchar(10),
    Officer_Id varchar(10),
    Role_In_Case varchar(50),
    primary key (Case_Id, Officer_Id),
    foreign key (Case_Id) references CaseFile(Case_Id),
    foreign key (Officer_Id) references Officer(Officer_Id)
);

create table CaseSuspect (
    Suspect_Id varchar(10) primary key,
    Case_Id varchar(10),
    Name varchar(100),
    DOB date,
    Gender varchar(10),
    Criminal_History varchar(max)
    Suspicion_Level varchar(20),
    Role_In_Case varchar(50),
    primary key (Case_Id, Suspect_Id),
    foreign key (Case_Id) references CaseFile(Case_Id)
);

create table Witness (
    Witness_Id varchar(10) primary key,
    Case_Id varchar(10),
    Name varchar(100),
    DOB date,
    Contact_Info varchar(20),
    Statement_Text varchar(max),
    foreign key (Case_Id) references CaseFile(Case_Id)
);

create table Clue (
    Clue_Id varchar(10) primary key,
    Case_Id varchar(10),
    Description varchar(max),
    Discovered_Date date,
    Location varchar(100),
    foreign key (Case_Id) references CaseFile(Case_Id)
);

create table Evidence (
    Evidence_Id varchar(10) primary key,
    Case_Id varchar(10),
    Clue_Id varchar(10) unique,
    Type varchar(50),
    Description varchar(max),
    Storage_Location varchar(100),
    foreign key (Case_Id) references CaseFile(Case_Id),
    foreign key (Clue_Id) references Clue(Clue_Id)
);

create table Verdict (
    Verdict_Id varchar(10) primary key,
    Case_Id varchar(10),
    Decision varchar(50),
    Date date,
    Remarks varchar(max),
    foreign key (Case_Id) references CaseFile(Case_Id)
);

create table CaseAdvocate (
    Case_Id varchar(10),
    Advocate_Name varchar(100),
    Role varchar(50),
    Experience_Years int,
    primary key (Case_Id, Advocate_Name),
    foreign key (Case_Id) references CaseFile(Case_Id)
);

create table CaseJudge (
    Case_Id varchar(10),
    Judge_Name varchar(100),
    Court_Name varchar(100),
    primary key (Case_Id, Judge_Name),
    foreign key (Case_Id) references CaseFile(Case_Id)
);

-- QUERIES --

--1. Retrieve the names of suspects whose date of birth is after 3rd October 1977.
select Name from CaseSuspect where DOB > '1977-10-03';

--2. Display all details of officers whose rank is Inspector.
select * from Officer where rank = 'Inspector';

--3. List all distinct crime types from the CaseFile table.
select distinct Crime_Type from CaseFile;

--4. Show all evidence records where the type is Fingerprint.
select * from Evidence where Type = 'Fingerprint';

--5. Display all case records sorted by start date in descending order.
select * from CaseFile order by Start_Date desc;

--6. Retrieve details of suspects whose suspicion level is Low.
select * from CaseSuspect where Suspicion_Level = 'Low';

--7. Display all cases where the crime type is either Theft or Murder.
select * from CaseFile where Crime_Type in ('Theft','Murder');

--8. Retrieve all officers whose names start with the letter ‘A’.
select * from Officer where name like 'A%';

--9. Find all suspects whose names contain the substring “sh”.
select * from CaseSuspect where Name like '%sh%';

--10. Display all cases that are not closed.
select * from CaseFile where status != 'Closed';

--11. Retrieve officers whose rank is either Inspector or Sub Inspector.
select * from Officer where Officer_rank = 'Inspector' or Officer_rank = 'Sub Inspector';

--12. Display all suspects who are not female.
select * from CaseSuspect where not Gender = 'Female';

--13. Retrieve all cases that started after January 1, 2023.
select * from CaseFile where Start_Date > '2023-01-01';

-- INNER JOIN

--14. Display case ID, crime type, and suspect name.
select c.Case_Id, c.Crime_Type, s.Name
from CaseFile c
join CaseSuspect s on c.Case_Id = s.Case_Id;

--15. Retrieve case IDs along with officer names assigned to each case.
select c.case_id, o.name
from CaseFile c
join CaseOfficer co on c.Case_Id = co.Case_Id
join Officer o on co.Officer_Id = o.Officer_Id;

-- LEFT JOIN

--16. Display all case IDs along with their verdict decisions.
select c.Case_Id, v.Decision
from CaseFile c
left join Verdict v on c.Case_Id = v.Case_Id;

--17. Show suspect names along with the crime type of their respective cases.
select s.Name, c.Crime_Type
from CaseSuspect s
join CaseFile c on s.Case_Id = c.Case_Id;

--18. Display evidence type along with the crime type of the related case.
select e.Type, c.Crime_Type
from Evidence e
join CaseFile c on e.Case_Id = c.Case_Id;

--19. Retrieve the city of the crime scene along with the corresponding crime type.
select cs.City, c.Crime_Type
from CrimeScene cs
join CaseFile c on cs.Case_Id = c.Case_Id;

--  SELF JOIN (manager-type logic)

--20. Display advocate names along with their senior advocates working on the same case.
select a.Advocate_Name, b.Advocate_Name as Senior
from CaseAdvocate a
join CaseAdvocate b on a.Case_Id = b.Case_Id;

--21. Retrieve judge names along with the crime type of the cases they are assigned to.
select j.Judge_name, c.Crime_Type
from CaseJudge cj
join CaseFile c on cj.Case_Id = c.Case_Id
join CaseJudge j on cj.Judge_Id = j.Judge_Id;

--22. Display officer names along with the case IDs they are assigned to.
select o.name, co.Case_Id
from Officer o
join CaseOfficer co on o.Officer_Id = co.Officer_Id;

--23. Count the number of evidence items associated with each case.
select c.Case_Id, count(e.Evidence_Id)
from CaseFile c
left join Evidence e on c.Case_Id = e.Case_Id
group by c.Case_Id;

--24. Find the total number of cases in the CaseFile table.
select count(*) from CaseFile;

--25. Count the number of cases for each crime type.
select Crime_Type, count(*) from CaseFile group by Crime_Type;

--26. Count the number of suspects involved in each case.
select Case_Id, count(*) as suspects
from CaseSuspect
group by Case_Id;

--27. Count the number of evidence records for each case.
select Case_Id, count(*) as evidence_count
from Evidence
group by Case_Id;

--28. Display case IDs that have more than one suspect.
select Case_Id, count(*) 
from CaseSuspect
group by Case_Id
having count(*) > 1;

--29. Count the number of officers for each rank.
select Officer_Rank, count(*) from Officer group by Officer_Rank;

--30. Find the most recent (maximum) start date among all cases.
select max(Start_date) from CaseFile;

--31. Retrieve all cases that have associated evidence records.
select * from CaseFile
where Case_Id in (select Case_Id from Evidence);

--32. Display details of officers assigned to case ID C101.
select * from Officer
where officer_id in (
    select officer_id from CaseOfficer where case_id = 101);

--33. Find the case ID(s) that have the highest number of evidence items.
select Case_Id 
from Evidence
group by Case_Id
having count(*) = (
    select max(count(*)) from Evidence group by Case_Id);

--34. Retrieve names of suspects involved in murder cases.
select Name
from CaseSuspect
where case_id in (
    select case_id from CaseFile where Crime_Type = 'Murder'
);

--35. Display cases that do not have any verdict recorded.
select * from CaseFile
where Case_Id not in (select Case_Id from Verdict);

--36. Find the case with the earliest start date.
select Case_Id 
from CaseFile
where Start_Date = (select min(Start_Date) from CaseFile);

--update

-- 37. Update the status of case ID C101 to Closed.
update CaseFile
set status = 'Closed'
where case_id = 'C101';

-- 38. Change the rank of officer with ID O002 to Senior Inspector.
update Officer
set rank = 'Senior Inspector'
where officer_id = 'O002';

-- 39. Update the evidence type to DNA for evidence ID E003.
update Evidence
set Type = 'DNA'
where evidence_id = 'E003';

-- 40. Change the city of the crime scene for case ID C102 to Pune.
update CrimeScene
set City = 'Pune'
where case_id = 'C005';

--41. Update the verdict of case ID C101 to Guilty.
update Verdict
set Decision = 'Guilty'
where case_id = 'C001';