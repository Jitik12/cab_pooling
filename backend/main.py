from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi import Depends
from stuff import tasks, models

app = FastAPI()

origins = ["http://localhost", "http://localhost:3000"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def read_root():
    return {"Hello": "World"}


@app.post("/register")
async def register(data: models.User_Register):
    res = await tasks.handle_register(data)
    return res


@app.post("/profile_create")
async def profile_create(data: models.User_Profile_Create):
    res = tasks.handle_profile_create(data)
    return {"Hello": "Profile Create"}



@app.post("/login_via_token")
async def login_via_token(data: models.User_Login_Token):
    res = await tasks.handle_login_via_token(data)
    return res

@app.post("/login")
async def login(data: models.User_Login):
    res = await tasks.handle_login(data)
    return res


@app.post("/register_pool_ride")
async def register_pool_ride(data: models.Pool_Ride_Register):
    res = await tasks.handle_pool_ride_register(data)
    return res


@app.post("/register_instant_cab")
async def register_instant_cab(data: models.Instant_Ride_Register):
    res = await tasks.handle_instant_ride_register(data)
    return res


@app.get("/driver_fetch_pools")
async def driver_pools():
    res = await tasks.driver_fetch_pool()
    return res


@app.post("/driver_accept_pool")
async def driver_accept_pool(data: models.Accept_Pool_Ride):
    res = await tasks.driver_accept_pool(data)
    return res

@app.get("/driver_fetch_instant")
async def driver_instant():
    res = await tasks.driver_fetch_instant()
    return res

@app.post("/driver_accept_instant")
async def driver_accept_instant(data: models.Accept_Instant_Ride):
    res = await tasks.driver_accept_instant(data)
    return res


@app.post("/specific_pool")
async def get_specific_pool(data: models.Specific_Pool):
    res = await tasks.handle_specific_pool(data)
    return res
