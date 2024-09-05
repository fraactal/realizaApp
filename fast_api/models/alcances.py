'''CREATE TABLE ALCANCES(
ID_ALCANCES	int,
NOMBRE varchar(100) not null,
DESCRIPCION	text,
PRIMARY KEY(ID_ALCANCES)
);'''


from pydantic import BaseModel, Field
from typing import Optional
from datetime import date, datetime

class Alcances(BaseModel):

  # ge = Greater or equals, le = Lower o equals, gt = Greater than
    ID_ALCANCES: int = Field(gt=0)
    NOMBRE: str = Field(min_length=5, max_length=100)
    DESCRIPCION: str = Field(min_length=5, max_length=300)

