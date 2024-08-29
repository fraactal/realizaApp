from fastapi import FastAPI
#from routers.producto import router as product_router
from routers.consumo import router as consumos_router

app = FastAPI()

@app.get('/')
def index():
    return "Hello World"

#app.include_router(product_router)
app.include_router(consumos_router)
