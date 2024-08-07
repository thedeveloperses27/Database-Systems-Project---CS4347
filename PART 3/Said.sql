-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 03, 2024 at 07:04 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Said`
--

-- --------------------------------------------------------

--
-- Table structure for table `Becomes`
--

CREATE TABLE `Becomes` (
  `UserID` int(11) NOT NULL,
  `ClubFacultyID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Club`
--

CREATE TABLE `Club` (
  `ClubID` int(11) NOT NULL,
  `Name` varchar(80) NOT NULL,
  `Type` varchar(50) NOT NULL,
  `FoundedDate` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ClubFaculty`
--

CREATE TABLE `ClubFaculty` (
  `ClubFacultyID` int(11) NOT NULL,
  `Role` varchar(20) NOT NULL,
  `JoinDate` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='A connection between students, clubs, and faculty.';

-- --------------------------------------------------------

--
-- Table structure for table `ClubLeaders`
--

CREATE TABLE `ClubLeaders` (
  `ClubFacultyID` int(11) NOT NULL,
  `OrganizingExperience` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ClubOrganizers`
--

CREATE TABLE `ClubOrganizers` (
  `ClubFacultyID` int(11) NOT NULL,
  `LeadershipExperience` int(11) NOT NULL,
  `Vision` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CommunityService`
--

CREATE TABLE `CommunityService` (
  `EventID` int(11) NOT NULL,
  `Service` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `DegreeProgram`
--

CREATE TABLE `DegreeProgram` (
  `DegreeID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Departments`
--

CREATE TABLE `Departments` (
  `DepartmentID` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `DiscussionForum`
--

CREATE TABLE `DiscussionForum` (
  `ForumID` int(11) NOT NULL,
  `Title` varchar(100) NOT NULL,
  `Description` text NOT NULL,
  `CreatedDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='A digital platform designed for engaging users in online dis';

-- --------------------------------------------------------

--
-- Table structure for table `Employee`
--

CREATE TABLE `Employee` (
  `UserID` int(11) NOT NULL,
  `Salary` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Establishes`
--

CREATE TABLE `Establishes` (
  `ClubID` int(11) NOT NULL,
  `ForumID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Event`
--

CREATE TABLE `Event` (
  `EventID` int(11) NOT NULL,
  `EventName` varchar(80) NOT NULL,
  `EventType` varchar(20) NOT NULL,
  `Date` date NOT NULL,
  `StartTime` datetime NOT NULL,
  `EndTime` datetime NOT NULL,
  `Location` varchar(100) NOT NULL,
  `Description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `EventClubOrganizes`
--

CREATE TABLE `EventClubOrganizes` (
  `EventID` int(11) NOT NULL,
  `ClubID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Faculty`
--

CREATE TABLE `Faculty` (
  `UserID` int(11) NOT NULL,
  `DepartmentID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Graduate`
--

CREATE TABLE `Graduate` (
  `UserID` int(11) NOT NULL,
  `DegreeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Hosts`
--

CREATE TABLE `Hosts` (
  `ClubID` int(11) NOT NULL,
  `ClubFacultyID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Make`
--

CREATE TABLE `Make` (
  `UserID` int(11) NOT NULL,
  `PostID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Organizes`
--

CREATE TABLE `Organizes` (
  `EventID` int(11) NOT NULL,
  `ClubID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Positions`
--

CREATE TABLE `Positions` (
  `PositionID` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Post`
--

CREATE TABLE `Post` (
  `PostID` int(11) NOT NULL,
  `Content` text NOT NULL,
  `UserID` int(11) NOT NULL,
  `PostedDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Seminar`
--

CREATE TABLE `Seminar` (
  `EventID` int(11) NOT NULL,
  `Topic` varchar(100) NOT NULL,
  `Speaker` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Social`
--

CREATE TABLE `Social` (
  `EventID` int(11) NOT NULL,
  `Activity` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Staff`
--

CREATE TABLE `Staff` (
  `UserID` int(11) NOT NULL,
  `PositionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Stores`
--

CREATE TABLE `Stores` (
  `ForumID` int(11) NOT NULL,
  `PostID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Student`
--

CREATE TABLE `Student` (
  `UserID` int(11) NOT NULL,
  `Major` varchar(50) NOT NULL,
  `GraduationDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Subscribe`
--

CREATE TABLE `Subscribe` (
  `UserID` int(11) NOT NULL,
  `ClubID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `UnderGraduate`
--

CREATE TABLE `UnderGraduate` (
  `UserID` int(11) NOT NULL,
  `YearLevel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `UserID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `UserName` varchar(80) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Workshop`
--

CREATE TABLE `Workshop` (
  `EventID` int(11) NOT NULL,
  `Topic` varchar(100) NOT NULL,
  `Presenter` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Becomes`
--
ALTER TABLE `Becomes`
  ADD KEY `UserID` (`UserID`),
  ADD KEY `ClubFacultyID` (`ClubFacultyID`);

--
-- Indexes for table `Club`
--
ALTER TABLE `Club`
  ADD PRIMARY KEY (`ClubID`);

--
-- Indexes for table `ClubFaculty`
--
ALTER TABLE `ClubFaculty`
  ADD PRIMARY KEY (`ClubFacultyID`);

--
-- Indexes for table `ClubLeaders`
--
ALTER TABLE `ClubLeaders`
  ADD KEY `ClubFacultyID` (`ClubFacultyID`);

--
-- Indexes for table `ClubOrganizers`
--
ALTER TABLE `ClubOrganizers`
  ADD KEY `ClubFacultyID` (`ClubFacultyID`);

--
-- Indexes for table `CommunityService`
--
ALTER TABLE `CommunityService`
  ADD KEY `EventID` (`EventID`);

--
-- Indexes for table `DegreeProgram`
--
ALTER TABLE `DegreeProgram`
  ADD PRIMARY KEY (`DegreeID`);

--
-- Indexes for table `Departments`
--
ALTER TABLE `Departments`
  ADD PRIMARY KEY (`DepartmentID`);

--
-- Indexes for table `DiscussionForum`
--
ALTER TABLE `DiscussionForum`
  ADD PRIMARY KEY (`ForumID`);

--
-- Indexes for table `Employee`
--
ALTER TABLE `Employee`
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `Establishes`
--
ALTER TABLE `Establishes`
  ADD KEY `ClubID` (`ClubID`),
  ADD KEY `ForumID` (`ForumID`);

--
-- Indexes for table `Event`
--
ALTER TABLE `Event`
  ADD PRIMARY KEY (`EventID`);

--
-- Indexes for table `EventClubOrganizes`
--
ALTER TABLE `EventClubOrganizes`
  ADD KEY `EventID` (`EventID`),
  ADD KEY `ClubID` (`ClubID`);

--
-- Indexes for table `Faculty`
--
ALTER TABLE `Faculty`
  ADD KEY `DepartmentID` (`DepartmentID`),
  ADD KEY `Faculty_ibfk_1` (`UserID`);

--
-- Indexes for table `Graduate`
--
ALTER TABLE `Graduate`
  ADD KEY `DegreeID` (`DegreeID`),
  ADD KEY `Graduate_ibfk_3` (`UserID`);

--
-- Indexes for table `Hosts`
--
ALTER TABLE `Hosts`
  ADD KEY `ClubID` (`ClubID`),
  ADD KEY `ClubFacultyID` (`ClubFacultyID`);

--
-- Indexes for table `Make`
--
ALTER TABLE `Make`
  ADD KEY `UserID` (`UserID`),
  ADD KEY `PostID` (`PostID`);

--
-- Indexes for table `Organizes`
--
ALTER TABLE `Organizes`
  ADD KEY `ClubID` (`ClubID`),
  ADD KEY `EventID` (`EventID`);

--
-- Indexes for table `Positions`
--
ALTER TABLE `Positions`
  ADD PRIMARY KEY (`PositionID`);

--
-- Indexes for table `Post`
--
ALTER TABLE `Post`
  ADD PRIMARY KEY (`PostID`);

--
-- Indexes for table `Seminar`
--
ALTER TABLE `Seminar`
  ADD KEY `fk_seminar_event` (`EventID`);

--
-- Indexes for table `Social`
--
ALTER TABLE `Social`
  ADD KEY `EventID` (`EventID`);

--
-- Indexes for table `Staff`
--
ALTER TABLE `Staff`
  ADD KEY `PositionID` (`PositionID`),
  ADD KEY `Staff_ibfk_1` (`UserID`);

--
-- Indexes for table `Stores`
--
ALTER TABLE `Stores`
  ADD KEY `ForumID` (`ForumID`),
  ADD KEY `PostID` (`PostID`);

--
-- Indexes for table `Student`
--
ALTER TABLE `Student`
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `Subscribe`
--
ALTER TABLE `Subscribe`
  ADD KEY `UserID` (`UserID`),
  ADD KEY `ClubID` (`ClubID`);

--
-- Indexes for table `UnderGraduate`
--
ALTER TABLE `UnderGraduate`
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`UserID`);

--
-- Indexes for table `Workshop`
--
ALTER TABLE `Workshop`
  ADD KEY `fk_workshop_event` (`EventID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Club`
--
ALTER TABLE `Club`
  MODIFY `ClubID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ClubFaculty`
--
ALTER TABLE `ClubFaculty`
  MODIFY `ClubFacultyID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `DegreeProgram`
--
ALTER TABLE `DegreeProgram`
  MODIFY `DegreeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Departments`
--
ALTER TABLE `Departments`
  MODIFY `DepartmentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `DiscussionForum`
--
ALTER TABLE `DiscussionForum`
  MODIFY `ForumID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Event`
--
ALTER TABLE `Event`
  MODIFY `EventID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Positions`
--
ALTER TABLE `Positions`
  MODIFY `PositionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Post`
--
ALTER TABLE `Post`
  MODIFY `PostID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Becomes`
--
ALTER TABLE `Becomes`
  ADD CONSTRAINT `Becomes_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Becomes_ibfk_2` FOREIGN KEY (`ClubFacultyID`) REFERENCES `ClubFaculty` (`ClubFacultyID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ClubLeaders`
--
ALTER TABLE `ClubLeaders`
  ADD CONSTRAINT `ClubLeaders_ibfk_1` FOREIGN KEY (`ClubFacultyID`) REFERENCES `ClubFaculty` (`ClubFacultyID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ClubOrganizers`
--
ALTER TABLE `ClubOrganizers`
  ADD CONSTRAINT `ClubOrganizers_ibfk_1` FOREIGN KEY (`ClubFacultyID`) REFERENCES `ClubFaculty` (`ClubFacultyID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `CommunityService`
--
ALTER TABLE `CommunityService`
  ADD CONSTRAINT `CommunityService_ibfk_1` FOREIGN KEY (`EventID`) REFERENCES `Event` (`EventID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Employee`
--
ALTER TABLE `Employee`
  ADD CONSTRAINT `Employee_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Establishes`
--
ALTER TABLE `Establishes`
  ADD CONSTRAINT `Establishes_ibfk_1` FOREIGN KEY (`ClubID`) REFERENCES `Club` (`ClubID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Establishes_ibfk_2` FOREIGN KEY (`ForumID`) REFERENCES `DiscussionForum` (`ForumID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `EventClubOrganizes`
--
ALTER TABLE `EventClubOrganizes`
  ADD CONSTRAINT `EventClubOrganizes_ibfk_1` FOREIGN KEY (`EventID`) REFERENCES `Event` (`EventID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `EventClubOrganizes_ibfk_2` FOREIGN KEY (`ClubID`) REFERENCES `Club` (`ClubID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Faculty`
--
ALTER TABLE `Faculty`
  ADD CONSTRAINT `Faculty_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Faculty_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `Departments` (`DepartmentID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Graduate`
--
ALTER TABLE `Graduate`
  ADD CONSTRAINT `Graduate_ibfk_2` FOREIGN KEY (`DegreeID`) REFERENCES `DegreeProgram` (`DegreeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Graduate_ibfk_3` FOREIGN KEY (`UserID`) REFERENCES `Student` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Hosts`
--
ALTER TABLE `Hosts`
  ADD CONSTRAINT `Hosts_ibfk_1` FOREIGN KEY (`ClubID`) REFERENCES `Club` (`ClubID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Hosts_ibfk_2` FOREIGN KEY (`ClubFacultyID`) REFERENCES `ClubFaculty` (`ClubFacultyID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Make`
--
ALTER TABLE `Make`
  ADD CONSTRAINT `Make_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Make_ibfk_2` FOREIGN KEY (`PostID`) REFERENCES `Post` (`PostID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Organizes`
--
ALTER TABLE `Organizes`
  ADD CONSTRAINT `Organizes_ibfk_1` FOREIGN KEY (`ClubID`) REFERENCES `ClubFaculty` (`ClubFacultyID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Organizes_ibfk_2` FOREIGN KEY (`EventID`) REFERENCES `Event` (`EventID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Seminar`
--
ALTER TABLE `Seminar`
  ADD CONSTRAINT `fk_seminar_event` FOREIGN KEY (`EventID`) REFERENCES `Event` (`EventID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Social`
--
ALTER TABLE `Social`
  ADD CONSTRAINT `Social_ibfk_1` FOREIGN KEY (`EventID`) REFERENCES `Event` (`EventID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Staff`
--
ALTER TABLE `Staff`
  ADD CONSTRAINT `Staff_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Staff_ibfk_2` FOREIGN KEY (`PositionID`) REFERENCES `Positions` (`PositionID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Stores`
--
ALTER TABLE `Stores`
  ADD CONSTRAINT `Stores_ibfk_1` FOREIGN KEY (`ForumID`) REFERENCES `DiscussionForum` (`ForumID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Stores_ibfk_2` FOREIGN KEY (`PostID`) REFERENCES `Post` (`PostID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Student`
--
ALTER TABLE `Student`
  ADD CONSTRAINT `Student_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Subscribe`
--
ALTER TABLE `Subscribe`
  ADD CONSTRAINT `Subscribe_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Subscribe_ibfk_2` FOREIGN KEY (`ClubID`) REFERENCES `Club` (`ClubID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `UnderGraduate`
--
ALTER TABLE `UnderGraduate`
  ADD CONSTRAINT `UnderGraduate_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Student` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Workshop`
--
ALTER TABLE `Workshop`
  ADD CONSTRAINT `fk_workshop_event` FOREIGN KEY (`EventID`) REFERENCES `Event` (`EventID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
