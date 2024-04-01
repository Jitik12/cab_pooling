from . import models, database

async def login(data: models.Register_NotVerified):
    conn, cursor = database.make_db()
    """
    check if the user is registered, if not return the message and the email
    check if the user has already created a profile, if not then return the message and the email
    if both yes then return the data
    """
    query = f"SELECT * FROM users WHERE email = '{data.email}'"
    cursor.execute(query)
    result = cursor.fetchone()
    if result == []:
        return {
            "message": "User not registered",
            "email": data.email
        }
    elif result != [] and not result[0][1]:
        data = {
            'message': "User not verified, please create profile",
            'email': data.email,
            'verified': False
        }
    else:
        query = f"""SELECT * FROM profile WHERE email = '{data.email}'"""
        cursor.execute(query)
        user_info = cursor.fetchone()
        data = {
            'message': "Login Successful",
            "user_id": user_info[0][0],
            "name": user_info[0][1],
            "email": user_info[0][2],
            "college": user_info[0][3],
            "age": user_info[0][4],
            "gender": user_info[0][5]
        }

