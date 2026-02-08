const products = [
    {
        id: 1,
        name: "Vintage Vinyl Player",
        price: 1500000,
        description: "Pemutar piringan hitam klasik dengan kualitas suara premium.",
        imageUrl: "http://10.0.2.2:3000/images/product1.png"
    },
    {
        id: 2,
        name: "Bluetooth Speaker Retro",
        price: 750000,
        description: "Speaker portable dengan desain tahun 80-an tapi fitur modern.",
        imageUrl: "http://10.0.2.2:3000/images/product2.png"
    },
    {
        id: 3,
        name: "Classic Headphone",
        price: 500000,
        description: "Headphone kabel dengan bass yang nendang dan earpad nyaman.",
        imageUrl: "http://10.0.2.2:3000/images/product3.png"
    }
];

//with ipnya di set ke 10.0.2.2 dia lopoBack ke host

let reviews = [
    {
        id: 1, username: "Admin", content: "Barang bagus, pengiriman cepat!", productId: 1
    }
];

module.exports = {products, reviews};