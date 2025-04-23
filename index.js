const express = require("express");
const fs = require("fs");
const path = require("path");

const app = express();
app.use(express.json()); 

app.get("/posts", (req, res) => {
  const filePath = path.join(__dirname, "data", "data.json");

  fs.readFile(filePath, "utf8", (err, data) => {
    if (err) {
      return res.status(500).json({ message: "Error reading data" });
    }

    try {
      const posts = JSON.parse(data); 
      const formatted = JSON.stringify(posts, null, 2);
      res.setHeader("Content-Type", "application/json");
      // res.send();
      res.status(200).json(formatted);  
    } catch (parseError) {
      res.status(500).json({ message: "Error parsing data" });
    }
  });
});

const port = 9001;

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
