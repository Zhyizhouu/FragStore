const express = require('express')
const cors = require('cors')
const app = express()
const port = 3000

app.use(cors())
app.use(express.json())

let products = [
    {
        id: "p1",
        name: "Logitech G Pro X Superlight",
        description: "Ultra-lightweight wireless gaming mouse designed for esports pros. Hero 25K sensor.",
        price: 2199000,
        imageUrl: "https://resource.logitech.com/w_692,c_lpad,ar_4:3,q_auto,f_auto,dpr_1.0/d_transparent.gif/content/dam/gaming/en/products/pro-x-superlight/pro-x-superlight-black-gallery-1.png",
        rating: 4.8
    },
    {
        id: "p2",
        name: "Razer Huntsman V2",
        description: "Optical gaming keyboard with near-zero latency and analog optical switches.",
        price: 3499000,
        imageUrl: "https://assets3.razerzone.com/S-eA1E_5aJ1P2bKjZz6fX_t8u7g=/1500x1000/https%3A%2F%2Fhybrismediaprod.blob.core.windows.net%2Fsys-master-phoenix-images-container%2Fh0d%2Fh3e%2F9186641608734%2Frazer-huntsman-v2-tenkeyless-linear-optical-switch-black-500x500.png",
        rating: 4.6
    },
    {
        id: "p3",
        name: "HyperX Cloud II Wireless",
        description: "Legendary comfort and durability with high-speed wireless connection.",
        price: 1899000,
        imageUrl: "https://row.hyperx.com/cdn/shop/products/hyperx_cloud_ii_wireless_red_1_main_900x.png?v=1661292021",
        rating: 4.7
    }
]

app.get('/api/products', (req, res) => {
    res.json(products)
})

app.get('/api/products/:id', (req, res) => {
    const product = products.find(p => p.id === req.params.id)
    if (!product) return res.status(404).json({messaage: "Product isn;t found"})
    res.json(product)
})

app.post('/api/products', (req, res) => {
    const newProduct = {
        id : Date.now().toString(),
        name : req.body.name,
        description : req.body.description,
        price : Number(req.body.price),
        imageUrl : req.body.imageUrl || "data:image/png;base64,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",
        rating : req.body.rating || 0
    }
    products.push(newProduct)
    res.status(201).json(newProduct)
})

app.put('/api/products/:id', (req, res) => {
    const index = products.findIndex(p => p.id === req.params.id)
    if (index === -1) return res.status(404).json({message : "Product not found"})

    products[index] = {
        ...products[index],
        ...req.body,
        price : req.body.price ? Number(req.body.price) : products[index].price
    }
    res.json(products[index])
})

app.delete('/api/products/:id', (req, res) => {
    const index = products.findIndex(p => p.id === req.params.id)
    if (index === -1) return res.status(404).json({message: "Product not found"})
    
    const deletedProduct = products.splice(index, 1)
    res.json(deletedProduct[0])
})

app.listen(port, ()=> {
    console.log(`Server runnig on http://localhost:${port}`)
})