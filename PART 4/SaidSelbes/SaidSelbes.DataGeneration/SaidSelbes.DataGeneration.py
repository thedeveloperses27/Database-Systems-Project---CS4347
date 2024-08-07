# %%
#!/usr/bin/env python
import time
import os
import mysql.connector
from mysql.connector import Error
from faker import Faker
import json
from datetime import date
import random
import datetime

# %%
'''settings'''
Faker.seed(11122233)
os.environ["DB_USER_NAME"] = "root"
os.environ["DB_USER_PASSWORD"] = ""
os.environ["DB_NAME"] = "SaidNew"
os.environ["DB_HOST"] = "localhost"
mysql_path = "/opt/lampp/bin/mysql"
current_path = os.environ.get('PATH','')
os.environ["PATH"] = f"{mysql_path}:{current_path}"

db_host = os.environ.get('DB_HOST')
db_name = os.environ.get('DB_NAME')
db_user = os.environ.get('DB_USER_NAME')
db_pass = os.environ.get('DB_USER_PASSWORD')

fake = Faker()

# %%
'''Read json files from disk'''

def read_json_from_file(file_path):
    try:
        with open(file_path, 'r') as file:
            posts = json.load(file)
        return posts
    except FileNotFoundError:
        print(f"File '{file_path}' not found.")
        return None
    except json.JSONDecodeError:
        print(f"Error decoding JSON from file '{file_path}'.")
        return None

# %%
def insert_degree_programs(connection, cursor):
    degree_programs = [
        ('Computer Science',),
        ('Electrical Engineering',),
        ('Mechanical Engineering',),
        ('Biomedical Engineering',),
        ('Civil Engineering',),
        ('Chemical Engineering',),
        ('Physics',),
        ('Mathematics',),
        ('Biology',),
        ('Psychology',),
        ('English Literature',),
        ('History',),
        ('Economics',),
        ('Political Science',),
        ('Sociology',),
        ('Business Administration',),
        ('Health Sciences',),
        ('Environmental Science',),
        ('Art History',),
        ('Music Education',)
    ]

    try:
        if connection.is_connected():
            # Insert degree programs into the DegreePrograms table
            for program in degree_programs:
                query = "INSERT INTO DegreeProgram (Name) VALUES (%s)"
                cursor.execute(query, (program[0],))
            connection.commit()
            print(cursor.rowcount, "Records inserted successfully into DegreePrograms table")

    except Error as e:
        print("Error while inserting degree programs:", e)

# %%
# Positions and departments data
def insert_positions_departments(connection, cursor):
    positions = {
        'Registrar': 'Responsible for student records, registration, and academic policies',
        'Admissions Officer': 'Handles the admissions process for prospective students',
        'Finance Manager': 'Manages financial operations and budgets',
        'Human Resources Coordinator': 'Handles HR functions such as hiring, benefits, and employee relations',
        'Office Administrator': 'Manages administrative tasks and office operations',
        'Academic Advisor': 'Assists students with academic planning and course selection',
        'Facilities Manager': 'Oversees maintenance and operations of campus facilities',
        'IT Director': 'Manages IT department and technology infrastructure',
        'Financial Aid Director': 'Oversees financial aid programs and services',
        'Career Services Director': 'Directs career services programs and initiatives'
    }

    departments = {
        'Administration': 'Responsible for campus administration and management',
        'Admissions': 'Handles student admissions and enrollment processes',
        'Finance': 'Manages financial matters and budgets for the institution',
        'Human Resources': 'Manages personnel and employee-related matters',
        'Academic Affairs': 'Oversees academic programs, curriculum, and policies',
        'Facilities Management': 'Responsible for maintenance and operations of campus facilities',
        'Information Technology': 'Manages campus IT infrastructure and services',
        'Financial Aid': 'Administers financial aid programs and services for students',
        'Career Services': 'Provides career counseling and job placement services to students',
        'Student Affairs': 'Responsible for student services and campus life outside the classroom'
    }


    # Insert data into Positions table
    for position, description in positions.items():
        query = "INSERT INTO Positions (Name, Description) VALUES (%s, %s)"
        cursor.execute(query, (position, description))
        connection.commit()
    print("Inserted position:")

    # Insert data into Departments table
    for department, description in departments.items():
        query = "INSERT INTO Departments (Name, Description) VALUES (%s, %s)"
        cursor.execute(query, (department, description))
        connection.commit()
    print("Inserted departments:")



# %%
'''Insert Users into the User Table'''
# Function to generate users with Faker
def generate_users(connection, cursor, num_users=300):
    fake = Faker()
    users = []
    for _ in range(num_users):
        name = fake.name()
        username = fake.user_name()
        password = fake.password(length=10, special_chars=True, digits=True, upper_case=True, lower_case=True)
        email = fake.email()
        users.append((name, username, password, email))
        # Insert users into Users table
    query = "INSERT INTO User (Name, UserName, Password, Email) VALUES (%s, %s, %s, %s)"
    cursor.executemany(query, users)
    connection.commit()
    print(cursor.rowcount, "Records inserted successfully into Users table")

# %%
'''Subscribe users'''

# Function to retrieve user and club IDs from the database
def get_user_ids(cursor):
    cursor.execute("SELECT UserID FROM User")
    user_ids = [row[0] for row in cursor.fetchall()]
    return user_ids
# Function to get list of clubs
def get_club_ids(cursor):
    cursor.execute("SELECT ClubID FROM Club")
    club_ids = [row[0] for row in cursor.fetchall()]
    
    return club_ids

# Function to retrieve existing subscriptions from the database
def get_existing_subscriptions(cursor):
    cursor.execute("SELECT UserID, ClubID FROM Subscribe")
    existing_subscriptions = set(cursor.fetchall())
    return existing_subscriptions

# Function to randomly subscribe users to clubs
def randomly_subscribe(connection, cursor, user_ids, club_ids, num_subscriptions):
    existing_subscriptions = get_existing_subscriptions(cursor)
    subscriptions = []

    # Keep track of subscriptions made for each user
    user_subscriptions = {user_id: set() for user_id in user_ids}

    for _ in range(num_subscriptions):
        user_id = random.choice(user_ids)
        club_id = random.choice(club_ids)

        # Check if the user is already subscribed to the club
        if (user_id, club_id) not in existing_subscriptions and club_id not in user_subscriptions[user_id]:
            subscriptions.append((user_id, club_id))
            user_subscriptions[user_id].add(club_id)

    # Insert subscriptions into Subscribe table
    query = "INSERT INTO Subscribe (UserID, ClubID) VALUES (%s, %s)"
    cursor.executemany(query, subscriptions)
    print(cursor.rowcount, "Records inserted successfully into Subscribe table")
    connection.commit()


# %%
'''split students and employees'''
def split_students_employees(connection, cursor): 
    cursor.execute("SELECT UserID from User")   
    users = cursor.fetchall()
    # Calculate the number of users to be students and employees
    num_students = int(0.75 * len(users))
    # Separate users into students and employees based on some condition
    students = users[:num_students]
    employees = users[num_students:]
    # Insert student records into the Student table
    for student in students:
        # Generate a random graduation date within 4 years from now
        graduation_date = fake.date_between(start_date='today', end_date='+4y')
        graduation_date_str = graduation_date.strftime('%Y-%m-%d')
        query = "INSERT INTO Student (UserID, Major, GraduationDate) VALUES (%s, %s, %s)"
        cursor.execute(query, (student[0], 'Major', graduation_date_str))  
    connection.commit()
    print("Records inserted successfully into Student table")

    # Insert employee records into the Employee table
    for employee in employees:
        query = "INSERT INTO Employee (UserID, Salary) VALUES (%s, %s)"
        salary = fake.random_int(min=30000, max=100000)
        cursor.execute(query, (employee[0], salary))  
    connection.commit()
    print("Records inserted successfully into Employee table")

# %%
'''insert employee staff'''
def insert_employee_staff(connection, cursor):

    if connection.is_connected():
        # Retrieve all employee IDs from the Employee table
        cursor.execute("SELECT UserID FROM Employee")
        employee_ids = [row[0] for row in cursor.fetchall()]

        # Retrieve all position IDs from the Positions table
        cursor.execute("SELECT PositionID FROM Positions")
        position_ids = [row[0] for row in cursor.fetchall()]

        # Retrieve all department IDs from the Departments table
        cursor.execute("SELECT DepartmentID FROM Departments")
        department_ids = [row[0] for row in cursor.fetchall()]

        # Connect employees to positions in departments in the Staff table and in the Faculty table
        for employee_id in employee_ids:
            position_id = random.choice(position_ids)
            department_id = random.choice(department_ids)
            
            # Check if the employee is already in either the Staff or Faculty table
            cursor.execute("SELECT * FROM Staff WHERE UserID = %s", (employee_id,))
            is_staff = cursor.fetchone()
            cursor.execute("SELECT * FROM Faculty WHERE UserID = %s", (employee_id,))
            is_faculty = cursor.fetchone()

            # If the employee is not in both tables, insert them into one of the tables
            if not is_staff and not is_faculty:
                if random.choice([True, False]):  # Randomly decide whether to insert into Staff or Faculty
                    query = "INSERT INTO Staff (UserID, PositionID) VALUES (%s, %s)"
                    cursor.execute(query, (employee_id, position_id))
                    connection.commit()
                    
                else:
                    query = "INSERT INTO Faculty (UserID, DepartmentID) VALUES (%s, %s)"
                    cursor.execute(query, (employee_id, department_id))
                    connection.commit()
        print(f"Employees inserted into Faculty and Staff table")



# %%
'''insert graduate undergraduate'''
def split_graduates_undergraduates(connection, cursor, undergraduate_ratio=0.65):

    if connection.is_connected():
        # Retrieve list of students from User table
        cursor.execute("SELECT UserID FROM Student")
        students = [row[0] for row in cursor.fetchall()]

        # Split students into undergraduates and graduates based on the provided ratio
        num_undergraduates = int(undergraduate_ratio * len(students))
        undergraduates = random.sample(students, num_undergraduates)
        graduates = [student for student in students if student not in undergraduates]

        # Retrieve list of degree programs from DegreeProgram table
        cursor.execute("SELECT DegreeID FROM DegreeProgram")
        degree_programs = [row[0] for row in cursor.fetchall()]

        # Connect students to degree programs
        for student in undergraduates:
            degree_id = random.choice(degree_programs)
            year_level = random.randint(1, 4)  # Assuming 4-year undergraduate program
            cursor.execute("INSERT INTO UnderGraduate (UserID, YearLevel) VALUES (%s, %s)",
                            (student, year_level))
        connection.commit()
        print("Undergraduates connected to degree program successfully")

        for student in graduates:
            degree_id = random.choice(degree_programs)
            cursor.execute("INSERT INTO Graduate (UserID, DegreeID) VALUES (%s, %s)",
                            (student, degree_id))
        connection.commit()
        print("Graduates connected to degree program successfully")


# %%
'''populate Club information into Clubs table'''
def populate_clubs(connection, cursor):
    # Read data from JSON file
    file_path = "club.json"  
    clubs_data = read_json_from_file(file_path)
    for club in clubs_data['clubs']:
        name = club['Name']
        type = club['Type']
        founded_date = club['FoundedDate']
        sql = "INSERT INTO Club (Name, Type, FoundedDate) VALUES (%s, %s, %s)"
        val = (name, type, founded_date)
        cursor.execute(sql, val)
        connection.commit()
    print("Clubs data inserted successfully.")

# %%
'''Insert data into DiscussionForum table and establish relationships'''
def populate_discussion_forums(connection, cursor):
    file_path = "forum.json"  
    data = read_json_from_file(file_path)

    for club_name, forum_data in data['forums'].items():
        # Insert into DiscussionForum table
        title = forum_data['Title']
        description = forum_data['Description']
        created_date = forum_data['CreatedDate']
        forum_insert_query = "INSERT INTO DiscussionForum (Title, Description, CreatedDate) VALUES (%s, %s, %s)"
        forum_values = (title, description, created_date)
        cursor.execute(forum_insert_query, forum_values)
        connection.commit()

        # Retrieve ForumID
        forum_id = cursor.lastrowid

        # Retrieve ClubID
        club_query = "SELECT ClubID FROM Club WHERE Name = %s"
        club_values = (club_name,)
        cursor.execute(club_query, club_values)
        club_id = cursor.fetchone()[0]

        # Establish relationship in Establishes table
        establishes_insert_query = "INSERT INTO Establishes (ClubID, ForumID) VALUES (%s, %s)"
        establishes_values = (club_id, forum_id)
        cursor.execute(establishes_insert_query, establishes_values)
        connection.commit()
    print("Forums and Establishes Inserted Successfully")

# %%
'''Function to populate events and seminars'''
def populate_events(connection, cursor):
    # Read data from JSON file
    file_path = "events.json"  
    data = read_json_from_file(file_path)
    try:
        for club in data['clubs']:
            club_name = club['ClubName']
            for event in club['events']:
                event_name = event['EventName']
                event_type = event['EventType']
                event_date = event['Date']
                start_time = event['StartTime']
                end_time = event['EndTime']
                location = event['Location']
                description = event['Description']
                seminar_topic = None
                seminar_speaker = None
                
                if 'Seminar' in event:
                    seminar_topic = event['Seminar']['Topic']
                    seminar_speaker = event['Seminar']['Speaker']
                elif 'Workshop' in event:
                    workshop_topic = event['Workshop']['Topic']
                    workshop_presenter = event['Workshop']['Presenter']
                elif 'CommunityService' in event:
                    community_service = event['CommunityService']['Service']
                elif 'Social' in event:
                    social_activity = event['Social']['Activity']
                    
                # Insert event into the events table
                event_query = "INSERT INTO Event (EventName, EventType, Date, StartTime, EndTime, Location, Description) VALUES (%s, %s, %s, %s, %s, %s, %s)"
                event_values = (event_name, event_type, event_date, start_time, end_time, location, description)
                cursor.execute(event_query, event_values)
                
                # Get the EventID of the inserted event
                event_id = cursor.lastrowid
                
                if event_type == 'Seminar':
                    # Insert seminar information into the seminars table
                    seminar_query = "INSERT INTO Seminar (EventID, Topic, Speaker) VALUES (%s, %s, %s)"
                    seminar_values = (event_id, seminar_topic[:90], seminar_speaker)
                    cursor.execute(seminar_query, seminar_values)
                elif event_type == 'Social':
                    #Insert social information into social table
                    social_query = "INSERT INTO Social (EventID, Activity) VALUES (%s, %s)"
                    social_values = (event_id, social_activity)
                    cursor.execute(social_query, social_values)
                elif event_type == 'Community Service':
                    #Insert Community service into community service table
                    community_query = "INSERT INTO CommunityService (EventID, Service) VALUES (%s, %s)"
                    community_values = (event_id, community_service)
                    cursor.execute(community_query, community_values)
                elif event_type == "Workshop":
                    #Insert Workshop information into workshop table
                    workshop_query = "INSERT INTO Workshop (EventID, Topic, Presenter) VALUES (%s, %s, %s)"
                    workshop_values = (event_id, workshop_topic, workshop_presenter)
                    cursor.execute(workshop_query, workshop_values)
                
                club_id_sql = "SELECT ClubID FROM Club WHERE Name = %s"
                cursor.execute(club_id_sql, (club_name,))
                club_id = cursor.fetchone()[0]
                
                organizes_sql = "INSERT INTO Organizes (EventID, ClubID) VALUES (%s, %s)"
                organizes_vals = (event_id, club_id)
                cursor.execute(organizes_sql, organizes_vals)                
                    
                    
        connection.commit()
        print("Events and seminars populated successfully.")

    except Error as e:
        print("Error while populating events and seminars:", e)
        connection.rollback()




# %%
'''Assign Students and employees Leaders and organizers '''

def select_club_ids(cursor):
    cursor.execute("SELECT ClubID FROM Club")
    return [row[0] for row in cursor.fetchall()]

def select_users_by_club(cursor, club_id):
    cursor.execute("SELECT UserID FROM Subscribe WHERE ClubID = %s", (club_id,))
    return [row[0] for row in cursor.fetchall()]

def select_students_by_club(cursor, users):
    cursor.execute("SELECT UserID FROM Student WHERE UserID IN ({})".format(','.join(map(str, users))))
    return [row[0] for row in cursor.fetchall()]

def select_employees_by_club(cursor, users):
    cursor.execute("SELECT UserID FROM Employee WHERE UserID IN ({})".format(','.join(map(str, users))))
    return [row[0] for row in cursor.fetchall()]

def randomly_choose_users(users, count):
    return random.sample(users, min(count, len(users)))

def insert_into_becomes(cursor, user_id, clubfaculty_id):
    query = "INSERT INTO Becomes (UserID, ClubFacultyID) VALUES (%s, %s)"
    cursor.execute(query, (user_id, clubfaculty_id))

def insert_into_club_faculty(cursor, role, join_date):
    query = "INSERT INTO ClubFaculty (Role, JoinDate) VALUES (%s, %s)"
    cursor.execute(query, (role, join_date))

def insert_into_club_leaders_or_organizers(cursor, last_inserted_id, role):
    if role == 'leader':
        table = 'ClubLeaders'
        query = f"INSERT INTO {table} (ClubFacultyID, LeadershipExperience) VALUES (%s, %s)"
        cursor.execute(query, (last_inserted_id, random.randint(1,10)))
        
    else:
        table = 'ClubOrganizers'
        query = f"INSERT INTO {table} (ClubFacultyID, OrganizingExperience, Vision) VALUES (%s, %s, %s)"
        cursor.execute(query, (last_inserted_id, random.randint(1,10), fake.text()))

def insert_into_hosts(cursor, club_id, club_faculty_id):
    query = "INSERT INTO Hosts (ClubID, ClubFacultyID) VALUES (%s, %s)"
    cursor.execute(query, (club_id, club_faculty_id))



def populate_club_faculty(connection, cursor):
    
    if connection and cursor:
    
        # Step 1: Retrieve club IDs
        club_ids = select_club_ids(cursor)

        for club_id in club_ids:
            # Step 2a: Select users who are joined to the club
            users = select_users_by_club(cursor, club_id)

            # Step 2b: Select students from these users per club
            students = select_students_by_club(cursor, users)

            # Step 2c: Select employees from these users per club
            employees = select_employees_by_club(cursor, users)

            # Step 2d: Randomly choose 5 students and 5 employees
            chosen_students = randomly_choose_users(students, 5)
            chosen_employees = randomly_choose_users(employees, 5)

            # Step 2e: Insert chosen students and employees into ClubFaculty table
            for student_id in chosen_students:
                role = 'leader' if random.random() < 0.5 else 'organizer'
                join_date = fake.date_this_year()
                insert_into_club_faculty(cursor, role, join_date)
                cursor.execute("SELECT LAST_INSERT_ID()")
                last_inserted_id = cursor.fetchone()[0]
                insert_into_becomes(cursor, student_id, last_inserted_id)
                insert_into_club_leaders_or_organizers(cursor, last_inserted_id, role)
                insert_into_hosts(cursor, club_id, last_inserted_id)
            for employee_id in chosen_employees:
                role = 'leader' if random.random() < 0.5 else 'organizer'
                join_date = fake.date_this_year()
                insert_into_club_faculty(cursor, role, join_date)
                cursor.execute("SELECT LAST_INSERT_ID()")
                last_inserted_id = cursor.fetchone()[0]
                insert_into_becomes(cursor, employee_id, last_inserted_id)
                insert_into_club_leaders_or_organizers(cursor, last_inserted_id, role)
                insert_into_hosts(cursor, club_id, last_inserted_id)

        connection.commit()





# %%
'''Create Posts to Forums and Link them to clubs users belong to '''

def create_post(cursor, user_id, forum_id):
    content = fake.paragraph(nb_sentences=3)
    posted_by = fake.user_name()
    posted_date = fake.date_time_this_decade()
    query = "INSERT INTO Post (Content, PostedBy, PostedDate) VALUES (%s, %s, %s)"
    cursor.execute(query, (content, posted_by, posted_date))
    post_id = cursor.lastrowid
    query = "INSERT INTO Make (UserID, PostID) VALUES (%s, %s)"
    cursor.execute(query, (user_id, post_id))
    query = "INSERT INTO Stores (ForumID, PostID) VALUES (%s, %s)"
    cursor.execute(query, (forum_id, post_id))

def create_posts_for_clubs(connection,cursor):
    # Retrieve list of clubs
    cursor.execute("SELECT ClubID FROM Club")
    clubs = cursor.fetchall()
    for club_id in clubs:
        club_id = club_id[0]
        # Retrieve users subscribed to the club
        cursor.execute("SELECT UserID FROM Subscribe WHERE ClubID = %s", (club_id,))
        users = cursor.fetchall()
        # Randomly select users to create posts
        num_posts = random.randint(1, min(len(users), 100))  # Limiting to a maximum of 10 posts per club
        users_to_post = random.sample(users, num_posts)
        # Retrieve the forum linked to the club
        cursor.execute("SELECT ForumID FROM Establishes WHERE ClubID = %s", (club_id,))
        forum_id = cursor.fetchone()[0]
        # Create posts for selected users
        for user_id in users_to_post:
            user_id = user_id[0]
            create_post(cursor, user_id, forum_id)
            connection.commit()


# %%
# Main driver
try:
    connection = mysql.connector.connect(host=db_host, database=db_name,
                                         user=db_user, password=db_pass)

    if connection.is_connected():
        cursor = connection.cursor()
        #insert degree programs
        insert_degree_programs(connection, cursor)
        #insert positions and departments
        insert_positions_departments(connection, cursor)
        #insert users
        generate_users(connection, cursor, num_users=300)
        #split students and employees
        split_students_employees(connection, cursor)
        #split graduates undergraduates
        split_graduates_undergraduates(connection, cursor)
        #split staff and faculty
        insert_employee_staff(connection, cursor)
        #insert clubs
        populate_clubs(connection, cursor)
        #insert forums
        populate_discussion_forums(connection, cursor)
        #insert events
        populate_events(connection, cursor)
        
        # #subscribe users
        user_ids = get_user_ids(cursor)
        club_ids = get_club_ids(cursor)
        # # #Number of subscriptions to generate
        num_subscriptions = 300
        # # #Randomly subscribe users to clubs
        randomly_subscribe(connection, cursor, user_ids, club_ids, num_subscriptions)
        #insert employees and students
        populate_club_faculty(connection, cursor)
        #insert posts and link to make table
        create_posts_for_clubs(connection,cursor)

except Error as e:
    print("Error while connecting to MySQL:", e)

finally:
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL connection is closed.")

# %%
'''Truncate All tables

'''


def truncate_query(connection, cursor, sql, statement):
    print(f"\n{statement}\n")
    try:

        cursor.execute(sql)
        records = cursor.fetchall()
        if records:
            cursor.execute("SET FOREIGN_KEY_CHECKS=0")
            # Process the retrieved data
            for record in records:
                cursor.execute(f"TRUNCATE TABLE {record[0]}")
                connection.commit()
                print("Truncating ", record[0])
            print("All Tables Truncated")
        else:
            print("No records found.")
        # Re-enable foreign key checks
        cursor.execute("SET FOREIGN_KEY_CHECKS=1")
    except Error as e:
        print("Error executing MySQL query:", e)
        return None
try:
    # Establish connection to the MySQL database
    connection = mysql.connector.connect(host=db_host, database=db_name,
                                         user=db_user, password=db_pass)

    if connection.is_connected():
        cursor = connection.cursor()
        # Call the function to execute the query and fetch results
        sql = "show tables"
        truncate_query(connection, cursor, sql, "Truncating Tables")


except Error as e:
    print("Error connecting to MySQL:", e)
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("\nMSQL closed.")    

finally:
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("\nMSQL closed.")

# %%
import mysql.connector

def count_records_in_tables(cursor):
    cursor.execute("SELECT TABLE_NAME FROM information_schema.tables WHERE table_schema = DATABASE()")
    tables = cursor.fetchall()
    total = 0
    for table in tables:
        table_name = table[0]
        cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
        count = cursor.fetchone()[0]
        if count > 0:
            print(f"Table {table_name} has {count} records")
            total+=1
    print("Total ", len(tables), "filled ", total )

try:
    connection = mysql.connector.connect(host=db_host, database=db_name,
                                         user=db_user, password=db_pass)
    if connection.is_connected():
        cursor = connection.cursor()
        count_records_in_tables(cursor)

except mysql.connector.Error as error:
    print("Error while connecting to MySQL:", error)

finally:
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL connection is closed")



