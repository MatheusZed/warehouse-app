# README

## Sobre o Projeto

Este é um projeto de exercicio da turma 7 do programa Quero Ser Dev da Locaweb. O projeto consiste num sistema de gestão de galpões e de seus respectivos estoques de produtos.

## APP Version
  - Ruby [3.0.2]
  - [Lista de Gem](Gemfile)

## API

### Galpões

#### Listar todos os galpões

**Request**

```
GET /api/v1/warehouses
```

**Response**

Status: 200(OK)

```json
[
  {
    "id": 1,
    "name": "Osasco",
    "code": "OZC",
    "description": "Galpao de alto volume",
    "city": "Osasco",
    "state": "SP",
    "postal_code": "06162-000",
    "total_area": 2000,
    "useful_area": 1900,
    "product_category_warehouses": [
      {
        "product_category_id": 1
      }
    ]
  }
]
```

#### Buscar um galpão

**Request**

```
GET /api/v1/warehouses/:id
```

**Response**

Status: 200(OK)

```json
{
  "id": 1,
  "name": "Osasco",
  "code": "OZC",
  "description": "Galpao de alto volume",
  "city": "Osasco",
  "state": "SP",
  "postal_code": "06162-000",
  "total_area": 2000,
  "useful_area": 1900,
  "product_category_warehouses": [
    {
      "product_category_id": 1
    }
  ]
}
```

#### Criar um galpão

**Request**

```
POST /api/v1/warehouses
```

**Parameters**

```json
{
  "name": "Osasco",
  "code": "OZC",
  "description": "Galpao de alto volume",
  "address": "Av. Santo Antonio, 200",
  "city": "Osasco",
  "state": "SP",
  "postal_code": "06162-000",
  "total_area": 2000,
  "useful_area": 1900,
  "product_category_warehouses": [
    {
      "product_category_id": 1
    }
    {
      "product_category_id": 2
    }
  ]
}
```

**Response**

Status: 201(CREATED)

```json
{
  "id": 1,
  "name": "Osasco",
  "code": "OZC",
  "description": "Galpao de alto volume",
  "address": "Av. Santo Antonio, 200",
  "city": "Osasco",
  "state": "SP",
  "postal_code": "06162-000",
  "total_area": 2000,
  "useful_area": 1900,
  "product_category_warehouses": [
    {
      "product_category_id": 1
    }
    {
      "product_category_id": 2
    }
  ]
}
```

#### Editar um galpão

**Request**

```
PUT /api/v1/warehouses/:id
```

**Parameters**

```json
{
  "name": "Osasco",
  "code": "OZC",
  "description": "Galpao de alto volume",
  "address": "Av. Santo Antonio, 200",
  "city": "Osasco",
  "state": "SP",
  "postal_code": "06162-000",
  "total_area": 2000,
  "useful_area": 1900,
  "product_category_warehouses": [
    {
      "product_category_id": 1
    }
    {
      "product_category_id": 2
    }
  ]
}
```

**Response**

Status: 201(CREATED)

```json
{
  "id": 1,
  "name": "Osasco",
  "code": "OZC",
  "description": "Galpao de alto volume",
  "address": "Av. Santo Antonio, 200",
  "city": "Osasco",
  "state": "SP",
  "postal_code": "06162-000",
  "total_area": 2000,
  "useful_area": 1900,
  "product_category_warehouses": [
    {
      "product_category_id": 1
    }
    {
      "product_category_id": 2
    }
  ]
}
```

### Fornecedor

#### Listar todos os fornecedores

**Request**

```
GET /api/v1/suppliers
```

**Response**

Status: 200(OK)

```json
[
  {
    "id": 2,
    "fantasy_name": "Joao",
    "legal_name": "Joao e o Feijao",
    "email": "joao@feijao.com",
    "phone": "99999-9999"
  }
]
```

#### Buscar um fornecedor

**Request**

```
GET /api/v1/suppliers/:id
```

**Response**

Status: 200(OK)

```json
{
  "id": 2,
  "fantasy_name": "Joao",
  "legal_name": "Joao e o Feijao",
  "email": "joao@feijao.com",
  "phone": "99999-9999"
}
```

#### Criar um fornecedor

**Request**

```
POST /api/v1/suppliers
```

**Parameters**

```json
{
  "fantasy_name": "Joao",
  "legal_name": "Joao Doceria",
  "cnpj": "79885381000193",
  "address": "Av. Santo Antonio, 200",
  "email": "joao@doceria.com",
  "phone": "944875214"
}
```

**Response**

Status: 201(CREATED)

```json
{
  "id": 1,
  "fantasy_name": "Joao",
  "legal_name": "Joao Doceria",
  "cnpj": "79885381000193",
  "address": "Av. Santo Antonio, 200",
  "email": "joao@doceria.com",
  "phone": "944875214"
}
```

#### Editar um fornecedor

**Request**

```
PUT /api/v1/suppliers/:id
```

**Parameters**

```json
{
  "fantasy_name": "Joao",
  "legal_name": "Joao Doceria",
  "cnpj": "79885381000193",
  "address": "Av. Santo Antonio, 200",
  "email": "joao@doceria.com",
  "phone": "944875214"
}
```

**Response**

Status: 201(CREATED)

```json
{
  "id": 1,
  "fantasy_name": "Joao",
  "legal_name": "Joao Doceria",
  "cnpj": "79885381000193",
  "address": "Av. Santo Antonio, 200",
  "email": "joao@doceria.com",
  "phone": "944875214"
}
```

### Categoria de Produto

#### Listar todos as categorias de produto

**Request**

```
GET /api/v1/product_categories
```

**Response**

Status: 200(OK)

```json
[
  {
    "id": 1,
    "name": "Alimenticio"
  }
]
```

#### Buscar uma categoria de produto

**Request**

```
GET /api/v1/product_categories/:id
```

**Response**

Status: 200(OK)

```json
{
  "id": 1,
  "name": "Alimenticio"
}
```

#### Criar uma categoria de produto

**Request**

```
POST /api/v1/product_categories
```


**Parameters**

```json
{
  "name": "Refrigerados"
}
```

**Response**

Status: 201(CREATED)

```json
{
  "id": 1,
  "name": "Refrigerados"
}
```

#### Editar uma categoria de produto

**Request**

```
PUT /api/v1/product_categories/:id
```


**Parameters**

```json
{
  "name": "Refrigerados"
}
```

**Response**

Status: 201(CREATED)

```json
{
  "id": 1,
  "name": "Refrigerados"
}
```

### Modelo de Produto

#### Listar todos os modelos de produto

**Request**

```
GET /api/v1/product_models
```

**Response**

Status: 200(OK)

```json
[
  {
    "id": 1,
    "name": "Feijao",
    "weight": 1000,
    "height": 4,
    "width": 17,
    "length": 22,
    "sku": "SKUAOdnmSfo6Jr3VJiy8",
    "status": "active(0)/inactive(1)",
    "dimensions": "4 x 17 x 22",
    "supplier": {
      "id": 2,
      "fantasy_name": "Joao",
      "legal_name": "Joao e o Feijao",
      "email": "joao@feijao.com",
      "phone": "99999-9999"
    },
    "product_category": {
      "id": 1,
      "name": "Alimenticio"
    }
  }
]
```

#### Buscar um modelo de produto

**Request**

```
GET /api/v1/product_models/:id
```

**Response**

Status: 200(OK)

```json
{
  "id": 1,
  "name": "Feijao",
  "weight": 1000,
  "height": 4,
  "width": 17,
  "length": 22,
  "sku": "SKUAOdnmSfo6Jr3VJiy8",
  "status": "active(0)/inactive(1)",
  "dimensions": "4 x 17 x 22",
  "supplier": {
    "id": 2,
    "fantasy_name": "Joao",
    "legal_name": "Joao e o Feijao",
    "email": "joao@feijao.com",
    "phone": "99999-9999"
  },
  "product_category": {
    "id": 1,
    "name": "Alimenticio"
  }
}
```

#### Criar um modelo de produto

**Request**

```
POST /api/v1/product_models
```

**Parameters**

```json
{
  "name": "Capa de Celular",
  "weight": 50,
  "height": 10,
  "width": 5,
  "length": 2,
  "supplier_id": 1,
  "product_category_id": 1
}
```

**Response**

Status: 201(CREATED)

```json
{
  "id": 1,
  "name": "Capa de Celular",
  "weight": 50,
  "height": 10,
  "width": 5,
  "length": 2,
  "status": "active(0)",
  "sku": "SKU2shqLA14UskO8lQzF",
  "supplier_id": 1,
  "product_category_id": 1
}
```

#### Editar um modelo de produto

**Request**

```
PUT /api/v1/product_models/:id
```

**Parameters**

```json
{
  "name": "Capa de Celular",
  "weight": 50,
  "height": 10,
  "width": 5,
  "length": 2,
  "supplier_id": 1,
  "product_category_id": 1
}
```

**Response**

Status: 201(CREATED)

```json
{
  "id": 1,
  "name": "Capa de Celular",
  "weight": 50,
  "height": 10,
  "width": 5,
  "length": 2,
  "status": "active(0)",
  "sku": "SKU2shqLA14UskO8lQzF",
  "supplier_id": 1,
  "product_category_id": 1
}
```

### Kit de Produto

#### Listar todos os kits de produto

**Request**

```
GET /api/v1/product_bundles
```

**Response**

Status: 200(OK)

```json
[
  {
    "id": 1,
    "name": "Kit de Vinhos",
    "sku": "KSKUJn4OqGL08eEa1Yle4",
    "product_bundle_items": [
      {
        "product_model_id": 1
      },
      {
        "product_model_id": 2
      }
    ]
  }
]
```

#### Buscar um kit de produto

**Request**

```
GET /api/v1/product_bundles/:id
```

**Response**

Status: 200(OK)

```json
{
  "id": 1,
  "name": "Kit de Vinhos",
  "sku": "KSKUJn4OqGL08eEa1Yle4",
  "product_bundle_items": [
    {
      "product_model_id": 1
    },
    {
      "product_model_id": 2
    }
  ]
}
```

#### Criar um kit de produto

**Request**

```
POST /api/v1/product_bundles
```

**Parameters**

```json
{
  "name": "Kit de Vinhos",
  "product_model_ids": [
    {
      "product_model_id": 1
    },
    {
      "product_model_id": 2
    }
  ]
}
```

**Response**

Status: 201(CREATED)

```json
{
  "id": 1,
  "name": "Kit de Vinhos",
  "product_bundle_items": [
    {
      "product_model_id": 1
    },
    {
      "product_model_id": 2
    }
  ]
}
```

#### Editar um kit de produto

**Request**

```
PUT /api/v1/product_bundles/:id
```

**Parameters**

```json
{
  "name": "Kit de Vinhos",
  "product_model_ids": [
    {
      "product_model_id": 1
    },
    {
      "product_model_id": 2
    }
  ]
}
```

**Response**

Status: 201(CREATED)

```json
{
  "id": 1,
  "name": "Kit de Vinhos",
  "product_bundle_items": [
    {
      "product_model_id": 1
    },
    {
      "product_model_id": 2
    }
  ]
}
```

## Erros

| Response code |  Motivo                           |
| ------------- | ----------------------------------|
| 404  | O registro não foi encontrado              |
| 422  | A requisição está com parâmetros inválidos |
| 500  | Servidor não consegue processar requisição |