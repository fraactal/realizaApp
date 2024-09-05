'''CREATE TABLE PROYECTOS(
ID_PROYECTO int,
NOMBRE varchar(100),
DESCRIPCION text,
PRIMARY KEY(ID_PROYECTO)
);'''

from pydantic import BaseModel, Field
from typing import Optional

class Proyectos(BaseModel):

    # ge = Greater or equals, le = Lower o equals, gt = Greater than
    ID_PROYECTO: int = Field(gt = 0)
    NOMBRE: str = Field(min_length=5, max_length=100)
    DESCRIPCION: str = Field(min_length=5, max_length=300)
