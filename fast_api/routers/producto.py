from fastapi import APIRouter, Path, Query
from models.producto import Product


router = APIRouter()


productos = [
    {
        "id":1,
        "name":"Product 1",
        "price":20,
        "stock":10
    },
    {
        "id":2,
        "name":"Product 2",
        "price":30,
        "stock":15
    }
    ]

@router.get('/products')
def get_products():
    return productos

@router.get('/products/{id}')
#Al agregar el path como parametro, se hace una validación
def get_product(id: int = Path(gt=0)):
    return list(filter(lambda item:item['id']==id, productos))

#products/?stock=10&price=20
@router.get('/products/')
def get_products_by_stock(stock:int, price:float = Query(gt=0)):
    return list(filter(lambda item:item['stock']==stock and item['price']==price,
                       productos))

@router.post('/products')
def create_product(producto: Product):
    productos.append(producto)

@router.put('/products/{id}')
def update_products(id: int, producto: Product):
    for index, item in enumerate(productos):
        if item['id'] == id:
            productos[index]['name'] = producto.name
            productos[index]['stock'] = producto.stock
            productos[index]['price'] = producto.price
    return productos

@router.delete('/products/{id}')
def delete_product(id: int):
    for item in productos:
        if item['id'] == id:
            productos.remove(item)
    return productos
