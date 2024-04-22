import random

from stuff import models, database
from .database import make_db
import hashlib
import secrets


async def get_cost_per_person(distance: int, cost_per_lit: int, numpeople: int, mileage: int):
    cost = float (distance * cost_per_lit * 1.33) / (mileage * numpeople)
    rounded_cost = round(cost, 0)
    return rounded_cost



async def handle_register(data: models.User_Register):
    conn, cursor = database.make_db()
    print("Hello")
    """
    Adding the inactive user to the database
    """
    query = f"""
    insert into registered_people values ('{data.email}', '{data.phone}', '{data.name}', '{data.photoURL}', TRUE)
    """
    cursor.execute(query)
    conn.commit()
    conn.close()
    return {
        'status': 200,
        'message': "Registration Successful",
    }


async def handle_profile_create(data: models.User_Profile_Create):
    conn, cursor = database.make_db()
    """
    Check if the user exists in the first table
    If not, then ask the user to register
    If yes, then add the user to the second table
    """
    check_query = f"""
    select * from <table> where email = '{data.email}'
    """
    cursor.execute(check_query)
    res = cursor.fetchall()
    if len(res) == 0:
        return {
            'message': "User does not exist. Please register first",
            'email': data.email,
            'status': None
        }
    elif len(res) > 1 & data.email == res[0][0] & res[0][1] == False:
        query = f"""
        insert into <table> values ('{data.name}', '{data.email}', '{data.age}')
        """
        cursor.execute(query)
        conn.commit()
        conn.close()
        return {
            'message': "Added user to the database",
            'email': data.email,
            'status': True
        }
    else:
        return {
            'message': "Profile already exists",
            'email': data.email,
            'status': True
        }


def generate_token(email):
    # Generate a token using email and a random salt
    salt = secrets.token_urlsafe(16)
    token_string = email + salt
    token = hashlib.sha256(token_string.encode()).hexdigest()
    return token


async def handle_login(data: models.User_Login):
    # Connect to the database
    conn, cursor = make_db()

    # Query to check if the user exists and is active
    query = f"SELECT * FROM registered_people WHERE email = '{data.email}'"
    cursor.execute(query)
    res = cursor.fetchall()

    if len(res) == 0:
        # User does not exist. Return an error message.
        return {
            'message': "User does not exist. Please register first",
            'status': 500,
        }
    elif len(res) > 1 or (data.email == res[0][0] and not res[0][4]):
        # More than one user found with the same email or user exists but is not active.
        return {
            'status': 500,
            'message': "User exists but is not active. Please register first",
        }
    else:
        # User exists and is active. Generate a token.
        token = generate_token(data.email)

        # Store the token in the database
        insert_query = f"INSERT INTO login_token VALUES ('{data.email}', '{token}')"
        cursor.execute(insert_query)
        conn.commit()
        conn.close()

        # Return the token to the user
        print(token)
        return {
            'message': "User exists",
            'email': data.email,
            'status': 200,
            'token': token,
        }


async def handle_login_via_token(data: models.User_Login_Token):
    # Connect to the database
    conn, cursor = make_db()

    # Query to check if the token exists
    query = f"SELECT * FROM login_token WHERE token = '{data.token}'"
    cursor.execute(query)
    res = cursor.fetchall()

    if len(res) == 0:
        # Token does not exist. Return an error message.
        return {
            'message': "Invalid token",
            'status': 404
        }
    else:
        # Token exists. Get the user details.
        email = res[0][0]
        user_query = f"SELECT * FROM registered_people WHERE email = '{email}'"
        cursor.execute(user_query)
        user_res = cursor.fetchall()

        # Return the user details
        return {
            'message': "User exists",
            'status': 200,
            'email': user_res[0][0],
            'phone': user_res[0][1],
            'name': user_res[0][2],
            'photoURL': user_res[0][3],
        }




async def handle_pool_ride_register(data: models.Pool_Ride_Register):
    conn, cursor = database.make_db()
    """
    Adding the incoming pool to the pool table    
    """
    # generate a unique pool_id
    pool_id = random.randint(1_000, 10_000)
    check_query = f"""
    select * from pool_applications where pool_id = '{pool_id}'
    """
    cursor.execute(check_query)
    result = cursor.fetchall()
    pool_ids = []
    for each in result:
        pool_ids.append(each[0])
    while pool_id in pool_ids:
        pool_id = random.randint(1_000, 10_000)
    query = f"""
    insert into pool_applications values ({pool_id}, '{data.email}', '{data.timeslot}', '{data.zone}', '{data.numpeople}', '{data.min}', '{data.max}', '{data.time}', '{data.date}', '{data.start}', '{data.destination}')
    """
    cursor.execute(query)
    conn.commit()
    conn.close()
    return {
        'message': "Added pool to the database",
    }


async def handle_instant_ride_register(data: models.Instant_Ride_Register):
    """
    Adding the incoming target to the instant ride register table
    """
    # make a unique instant_id
    instant_id = random.randint(1_000, 10_000)
    conn, cursor = database.make_db()
    check_query = f"""
    select * from instant_applications where instant_id = '{instant_id}'
    """
    cursor.execute(check_query)
    result = cursor.fetchall()
    instant_ids = []
    for each in result:
        instant_ids.append(each[0])
    while instant_id in instant_ids:
        instant_id = random.randint(1_000, 10_000)
    mileage = 10  # dummy
    distance = 10  # dummy
    cost_per_lit = 10  # dummy
    distance = 10  # dummy
    travel_time = 120  # dummy in minutes
    cost = await get_cost_per_person(distance, cost_per_lit, data.numpeople, mileage)
    conn, cursor = database.make_db()
    query = f"""
    insert into instant_applications values ({instant_id}, '{data.email}', '{data.time}', {data.numpeople}, '{data.start}', '{data.destination}', {cost}, {travel_time})
    """
    cursor.execute(query)
    conn.commit()
    conn.close()
    return {
        'message': "Added instant ride to the database",
        "email": data.email,
        'cost': cost,
        'travel_time': travel_time,
        'start': data.start,
        'destination': data.destination,
    }



async def driver_fetch_pool():
    """
    - fetch all the pools from active_pools table and send
    """
    conn, cursor = database.make_db()
    query = f"""
    select * from active_pools
    """
    cursor.execute(query)
    res = cursor.fetchall()
    result = []
    for each in res:
        strength = 0
        print(each)
        for i in [2, 3, 4, 5]:
            if each[i] != -1:
                strength += 1
        cost = await  get_cost_per_person(10, 10, strength, 10)*strength
        ride = {
            "master_pool_id": each[0],
            "strength":  strength,
            "cost": cost,
            "start": "IIT Hyderabad",
            "end": each[1]
        }
        result.append(ride)
    conn.close()
    return {
        'message': "Fetched all the pools",
        'pools': result
    }


async def driver_accept_pool(data: models.Accept_Pool_Ride):
    """
    Check if the pool exists
    - Add the driver email to the pool in the accept_pools table
    """
    conn, cursor = database.make_db()
    query = f"""
    select * from active_pools where master_pool_id = {data.master_pool_id}
    """
    cursor.execute(query)
    res = cursor.fetchall()
    if len(res) == 0:
        return {
            'message': "No such pool exists",
            'status': 404
        }
    insert_query = f"""
    insert into accept_pools values ({data.master_pool_id}, '{data.driver_email}')
    """
    cursor.execute(insert_query)
    conn.commit()
    conn.close()
    return {
        'message': "Accepted the pool",
        'status': 200,
        'pool': {
            'master_pool_id': res[0][0],
            'start': "IIT Hyderabad",
            'end': res[0][1],
            'strength': res[0][6],
            "cost": await get_cost_per_person(10, 10, res[0][6], 10)*res[0][6],
            "travel_time": 120
        }
    }

async def driver_fetch_instant():
    """
    Fetch all the instant rides
    """
    conn, cursor = database.make_db()
    query = f"""
    select * from instant_applications
    """
    cursor.execute(query)
    res = cursor.fetchall()
    result = []
    for each in res:
        user_data_query = f"""
        select * from registered_people where email = '{each[1]}'
        """
        cursor.execute(user_data_query)
        user_data = cursor.fetchall()
        ride = {
            'instant_id': each[0],
            'email': each[1],
            'name': user_data[0][2],
            'phone': user_data[0][1],
            'photoURL': user_data[0][3],
            'time': each[2],
            'numpeople': each[3],
            'start': each[4],
            'destination': each[5],
            'cost': each[6],
            'travel_time': each[7]
        }
        result.append(ride)
    conn.close()
    return {
        'message': "Fetched all the instant rides",
        'instant': result
    }

async def driver_accept_instant(data: models.Accept_Instant_Ride):
    """
    Accept the instant ride
    - get all the details of the instant ride
    - add it to the accept_instant table and add the driver email to the table from the data
    - then delete it from the main table
    """
    conn, cursor = database.make_db()
    query = f"""
    select * from instant_applications where instant_id = {data.instant_id}
    """
    print(query)
    cursor.execute(query)
    res = cursor.fetchall()
    if len(res) == 0:
        return {
            'message': "No such instant ride exists",
            'status': 404
        }
    ride = res[0]
    insert_query = f"""
    insert into accept_instant values ({data.instant_id}, '{data.driver_email}')
    """
    cursor.execute(insert_query)
    conn.commit()
    conn.close()
    return {
        'message': "Accepted the instant ride",
        'status': 200,
        "ride": {
            'instant_id': ride[0],
            'email': ride[1],
            'time': ride[2],
            'numpeople': ride[3],
            'start': ride[4],
            'destination': ride[5],
            'cost': ride[6],
            'travel_time': ride[7]
        }
    }




