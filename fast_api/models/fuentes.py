'''CREATE TABLE FUENTE(
ID_FUENTE int,
NOMBRE varchar(150) not null, -- Viajes de negocios - Terrestre - Vehículo particular - gasolina
--ID_FACTOR_EMISION	int, -- No va idFactorEmision. Se debe pasar a la tabla FACTOR_DE_EMISION el idFuente
ID_UNIDAD_FUENTE	int,
ID_ALCANCES int,
ID_CATEGORIA int,
ID_SUBCATEGORIA int,
PRIMARY KEY(ID_FUENTE),
    CONSTRAINT fk_f_alcance
      FOREIGN KEY(ID_ALCANCES) 
        REFERENCES ALCANCES(ID_ALCANCES),
    CONSTRAINT fk_f_categoria
      FOREIGN KEY(ID_CATEGORIA) 
        REFERENCES CATEGORIAS(ID_CATEGORIA),
    CONSTRAINT fk_f_subcategoria
      FOREIGN KEY(ID_SUBCATEGORIA) 
        REFERENCES SUBCATEGORIAS(ID_SUBCATEGORIA),
    CONSTRAINT fk_f_unidad_fuente
      FOREIGN KEY(ID_UNIDAD_FUENTE) 
        REFERENCES UNIDAD_FUENTE(ID_UNIDAD_FUENTE)
);'''


from pydantic import BaseModel, Field
from typing import Optional
from datetime import date, datetime

class Fuente(BaseModel):

    # ge = Greater or equals, le = Lower o equals, gt = Greater than
    ID_FUENTE: int = Field(gt = 0)
    NOMBRE: str = Field(min_length=5, max_length=150)
    ID_UNIDAD_FUENTE: int = Field(gt=0)
    ID_ALCANCES: int = Field(gt=0)
    ID_CATEGORIA: int = Field(gt=0)
    ID_SUBCATEGORIA: int = Field(gt=0)

