'''CREATE TABLE UNIDAD_FUENTE(
ID_UNIDAD_FUENTE int,
NOMBRE varchar(100) not null,
SIGLA	varchar(15) not null,
PRIMARY KEY(ID_UNIDAD_FUENTE)
);'''

from pydantic import BaseModel, Field
from typing import Optional

class UnidadFuente(BaseModel):

    # ge = Greater or equals, le = Lower o equals, gt = Greater than
    ID_UNIDAD_FUENTE: int = Field(gt = 0)
    NOMBRE: str = Field(min_length=5, max_length=100)
    SIGLA: str = Field(min_length=5, max_length=15)