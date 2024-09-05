'''CREATE TABLE CATEGORIAS(	
ID_CATEGORIA int,
NOMBRE varchar(150) not null,
DESCRIPCION	text,
PRIMARY KEY(ID_CATEGORIA)
);'''

from pydantic import BaseModel, Field
from typing import Optional
from datetime import date, datetime

class Categorias(BaseModel):

  # ge = Greater or equals, le = Lower o equals, gt = Greater than
    ID_CATEGORIA: int = Field(gt=0)
    NOMBRE: str = Field(min_length=5, max_length=150)
    DESCRIPCION: str = Field(min_length=5, max_length=300)


