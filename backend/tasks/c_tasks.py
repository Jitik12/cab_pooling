from . import models, database
import random
"""
This is the file for the create functions
"""


async def create_user_not_verified(data: models.Register_NotVerified):
    conn, cursor = database.make_db()
    """
    - check if the User is already registered, if yes then return the user
    - else create the user and return the user
    """
    query = f"""select * from users_not_verified where email = '{data.email}'"""
    cursor.execute(query)
    result = cursor.fetchall()
    if len(result) > 0:
        if result[0][1]:
            data = {
                "message": "User has already been registered and verified.",
                "email": result[0][0],
                "verified": result[0][1]
            }
        else:
            data = {
                "message": "User has already been registered, but not verified yet.",
                "email": result[0][0],
                "verified": result[0][1]
            }
        return data
    else:
        query = f"""insert into users_not_verified values ('{data.email}', FALSE)"""
        cursor.execute(query)
        conn.commit()
        data = {
            "message": "New User has been registered, but not verified yet.",
            "email": data.email,
            "verified": False
        }
        return data


async def create_register(data: models.User):
    conn, cursor = database.make_db()
    """
    - check if the User is verified, if yes then return the user
    - check if the User is already registered, if yes then return the user
    - else create the user_id, insert the user and return the user along with the user_id
    """
    try:
        query = f"""select * from users_not_verified where email = '{data.email}'"""
        cursor.execute(query)
        result = cursor.fetchall()
        if len(result) > 0 and result[0][1]:
            query = f"""select * from users where email = '{data.email}'"""
            cursor.execute(query)
            result = cursor.fetchall()
            if len(result) > 0:
                data = {
                    "message": "Profile already exists.",
                    "name": result[0][0],
                    "email": result[0][1],
                    "college": result[0][2],
                    "age": result[0][3],
                    "gender": result[0][4]
                }
                return data
        elif len(result) > 0 and not result[0][1]:
            user_id = random.randint(100_000, 1_000_000)
            query = f"select user_id from users"
            cursor.execute(query)
            user_ids_data = cursor.fetchall()
            user_ids = []
            for id in user_ids:
                user_ids.append(id[0])
            while user_id in user_ids:
                user_id = random.randint(100_000, 1_000_000)
            query = f"""insert into users values ({user_id},'{data.name}', '{data.email}', '{data.college}', '{data.gender}', {data.age})"""
            cursor.execute(query)
            conn.commit()
            data = {
                "message": "New profile has been created successfully.",
                "user_id": user_id,
                "name": data.name,
                "email": data.email,
                "college": data.college,
                "age": data.age,
                "gender": data.gender,
            }
            return data
        else:
            return {
                "message": "User has not been registered yet."
            }
    except Exception as e:
        print(e)

