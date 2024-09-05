'''CREATE TABLE SUBCATEGORIAS(	
ID_SUBCATEGORIA	int,
ID_CATEGORIA int,
NOMBRE	varchar(100) not null,
DESCRIPCION	text,
PRIMARY KEY(ID_SUBCATEGORIA),
   CONSTRAINT fk_categoria
      FOREIGN KEY(ID_CATEGORIA) 
        REFERENCES CATEGORIAS(ID_CATEGORIA)
);'''

from pydantic import BaseModel, Field
from typing import Optional
from datetime import date, datetime

class SubCategorias(BaseModel):

    # ge = Greater or equals, le = Lower o equals, gt = Greater than
    ID_SUBCATEGORIA: int = Field(gt=0)
    ID_CATEGORIA: int = Field(gt=0)
    NOMBRE: str = Field(min_length=5, max_length=150)
    DESCRIPCION: str = Field(min_length=5, max_length=300)

