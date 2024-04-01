from . import c_tasks, r_tasks, models


async def handle_register(data: models.Register_NotVerified):
    response = await c_tasks.create_user_not_verified(data)
    print(response.message)
    return response


async def handle_login(data: models.Register_NotVerified):
    response = await r_tasks.login(data)
    print(response.message)
    return response


async def handle_profile_create(data: models.User):
    response = await c_tasks.create_register(data)
    print(response.message)
    return response