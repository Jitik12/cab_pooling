from pydantic import BaseModel
from typing import Literal


class Register_NotVerified(BaseModel):
    """
    We are going to use google auth so we are not taking any password here
    - User google login
    - Then at success send the email to the backend to save the user but is still unverified
    -
    """
    email: str


class User(BaseModel):
    """
    This is the master user model
    Use this at -
    - profile creation (tell me if we are using non binary genders )
    """
    name: str
    email: str
    college: str
    age: int
    gender: Literal['M', 'F']


