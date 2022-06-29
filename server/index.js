const express = require('express')
const app = express()
const PORT = 3000

app.get('/', function (req, res) {
    res.send('Hello World')
})

app.listen(3000, '0.0.0.0', () => {
    console.log(`connected at port ${PORT}`);
})
