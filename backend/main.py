from fastapi import FastAPI, Depends, UploadFile, Header
from fastapi.middleware.cors import CORSMiddleware
from tasks import models, tasks

app = FastAPI()
origins = ["*"] # added all the origins for now

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def read_root():
    print("Opened Server")
    return {"Hello": "World"}


@app.post("/register/")
async def register(data: models.Register_NotVerified):
    print("Handling register")
    res = tasks.handle_register(data)
    return data


@app.post("login/")
async def login(data: models.Register_NotVerified):
    print("Handling login")
    res = tasks.handle_login(data)
    return data


@app.post("/profile_create/")
async def profile_create(data: models.User):
    print("Handling profile create")
    res = tasks.handle_profile_create(data)
    return res

