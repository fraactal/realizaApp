'''CREATE TABLE USUARIO(
ID_USUARIO varchar(100),
ID_PROYECTO int not null,
ID_CAMPUS int not null,
PASS text not null,
NOMBRE varchar(100) not null,
CORREO varchar(100),
TIPO_USUARIO char(1),  -- Admin (A) --> crear, modificar, eliminar, ver - USER(U)  --> Crear, Ver
ACTIVO boolean not null,
PRIMARY KEY(ID_USUARIO),
   CONSTRAINT fk_u_campus
      FOREIGN KEY(ID_CAMPUS) 
        REFERENCES CAMPUS(ID_CAMPUS)
);'''

from pydantic import BaseModel, Field
from typing import Optional
from datetime import date, datetime

class Usuario(BaseModel):

    # ge = Greater or equals, le = Lower o equals, gt = Greater than
    ID_USUARIO: int = Field(gt=0)
    ID_PROYECTO: int = Field(gt=0)
    ID_CAMPUS: int = Field(gt=0)
    #PASS
    NOMBRE: str = Field(min_length=5, max_length=100)
    CORREO: str = Field(min_length=5, max_length=100)
    TIPO_USUARIO: str = Field(min_length=1, max_length=1)
    ACTIVO: bool = Field(default='0')

