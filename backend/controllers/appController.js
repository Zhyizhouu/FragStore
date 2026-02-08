const {products, reviews} = require('../models/dataStore');

exports.getProducts = (req, res) => {
    res.status(200).json({
        success: true,
        data: products
    })
};

exports.getReviews = (req, res) => {
    res.status(200).json({
        success: true,
        data: reviews
    });
};

exports.addReview = (req, res) => {
    
    const { username, content, productId } = req.body;

    if (!username || !content) {
        return res.status(400).json({
            success: false,
            message: "Username / content review can't be null"
        });
    }

}

const newReview = {
    id : reviews.length + 1,
    username,
    content,
    productId: 
}