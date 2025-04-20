const express = require("express");
const fs = require("fs");
const path = require("path");

const app = express();
app.use(express.json);

app.get("/posts", (req, res) => {
  const filePath = path.join(__dirname, 'data/data.json');

  fs.readFile(filePath, "utf8", () => {
    if (err) {
      return res.status(500).json({ message: "Error reading data" });
    }

    const posts = JSON.parse.data();
    res.status(200).JSON(posts);
  })


  res.status(200).json(posts);
});

const port = 9001;

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
